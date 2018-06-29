Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED5C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145DA272D8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145DA272D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967734AbeF2DEL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:04:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:56361 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965373AbeF2DEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:04:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5T2LwGc022160;
        Thu, 28 Jun 2018 21:22:00 -0500
Message-ID: <ac64e45950c8e3df26fd50e7b251d5895c1d2201.camel@kernel.crashing.org>
Subject: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 29 Jun 2018 12:21:58 +1000
In-Reply-To: <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
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
this is left to the implicit sysfs removal done by kobjects when
they are released on the last kobject_put().

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
mutex that can be enhanced for this.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

(Adding lkml, I just realized I completely forgot to CC it in
the first place on this whole conversation, blame the 1am debugging
session)

 drivers/base/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e9eff2099896..66e15daa9980 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1436,6 +1436,13 @@ struct kobject *virtual_device_parent(struct device *dev)
 struct class_dir {
 	struct kobject kobj;
 	struct class *class;
+
+	/*
+	 * This counts the number of children of the gluedir in
+	 * order to "cleanly" kobject_del() it when it becomes
+	 * empty. It is protected by the gdb_mutex
+	 */
+	unsigned int child_count;
 };
 
 #define to_class_dir(obj) container_of(obj, struct class_dir, kobj)
@@ -1470,6 +1477,7 @@ class_dir_create_and_add(struct class *class, struct kobject *parent_kobj)
 		return NULL;
 
 	dir->class = class;
+	dir->child_count = 1;
 	kobject_init(&dir->kobj, &class_dir_ktype);
 
 	dir->kobj.kset = &class->p->glue_dirs;
@@ -1526,6 +1534,8 @@ static struct kobject *get_device_parent(struct device *dev,
 		}
 		spin_unlock(&dev->class->p->glue_dirs.list_lock);
 		if (kobj) {
+			struct class_dir *class_dir = to_class_dir(kobj);
+			class_dir->child_count++;
 			mutex_unlock(&gdp_mutex);
 			return kobj;
 		}
@@ -1567,11 +1577,18 @@ static inline struct kobject *get_glue_dir(struct device *dev)
  */
 static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 {
+	struct class_dir *class_dir = to_class_dir(glue_dir);
+
 	/* see if we live in a "glue" directory */
 	if (!live_in_glue_dir(glue_dir, dev))
 		return;
 
 	mutex_lock(&gdp_mutex);
+	if (WARN_ON(class_dir->child_count == 0))
+		goto bail;
+	if (--class_dir->child_count == 0)
+		kobject_del(glue_dir);
+ bail:
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
 }
