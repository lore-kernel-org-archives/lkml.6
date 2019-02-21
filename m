Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D18F20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSEZSr/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfBULvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:51:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36267 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfBULvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:51:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so29711987wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3M5x03OILQJphj2NS2SE7omfFqWizQ+eC7zxXoZQNAU=;
        b=VSEZSr/oVJibIX+y7N0J6vx5iSlrBCdp2C91KkctQbV+NBRnbu0vE1EvN1fmMBMm8R
         Pg97u06AoKr9Jlre5VsKtiVPiYb5KbBcNQQBaK4gMi/mXNk6xNsCHuqC7FkqWDtV0HGx
         tR33DYug1BUNyIFM2gmW/LYYzCZUiJSpgZrFelFN9d8MGDC4sQB7Avm6YSd4yRHBIThw
         PZJziCbqsVEZyON0rvfsd+VwC7kcrEkvvIrcWT2YNANgzdleR3NQU5ObPUcmYaj7VVIz
         S1uwo5cDRYDNRsXIo4gs76Qv3v4z9nEraDva95yCrs0Jetk4XNIuMok3hUItJ52ceRTN
         bpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3M5x03OILQJphj2NS2SE7omfFqWizQ+eC7zxXoZQNAU=;
        b=pUCZqATAjzLbFWErY9jashn32veZrqc94COQuY6ubXQZEwsltpbXGIl0BHhPC8+NF8
         GWBM0oQXu3iJn2DryDTuUU9mUtHy7eYOCKbYks0dlqJORG9MKAyY7BONy6RB1igZUoW3
         hOTxnhx0y4ClZjYQhENe6yX/MBE08u8K48L1QA9p/I/VNJBvoL9TOooZi9i/UuTpPyCa
         TeyQA5n3Wzb2yGaJHpWPVEeb3PrqK1rZJnHVXVLkwR2dxtWK8dpZY/TjVreGDk//iPzA
         dYOZqyhpTcFdVEgGrXSxxsqV6WG9ZnIRorY6grEUa9ByFwrQZZxnhge9ySg1F4cTXKLp
         /uPg==
X-Gm-Message-State: AHQUAuYqOFccnUQLrOWfulcDX7avDH+bYq3/qM8NPxJS5lnwnCMjL1mB
        l8yvjA3KUPGWPlyUKUX8C4kq5vPA8vU=
X-Google-Smtp-Source: AHgI3IZcZVztQP1pJDef0zOgMSrUdQ66YCOHngqSCejcwUOe5QDYbsK0yxtX+77S7ttC0Psenmrc8w==
X-Received: by 2002:adf:e548:: with SMTP id z8mr29252631wrm.52.1550749900313;
        Thu, 21 Feb 2019 03:51:40 -0800 (PST)
Received: from localhost.localdomain (ip5f5abba0.dynamic.kabel-deutschland.de. [95.90.187.160])
        by smtp.gmail.com with ESMTPSA id j5sm15092849wrw.59.2019.02.21.03.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:51:39 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: rtl8188eu: add spaces around '*' in rtl8188e_cmd.c
Date:   Thu, 21 Feb 2019 12:50:56 +0100
Message-Id: <20190221115057.31207-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115057.31207-1-straube.linux@gmail.com>
References: <20190221115057.31207-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '*' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index dcc2445a8988..47352f210c0b 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -475,7 +475,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	PageNum += PageNeed;
 	adapt->HalData->FwRsvdPageStartOffset = PageNum;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (2) ps-poll *1 page */
 	RsvdPageLoc.LocPsPoll = PageNum;
@@ -485,7 +485,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	PageNeed = (u8)PageNum_128(TxDescLen + PSPollLength);
 	PageNum += PageNeed;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (3) null data * 1 page */
 	RsvdPageLoc.LocNullData = PageNum;
@@ -495,7 +495,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	PageNeed = (u8)PageNum_128(TxDescLen + NullDataLength);
 	PageNum += PageNeed;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (4) probe response * 1page */
 	RsvdPageLoc.LocProbeRsp = PageNum;
@@ -505,7 +505,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	PageNeed = (u8)PageNum_128(TxDescLen + ProbeRspLength);
 	PageNum += PageNeed;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (5) Qos null data */
 	RsvdPageLoc.LocQosNull = PageNum;
-- 
2.20.1

