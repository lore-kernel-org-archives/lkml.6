Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF2C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4383F2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Tc18A7Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4383F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeKBULl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:11:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42031 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeKBULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:11:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so1040048lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUCc06KgoN4uMpzaC6Xpg6m5UmdFnkziCwtwwOiEVp0=;
        b=Tc18A7RmD4icZiYisJkJv0ZoiZoaDzKE0b0VyoYMRGxWoikcvJSBPr/CUblAEbktz7
         SFMUjQ7J4k2OSSrFoeagT1O9QyGalHhj6DU7AEkCK8tX7Cgf2PHB1M9lvusarDAyiqBN
         RfsXnAbFPz6AAGxkat5uYFLdADtfDfgy7nTtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUCc06KgoN4uMpzaC6Xpg6m5UmdFnkziCwtwwOiEVp0=;
        b=kOZdVhCHDSM3kCC/17GyCqxdXE2mdpsn/7JCdjMgHyO3KFpFvUwQp0k60pvvibBd45
         fMx6BkSL3DIMnoukWWW79umTMftgeDxr+nLVLiH4g5BgtR9fFmtzt0NwdNj+nf/38yPT
         VTso16sUBRed+riNu3Am/zOUexZx7U+/Q0e5vQm0A6+OC+/hrOiY2z2UOcAVyrmX0UKS
         JuNlB8FXiboPpHQEhHy/MjSO7cHooRgQZ4PI5ngyChHybk29lkc7OvZ+bT7X23kgTNmU
         tHkbOooBAFZziSDMco53qR0utJgjPDRH6v8gppwa84IfyspMMHI3KqmL7BYxng6+mNm/
         YU5g==
X-Gm-Message-State: AGRZ1gKEJ3nLma+4xBbk5u+96R/bEHdqBi7np3cwe+ZYi8qd4Y9rMKVS
        2YmDevaCxdM8/M0RSpghPo7HRg==
X-Google-Smtp-Source: AJdET5fsgG3emOpGK+2g2S3428WjgtnFndO7suYkjRFBItNv7e5anVW+piX0kuShQRHWKofWa1EF9Q==
X-Received: by 2002:a19:f813:: with SMTP id a19mr6404291lff.67.1541156693315;
        Fri, 02 Nov 2018 04:04:53 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r22-v6sm1952896ljg.82.2018.11.02.04.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 04:04:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drivers/char/random.c: make primary_crng static
Date:   Fri,  2 Nov 2018 12:04:47 +0100
Message-Id: <20181102110447.23121-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181102110447.23121-1-linux@rasmusvillemoes.dk>
References: <20181102110447.23121-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the definition of struct crng_state is private to random.c, and
primary_crng is neither declared or used elsewhere, there's no reason
for that symbol to have external linkage.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1b2e1580b4b5..0a381897e4a5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -415,7 +415,7 @@ struct crng_state {
 	spinlock_t	lock;
 };
 
-struct crng_state primary_crng = {
+static struct crng_state primary_crng = {
 	.lock = __SPIN_LOCK_UNLOCKED(primary_crng.lock),
 };
 
-- 
2.19.1.6.gbde171bbf5

