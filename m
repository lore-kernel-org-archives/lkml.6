Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C4C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC09720843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="P7mwC83T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC09720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeJ2Lv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:51:26 -0400
Received: from nag.0l.de ([207.154.252.120]:44462 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbeJ2Lv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:51:26 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wS2CM+aUc/xUX1gsGuKRUPVnYKp54pa7dqiiXBveAQ=;
        b=P7mwC83TxaoB2L3YYdA54XYQ1rezku0AhB0MvK1f+gX7/Pd17O9OGdpMTlZpfHzy+Q7CpD
        R6EXDZDxQJTbc+H4aKkcvAiuxaxxvdZkfxUfGwVMA2hEFPwph0lM2JlTUd8nKH1Uez5Hch
        Gukw9ZJjtT4E6jCppajivRAGeH1lI/znxgj8cMubajU/XoeiqrRsfLB7idyfSwg11HRj7t
        O2C22gVQa0rB684Vd4aZYPtIwqgebwhvldit1SvT57Y76QBG2WnZa2ks/rHoCqsq5qzGfk
        +x0ptOcWxVGRIWO13jB9m6fPA9mjtcxURlQoGj/YmrY6o0ZiPGYD1oLTcd2d1A==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 09/12] w1: using linux instead of asm prefix for includes
Date:   Mon, 29 Oct 2018 04:03:39 +0100
Message-Id: <14c400228f78240479241d2c0122f3b68d3f2cc4.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wS2CM+aUc/xUX1gsGuKRUPVnYKp54pa7dqiiXBveAQ=;
        b=HhIhK26kGb9pDubXHM2fP3C0jcugzaMIGS5lzBxXvfLmpSaKez3jZpHvLRBcyZdlmtrfnt
        DpZIayMUOsacO5izD0zyXd1kvMb7X3Wzxk2gs40DL7IR1RvfQqBTSZQGrF1ttw8m6KRfan
        e+COmXERg1wO2EOZDH7L2L/PSgG6QV/ddIwlh9tfZXDrhOln1tc4e1WoG4gstgqC7u8GfP
        kFrZylYgvTHMbNlPn0lISKyW0yXwV+bKMz7hRO5vsMmSSeOhsV0VlY126UWHqBAGe9+mgf
        DD1gWW8VYXlaY/xlRVhW+QwQQ7n2Gtm4G3K1/sr03shk3hSA6NkWPjw82NFPJw==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=jppOfoSoukGzUhT3kRTa1FkSHd4x+aLzwM/lOenz3hz8Z+Vg7jpbipqlDm8r1EQz7twSt3LDhrKsxp/KGKjOOZTaKUsG1PrH8AYf+yPyJ9riGS2VRcoaFNahAnRT15SqrUW8CdtusWOtVanmn4PkPcjujowuco7waqkoyDNuKNKWALPxZEsqiv3/bbDRnbJY+Kzj6PLM4NwyK8h0OWzSmQ54salrmjmIK0AT8uODqeLEVMBf1heBQgq01yCzOh8NTlFX6ZTWK4OPKWSOCtnsG9qpFVYNNioz6ByWiqZVBHXu8WutkOLNoa4Oo+fdltDUiqdm6D+px/La1vlhfuN4Jw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a warning raised by the checkpatch tool

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index 688778cccf65..65384b332a5a 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
-- 
2.11.0

