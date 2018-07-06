Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE8AC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6505B20877
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6505B20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeGFFtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:49:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932910AbeGFFtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:49:19 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65BCBBC1;
        Fri,  6 Jul 2018 05:49:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+17a8efdf800000@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH 4.17 16/46] vt: prevent leaking uninitialized data to userspace via /dev/vcs*
Date:   Fri,  6 Jul 2018 07:46:37 +0200
Message-Id: <20180706054525.376507928@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
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

From: Alexander Potapenko <glider@google.com>

commit 21eff69aaaa0e766ca0ce445b477698dc6a9f55a upstream.

KMSAN reported an infoleak when reading from /dev/vcs*:

  BUG: KMSAN: kernel-infoleak in vcs_read+0x18ba/0x1cc0
  Call Trace:
  ...
   kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1253
   copy_to_user ./include/linux/uaccess.h:184
   vcs_read+0x18ba/0x1cc0 drivers/tty/vt/vc_screen.c:352
   __vfs_read+0x1b2/0x9d0 fs/read_write.c:416
   vfs_read+0x36c/0x6b0 fs/read_write.c:452
  ...
  Uninit was created at:
   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279
   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:189
   kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:315
   __kmalloc+0x13a/0x350 mm/slub.c:3818
   kmalloc ./include/linux/slab.h:517
   vc_allocate+0x438/0x800 drivers/tty/vt/vt.c:787
   con_install+0x8c/0x640 drivers/tty/vt/vt.c:2880
   tty_driver_install_tty drivers/tty/tty_io.c:1224
   tty_init_dev+0x1b5/0x1020 drivers/tty/tty_io.c:1324
   tty_open_by_driver drivers/tty/tty_io.c:1959
   tty_open+0x17b4/0x2ed0 drivers/tty/tty_io.c:2007
   chrdev_open+0xc25/0xd90 fs/char_dev.c:417
   do_dentry_open+0xccc/0x1440 fs/open.c:794
   vfs_open+0x1b6/0x2f0 fs/open.c:908
  ...
  Bytes 0-79 of 240 are uninitialized

Consistently allocating |vc_screenbuf| with kzalloc() fixes the problem

Reported-by: syzbot+17a8efdf800000@syzkaller.appspotmail.com
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -784,7 +784,7 @@ int vc_allocate(unsigned int currcons)	/
 	if (!*vc->vc_uni_pagedir_loc)
 		con_set_default_unimap(vc);
 
-	vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
+	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
 	if (!vc->vc_screenbuf)
 		goto err_free;
 
@@ -871,7 +871,7 @@ static int vc_do_resize(struct tty_struc
 
 	if (new_screen_size > (4 << 20))
 		return -EINVAL;
-	newscreen = kmalloc(new_screen_size, GFP_USER);
+	newscreen = kzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
 


