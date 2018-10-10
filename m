Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CEEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575D7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1zMt6FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575D7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJJR7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:59:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40331 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:59:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so2325000pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvmYdmLOghzWeLLbc6LJKHz7tDETJvtRKEgTias8DaY=;
        b=J1zMt6FWWhNnGoyI6qHBdfzWzIO5az7CpNXqVRoStzYkT8jrkkC5CzQcMpe76MruMB
         dGMzvGh/ZhoSr08gMPXNJKLcZGNr/tGLqYh5oPTFKIt7py+A3IzQLFJCFjiVzLkaHSi3
         xBXHY3n/wrychlqHXe/sDDBsQxD4hNfsqSg3UO54iWW1s53GZzUXJ6hs80lQW9qUpAQM
         ABfSEY+0v/VNECj/XyX4Jr5OrEtSSP153GLQWHPG5ZL9+101CbL00jjOi5rlsrh9OVPL
         HgyICyAaDDPyqlWYnAz8OQ8A+gKz7z3vwhg4iEefa1LRlHDw8fZX/ZXl8ycNEwzFFQH4
         dzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvmYdmLOghzWeLLbc6LJKHz7tDETJvtRKEgTias8DaY=;
        b=Oizk29yOEwWP4Wr0f/yHX2KracdpFcjrP3m06af3W2wSPhTpyY9UY6CJARMhnRQgS9
         A/CjsiyeIci0JLVtZKx0Iozh9hnMoE0oy6hnlTgcZOm1CZbomnB6KSWHfvsN7s9S/lNT
         c6B3ifLtw5ytDntrhbSRpX7ruOQ+DnhC2e8d2nPffCQ7DhtGg4FEQm0D3uu3PdHMmgAd
         GBTONQZpkSjOO8RmFsJSqX+JjMDx+3PSyH4ErmNOdXEvXC1G28eLVY5R3S2El/70Wx06
         4mwCN0gkiEX4lK6VDq95F+/eMCCKqQHdKgaGavSRAgspCN9oxyUZ8mfVZt3mXw2lpvQn
         QeqQ==
X-Gm-Message-State: ABuFfoiKCT933LlsoLPuDqFZxoBHChyWcXenudFcL7iWonRufy13PuKU
        z/NL6+SenWDxrtsPlAzNjOw=
X-Google-Smtp-Source: ACcGV60Dy5NXonwbPROiq/zUnuR9v3huWWbG6T6B8C/vBetFtcbqSdbSEiLiieyvYuoGXmaEap8k3w==
X-Received: by 2002:a63:5d03:: with SMTP id r3-v6mr29632624pgb.445.1539167897368;
        Wed, 10 Oct 2018 03:38:17 -0700 (PDT)
Received: from localhost.localdomain ([175.223.17.147])
        by smtp.gmail.com with ESMTPSA id t4-v6sm27357448pfh.45.2018.10.10.03.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 03:38:16 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] printk: fix integer overflow in setup_log_buf()
Date:   Wed, 10 Oct 2018 19:38:08 +0900
Message-Id: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way we calculate free logbuf free space percentage
overflows signed integer:

	int free;

	free = __LOG_BUF_LEN - log_next_idx;
	pr_info("early log buf free: %u(%u%%)\n",
		free, (free * 100) / __LOG_BUF_LEN);

We support LOG_BUF_LEN of up to 2G, since setup_log_buf() is called
during early init logbuf is mostly empty, so

	__LOG_BUF_LEN - log_next_idx

is close to 2G. When we multiply it by 100, we overflow signed
integer value range.

Example, booting with log_buf_len=2G boot param:

[    0.075317] log_buf_len: -2147483648 bytes
[    0.075319] early log buf free: 33549896(-28%)

Make "free" unsigned integer.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c3f0e3927e77..c9e1d3bf695e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1083,7 +1083,7 @@ void __init setup_log_buf(int early)
 {
 	unsigned long flags;
 	char *new_log_buf;
-	int free;
+	unsigned int free;
 
 	if (log_buf != __log_buf)
 		return;
@@ -1116,8 +1116,8 @@ void __init setup_log_buf(int early)
 	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
 	logbuf_unlock_irqrestore(flags);
 
-	pr_info("log_buf_len: %d bytes\n", log_buf_len);
-	pr_info("early log buf free: %d(%d%%)\n",
+	pr_info("log_buf_len: %u bytes\n", log_buf_len);
+	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
 }
 
-- 
2.19.1

