Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317AEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EC52075C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278513;
	bh=FJblxdGoqIjFaQ6PJO1hq+chfKtv6YBkKFWa2H4Hv4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dvRangAyJ59uGXqb3O3yY9J8EoWQyB5Q36yrdAGIPY+d/L4KEZS3raTiEDu1QAheG
	 dAy2rDZfUYyyZnTcGjztCeKobpsxmKYk+iBr2LRnlJduhRGxBtg66Ie9rLCsk8RjF8
	 pllrqexDd5DFWBVSwHpGmyA0aRWum4Z7exCQ+oFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfBDLIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbfBDKlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6994B217D6;
        Mon,  4 Feb 2019 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276901;
        bh=FJblxdGoqIjFaQ6PJO1hq+chfKtv6YBkKFWa2H4Hv4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOaKcXRPJcTWfhuQFbfZORUIPi5sz5SV7yrxhoTsSWIt2zmH+bEF5tHKF5nYSi/l6
         F5PVEmFJhh14AVGo/g6OnI/u5zvGViLJUzS5yZFv6joMlm2bvWp4IIhzF4yvJ1mjZt
         It9Xrj0dolZfU6aE+aBXaKA5k/L9fezGB3j3F3uM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Zubin Mithra <zsm@chromium.org>,
        Guenter Roeck <groeck@google.com>
Subject: [PATCH 4.4 53/65] drivers: core: Remove glue dirs from sysfs earlier
Date:   Mon,  4 Feb 2019 11:36:46 +0100
Message-Id: <20190204103619.370839354@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 726e41097920a73e4c7c33385dcc0debb1281e18 upstream.

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
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Cc: Guenter Roeck <groeck@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c     |    2 ++
 include/linux/kobject.h |   17 +++++++++++++++++
 2 files changed, 19 insertions(+)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -862,6 +862,8 @@ static void cleanup_glue_dir(struct devi
 		return;
 
 	mutex_lock(&gdp_mutex);
+	if (!kobject_has_children(glue_dir))
+		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
 }
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -113,6 +113,23 @@ extern void kobject_put(struct kobject *
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
+	WARN_ON_ONCE(atomic_read(&kobj->kref.refcount) == 0);
+
+	return kobj->sd && kobj->sd->dir.subdirs;
+}
+
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;


