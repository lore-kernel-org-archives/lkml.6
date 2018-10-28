Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A893C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138CF2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="QNYypnR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138CF2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJ2HF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:05:59 -0400
Received: from nag.0l.de ([207.154.252.120]:33456 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJ2HF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:05:58 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 03:05:57 EDT
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8TktQPu/amWih2Eb7B/eMMm/OVQPLrqoGEZZL7ax/c=;
        b=QNYypnR/M5gtNqnY8FwPsFgkkbU3Pje9CpM56see9/y0t1RNfGwFnprBHdv3uIgDZt+Zas
        IjZZpmWwn7UPWBtfGyEsPUGN1tsWvKqZx5+6vNNtQcJXCv0uS02z40grExdsrxSbaWUvF0
        f/f0TOitXbwCYLAiguI+jn5PehM/vGIk3T3ptqyziqzkMGGeKg/sKgAQ9xbp1RCwhBhfRr
        9gpluLIm906LFYmz65f3Xwjgiq7XJwtqwOPjXhwq8qeIuZY4mKbDVZa3hrN7ms9inGLP7F
        Ui/G+XIVh0m8PZ4tmwM9YS3RDHwmptgaRMyG0sR/hzp5+AOoIM/rWvg+fQCyCA==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 9/9] w1: using linux instead of asm prefix for includes
Date:   Sun, 28 Oct 2018 23:09:28 +0100
Message-Id: <20181028220927.56227-10-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8TktQPu/amWih2Eb7B/eMMm/OVQPLrqoGEZZL7ax/c=;
        b=xUnPLIfgQPDsOF83shDm17jMMQSFv3UitBKDeQuo7YzPc3nj4L8IMDU1qlrsZh00FJgr3i
        nZrsS+TgtHAEwWxco4euYpzbMhyAH8mTS9D1OlHvt9y/wCEowsAK6waY6VeX3PCcp3+aBg
        6RH6/3wUMO/7Gmwytm5WFidBmKi2qvl027lf2/asEW20qPHlio10uGC49mwKE4yKeypNB6
        z+mg06jLz3tIZ3lF2S8isiC6y2Ef+Y9Pd615ToW1tOj4okQ50y6deaP5K5lzb7KWvmsbio
        MZvODPAaSJlb6M/4B/UNq3VtaeUxhLN2OEwB8hZdY89kBj/mV+H4JQo7zJ8GJA==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=ELW4IOsDyL8GzBcavS9PQmANe0WbHp8l60oOWsj9bqcGKanSvuBb9TsXHAE7av+0peYgoJciaVvwPIsolV6Jyh9C4SRJMq/Ofjpjmk+y8sh3uF2PPT0D2n/Lzq2FJGgh0sOAEH75AFYMew7xOcdArbE4ALCY7CbGaRY+jAz2dxoMucHjCAqmmbmFKhvvls0VZ/Ub+hobmcRQPFwk6sSJsKYfpHo8NcMwUNQlVGLTL29XHs/h9B4sTLSWF5s7ZiZ4MZ19+eYuO7llI2Wa2PpUW2faPTfF3797tOPA4iZfr/rdv0eiA/9CcvnJ5mtDv7TK4dvnt6XOA2ohPVfbWvoONA==
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
index 283c89708c7c..b18d82cde71e 100644
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

