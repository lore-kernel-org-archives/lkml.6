Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35875C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE0A20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyWiGAU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE0A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeLAOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:01:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40492 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeLAOBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:01:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so3284760pgp.7;
        Fri, 30 Nov 2018 18:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hTIRvUd5wZUekGQOF0tlh90RkXKs8zi6rQXpkbEu5zI=;
        b=cyWiGAU5Gcd7C8DHaRAE8yBLmVqVHYS0dfQwRf7vH5eKaGKlr209o541DkFctHiboL
         AFdV2G4SC3XTdONJ8mN8ZCxdxwOfZ8oR90lNhLVFBQNyWhz1lfRFQAABi4lPduptMI32
         LJhDQqekCEgGTmJ2I6/SlZYmx/lpxZnKBL5jo0yZ1plO5Q8SEpP9nYv4D2TgDg2ZwlO0
         3pUNyJ3R6nz5C/ZjNp3EqeK6J1SatXqXo3E6wYQEanPyITbVowJc7iqQhqITGokkPHmP
         GZr3BMflc1TZBGhKDiCGbQHkixYCwuVBfuxWKgGUtfw7RZ3UcUbrxh5pilk4+MLTWZoc
         38uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hTIRvUd5wZUekGQOF0tlh90RkXKs8zi6rQXpkbEu5zI=;
        b=fyqfjH1F7acCukOQJxTf49bbdCpHXaHzC8/YflVO4LcdZP2uU4hbaxV4qcKIwRRrAz
         H2jW99pR1rtqIVWwHVwLCOQ0+iAfPqpkl8e2cgHhAtRXmFpe59X+ooKGnuODHHZrMqWB
         WaPnIRaFAx7rGTqLoTzuDD3Kcz91GrFPp6MI9ZrPJiBrqR3Z5jSi4lsUuZXtHu4n2OsZ
         ZwVr+wGBk9QmXKLhlTTcpGAvZrLABczNx7t2Y+3YOOjqwIDJL10kyn7vObDNQdo9MC2y
         uT6bWRnw+9w5Gmm+o5JOx0N0t1qs1lK7eoF5DdHQpIAfLPS5X7bLTqFgJrOCHSM343Gx
         caiA==
X-Gm-Message-State: AA+aEWYMbZ8EeEHV7rDrkp5o3dWBU8To+9VD+IEErOt0ptvKDMNg0qXB
        aeO+BqQGvj1QcectOS5DbpI=
X-Google-Smtp-Source: AFSGD/U2tYSKcn8Aslghb8ywczxnyFg+LCpffl2JiHEubYxuwaNb6fPYpNwl09Xa++eyLbZIF73zrg==
X-Received: by 2002:a63:5346:: with SMTP id t6mr6947931pgl.40.1543632593510;
        Fri, 30 Nov 2018 18:49:53 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id w11sm6931213pgk.16.2018.11.30.18.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:49:52 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] HID: debug: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 21:49:51 -0500
Message-Id: <20181201024951.5508-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/hid/hid-debug.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index b48100236df8..c530476edba6 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1072,11 +1072,6 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	return 0;
 }
 
-static int hid_debug_rdesc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hid_debug_rdesc_show, inode->i_private);
-}
-
 static int hid_debug_events_open(struct inode *inode, struct file *file)
 {
 	int err = 0;
@@ -1211,12 +1206,7 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static const struct file_operations hid_debug_rdesc_fops = {
-	.open           = hid_debug_rdesc_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(hid_debug_rdesc);
 
 static const struct file_operations hid_debug_events_fops = {
 	.owner =        THIS_MODULE,
-- 
2.17.0

