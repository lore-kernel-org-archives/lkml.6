Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B128C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FD02080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FD02080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeKLFy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51810 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbeKLFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:57 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000lG-4U; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001QD-0h; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "syzbot" <syzbot+df47f81c226b31d89fb1@syzkaller.appspotmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.452624345@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 052/366] driver core: Don't ignore class_dir_create_and_add()
 failure.
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 84d0c27d6233a9ba0578b20f5a09701eb66cee42 upstream.

syzbot is hitting WARN() at kernfs_add_one() [1].
This is because kernfs_create_link() is confused by previous device_add()
call which continued without setting dev->kobj.parent field when
get_device_parent() failed by memory allocation fault injection.
Fix this by propagating the error from class_dir_create_and_add() to
the calllers of get_device_parent().

[1] https://syzkaller.appspot.com/bug?id=fae0fb607989ea744526d1c082a5b8de6529116f

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+df47f81c226b31d89fb1@syzkaller.appspotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/base/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -709,7 +709,7 @@ class_dir_create_and_add(struct class *c
 
 	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
 	if (!dir)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	dir->class = class;
 	kobject_init(&dir->kobj, &class_dir_ktype);
@@ -719,7 +719,7 @@ class_dir_create_and_add(struct class *c
 	retval = kobject_add(&dir->kobj, parent_kobj, "%s", class->name);
 	if (retval < 0) {
 		kobject_put(&dir->kobj);
-		return NULL;
+		return ERR_PTR(retval);
 	}
 	return &dir->kobj;
 }
@@ -1000,6 +1000,10 @@ int device_add(struct device *dev)
 
 	parent = get_device(dev->parent);
 	kobj = get_device_parent(dev, parent);
+	if (IS_ERR(kobj)) {
+		error = PTR_ERR(kobj);
+		goto parent_error;
+	}
 	if (kobj)
 		dev->kobj.parent = kobj;
 
@@ -1097,6 +1101,7 @@ done:
 	kobject_del(&dev->kobj);
  Error:
 	cleanup_device_parent(dev);
+parent_error:
 	if (parent)
 		put_device(parent);
 name_error:
@@ -1867,6 +1872,11 @@ int device_move(struct device *dev, stru
 	device_pm_lock();
 	new_parent = get_device(new_parent);
 	new_parent_kobj = get_device_parent(dev, new_parent);
+	if (IS_ERR(new_parent_kobj)) {
+		error = PTR_ERR(new_parent_kobj);
+		put_device(new_parent);
+		goto out;
+	}
 
 	pr_debug("device: '%s': %s: moving to '%s'\n", dev_name(dev),
 		 __func__, new_parent ? dev_name(new_parent) : "<NULL>");

