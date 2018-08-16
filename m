Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A4121470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OkfbIdX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A4121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbeHPQgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:36:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39438 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391636AbeHPQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:36:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so2694780edi.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ulmo5s7uX0cJuFfy+70Dejg7erdoQQn+Sh2MGhAo2Js=;
        b=OkfbIdX4Qbzs7FSET/XjHRnpXDGVptcrs8OjvOVG/2Cue9/Rm6P0Q4Gww2Nedxnl82
         iO5vPOseOSYLGCMVO5FIcxYVO/F6GXWqJt68R3xVFBrOUn6mWReZeJ57auC52icZ8yKa
         orcxff31tsh9E5uXR3Ox6PSK4WBIczHzY4OVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ulmo5s7uX0cJuFfy+70Dejg7erdoQQn+Sh2MGhAo2Js=;
        b=KzUviJCG88n0fAQmf58kQ1ddScA2/sjJAMCnP+CQHVKWTe72RRdbkhyXh5V7cva8Dt
         YP+o/fSswqyJBPYtqo1sKHz9rGKP8rKv2WJynbhVj2FC9BliYK3+VhXPDhMDfmoOf7fL
         T53gTUWvz40vkW0SkbMNVVPnHSstwGCDns36BXWRs3DUy37hyIXonai1ZvR1TW6h8zU8
         fV1ojVrtVsUaR30R8++vxFn9KWhWnt42GpeYtbS30duGEaO1iILphaHH74Ty/3E4Sa+W
         s5z/+TnAcwScK0HGG5BfYOFmDCHoNMciPp/2VugWQiEow+v4/D9QTiCVl7E1hq+0fG0u
         v9eg==
X-Gm-Message-State: AOUpUlGiPjJPXz1K0C6xaZDJBaGsYaUAGy4IjwYL82Gi9zAacFCGjLvj
        5Tdhlv2rpc/MkARRguzEQ9VEPw==
X-Google-Smtp-Source: AA+uWPyOIn4M5rLXSXNzP1UvMK84li5KXpCbWoyn2fp5W07EowUBYVO2T/Q8C79iOnC+ze86xtRfig==
X-Received: by 2002:a50:83e6:: with SMTP id 93-v6mr36070743edi.164.1534426654888;
        Thu, 16 Aug 2018 06:37:34 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-120-115.cgn.ip.fibianet.dk. [5.186.120.115])
        by smtp.gmail.com with ESMTPSA id u25-v6sm831443edm.45.2018.08.16.06.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 06:37:34 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: don't duplicate seq_release_private
Date:   Thu, 16 Aug 2018 15:37:31 +0200
Message-Id: <20180816133731.21830-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace fscache_objlist_release by the completely equivalent
seq_release_private.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/fscache/object-list.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index 43e6e28c164f..3e1c97d34e25 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -397,21 +397,9 @@ static int fscache_objlist_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-/*
- * clean up on close
- */
-static int fscache_objlist_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *m = file->private_data;
-
-	kfree(m->private);
-	m->private = NULL;
-	return seq_release(inode, file);
-}
-
 const struct file_operations fscache_objlist_fops = {
 	.open		= fscache_objlist_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= fscache_objlist_release,
+	.release	= seq_release_private,
 };
-- 
2.16.4

