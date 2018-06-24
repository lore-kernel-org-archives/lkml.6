Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB3C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A86925074
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A86925074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756004AbeFXPlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:41:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755737AbeFXPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:41:36 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 924AD49F;
        Sun, 24 Jun 2018 15:41:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+df47f81c226b31d89fb1@syzkaller.appspotmail.com>
Subject: [PATCH 4.17 22/70] driver core: Dont ignore class_dir_create_and_add() failure.
Date:   Sun, 24 Jun 2018 23:22:14 +0800
Message-Id: <20180624142741.851579120@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1467,7 +1467,7 @@ class_dir_create_and_add(struct class *c
 
 	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
 	if (!dir)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	dir->class = class;
 	kobject_init(&dir->kobj, &class_dir_ktype);
@@ -1477,7 +1477,7 @@ class_dir_create_and_add(struct class *c
 	retval = kobject_add(&dir->kobj, parent_kobj, "%s", class->name);
 	if (retval < 0) {
 		kobject_put(&dir->kobj);
-		return NULL;
+		return ERR_PTR(retval);
 	}
 	return &dir->kobj;
 }
@@ -1784,6 +1784,10 @@ int device_add(struct device *dev)
 
 	parent = get_device(dev->parent);
 	kobj = get_device_parent(dev, parent);
+	if (IS_ERR(kobj)) {
+		error = PTR_ERR(kobj);
+		goto parent_error;
+	}
 	if (kobj)
 		dev->kobj.parent = kobj;
 
@@ -1882,6 +1886,7 @@ done:
 	kobject_del(&dev->kobj);
  Error:
 	cleanup_glue_dir(dev, glue_dir);
+parent_error:
 	put_device(parent);
 name_error:
 	kfree(dev->p);
@@ -2701,6 +2706,11 @@ int device_move(struct device *dev, stru
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


