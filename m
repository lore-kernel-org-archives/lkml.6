Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6390AC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E70120656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/cax459"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfANWEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:04:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35912 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfANWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so259085pgm.3;
        Mon, 14 Jan 2019 14:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=atdq442LD9LsMFrYiC+F33UAnilzt6PIC1hqbs+cWdM=;
        b=L/cax459GXQ4hMiQcolyFnGOa4OB0J80Ag2d1dV1HDq/S0YDMgWnH8/K/P9X4F878B
         6+69k0a9yvI/SJupP/vn4a6B2A1UPRlRT9XUfn4RX2YXc3mgDKEh7+3P7GR7zqc2httC
         ogZJhe8KY0ATXpN7r5NvSabtbbogZfHiVHRtg4bXkJ899k/9idZKmuG0bZ8oyqFAP87y
         lXtDljrAJzJ/I4gargWqEIXAq1awvJ2cKjutDNvbsNoHmuBzvk1Jqu0PgDKmmsFSqu4W
         oimc3NClMpeSXV6iLdRXtjWCSKhq0GS9OJfqDck/+ZKXN95GUDw+FORd9mw1u8iSaWDn
         vwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=atdq442LD9LsMFrYiC+F33UAnilzt6PIC1hqbs+cWdM=;
        b=IF3DlQcAdBKxjVc+2K8wCAihkgtL3NEM0yM6jNie2JgTSMuKc80mLJSnuQhFteN7/U
         pbjYTfRdl3mgoh3EE5rtZ7rzlcqW7pdVyrnkOC0mWtIY+chRr7gM//se/8d61+ODXpAv
         d2q+Z5cJ85luQwFzzvFV9YlD9hdzWuAoITzu57lvTakakNVlVe9RQdZ9Cuyq79sDRTRD
         2kvLt4HADR0dAIzUfCnzn7gsm6PLrmCjG+4l3n4tGNo91BpE+zsfjKbUqApkmGG6ymbk
         pZvScUM8xLcy457QOYhDiTJDiEYP8CGTkXpL+jzc3KYUxhync5DtF+NNnVmaVv7hB4AZ
         XOVQ==
X-Gm-Message-State: AJcUukfqFgl4hH4w6rD0miwg3Wz4ZMlCKDJbFUPJiNTS8sw3p+Hx9bjs
        pBQXyWsNTwuw9PSfPJ2obtBiL7/s
X-Google-Smtp-Source: ALg8bN6l1MJi0pfIAuIMHE2pdf2oM2/vVX5OKAhbd8CiJdPzfowqmmxkU+PKu3tTNRssIhrBhzn5RA==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr600308pge.437.1547503491647;
        Mon, 14 Jan 2019 14:04:51 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g15sm5325769pfj.131.2019.01.14.14.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:04:50 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:04:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>, rydberg@bitmath.org,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: uinput - fix undefined behavior in
 uinput_validate_absinfo()
Message-ID: <20190114220448.GA241112@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An integer overflow may arise in uinput_validate_absinfo() if "max - min"
can't be represented by an "int". We should check for overflow before
trying to use the result.

Reported-by: Kyungtae Kim <kt0755@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 8ec483e8688b..26ec603fe220 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -39,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/overflow.h>
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
@@ -405,7 +406,7 @@ static int uinput_open(struct inode *inode, struct file *file)
 static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 				   const struct input_absinfo *abs)
 {
-	int min, max;
+	int min, max, range;
 
 	min = abs->minimum;
 	max = abs->maximum;
@@ -417,7 +418,7 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 		return -EINVAL;
 	}
 
-	if (abs->flat > max - min) {
+	if (check_sub_overflow(max, min, &range) && abs->flat > range) {
 		printk(KERN_DEBUG
 		       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
 		       UINPUT_NAME, code, abs->flat, min, max);
-- 
2.20.1.97.g81188d93c3-goog


-- 
Dmitry
