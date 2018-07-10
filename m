Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEFAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A018520849
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A018520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbeGJA32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:29:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:49314 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeGJA3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:29:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6A0TAxO026799;
        Mon, 9 Jul 2018 19:29:11 -0500
Message-ID: <70f1312e76a9f53bf7749525ea881272c7007a34.camel@kernel.crashing.org>
Subject: [PATCH v2 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Jul 2018 10:29:10 +1000
In-Reply-To: <CA+55aFx-UX8nxewRFFWdBgYfPqfipnxaqJuJCUni9h4JvhoPFw@mail.gmail.com>
References: <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
         <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
         <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
         <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
         <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
         <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
         <CA+55aFzKmzC-2_6+RsRRu9KfK_r=UGgLN2Q0hSNBV=ScGR7=8g@mail.gmail.com>
         <6e3ca577f8dd5f3621d1054447d3f928a73dfcf9.camel@kernel.crashing.org>
         <CA+55aFy+ZSu5cPzk887N-ZgXqvTB=Bp1JQYMWT1SZY81MqLH6Q@mail.gmail.com>
         <1bc873980e7f63291fbe19dbc7e1607b8e126241.camel@kernel.crashing.org>
         <20180707164241.GB16279@kroah.com>
         <CA+55aFx-UX8nxewRFFWdBgYfPqfipnxaqJuJCUni9h4JvhoPFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices with a class, we create a "glue" directory between
the parent device and the new device with the class name.

This directory is never "explicitely" removed when empty however,
this is left to the implicit sysfs removal done by kobject_release()
when the object loses its last reference via kobject_put().

This is problematic because as long as it's not been removed from
sysfs, it is still present in the class kset and in sysfs directory
structure.

The presence in the class kset exposes a use after free bug fixed
by the previous patch, but the presence in sysfs means that until
the kobject is released, which can take a while (especially with
kobject debugging), any attempt at re-creating such as binding a
new device for that class/parent pair, will result in a sysfs
duplicate file name error.

This fixes it by instead doing an explicit kobject_del() when
the glue dir is empty, by keeping track of the number of
child devices of the gluedir.

This is made easy by the fact that all glue dir operations are
done with a global mutex, and there's already a function
(cleanup_glue_dir) called in all the right places taking that
mutex that can be enhanced for this. It appears that this was
in fact the intent of the function, but the implementation was
wrong.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/base/core.c     |  2 ++
 include/linux/kobject.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e9eff2099896..93c0f8d1a447 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1572,6 +1572,8 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 		return;
 
 	mutex_lock(&gdp_mutex);
+	if (!kobject_has_children(glue_dir))
+		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
 }
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7f6f93c3df9c..270b40515e79 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -116,6 +116,23 @@ extern void kobject_put(struct kobject *kobj);
 extern const void *kobject_namespace(struct kobject *kobj);
 extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
 
+/**
+ * kobject_has_children - Returns whether a kobject has children.
+ * @kobj: the object to test
+ *
+ * This will return whether a kobject has other kobjects as children.
+ *
+ * It does NOT account for the presence of attribute files, only sub
+ * directories. It also assumes there is no concurrent addition or
+ * removal of such children, and thus relies on external locking.
+ */
+static inline bool kobject_has_children(struct kobject *kobj)
+{
+	WARN_ON_ONCE(kref_read(&kobj->kref) == 0);
+
+	return kobj->sd && kobj->sd->dir.subdirs;
+}
+
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;

