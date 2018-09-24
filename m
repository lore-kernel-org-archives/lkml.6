Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B80C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5576120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NI5f/ujt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5576120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeIXKnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:43:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41751 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeIXKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:43:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so14135323wrt.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 21:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zZ85Yzy5aTSu33VrHb/dAynH5FCA5tIy4s8h7kijj7M=;
        b=NI5f/ujtb5l3duqUQoacvZ96masBYwjLJP0G8YV9oQ4km5bVchCtS8/mkT3Am7scaZ
         mUs2ECxW4UtJ5KhGnJsHIXkOPw/KmlvJlP9qVx+0e5oI9tgqLFeHd8JKprS34CbyPutS
         2z5TNidRW2GBVDxcD0pI1sLMGzjU5vH71+3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zZ85Yzy5aTSu33VrHb/dAynH5FCA5tIy4s8h7kijj7M=;
        b=B6sLoWrrVk2kBSdJQPkW2fZ8qSXfo22Zn3xZjKYZhUJcPnlEdvEIlgi1jMJ1yDOyn/
         AZAXckFvJzLtWcjLQ7mcaYyuz4nE9aoDozKLHMsyB3e0ZHEE01VYtxSQnetWXW+uQirb
         cMiKwBK3bFjTocX0Unmn5ss0Bnm0pplNLEfsRHv6Azl9V1VqCtEY9FVA3wYev4HnwZZG
         fSiQGz/wgYFjvkLfGDVvRXPqR/UL26tJFFv9bT2/PK489u8z6gRgPvY8YKZLFiKvCy6x
         wDHlqDaDkKc4O+KGFivNiilHL7TZg9qcWOIxN2UdAW9cxJYmD84amwL0XdPMhsfWs2tl
         9uag==
X-Gm-Message-State: ABuFfojQ1+FRHwY+qzOsRwgoP/CwyH/pBXenq3WNMWCEBxSXLksrGc7A
        /AyRFmxR/jDbbxUwW9DJXY1TveekWD4=
X-Google-Smtp-Source: ACcGV600TpVwq1inwNGXo4BxjnlFnPpEqOz7JxQy/Nif36YeM+qLf5MXwt32slghUm8oBzzkOM2uRQ==
X-Received: by 2002:adf:e2c5:: with SMTP id d5-v6mr6953470wrj.139.1537764206213;
        Sun, 23 Sep 2018 21:43:26 -0700 (PDT)
Received: from localhost.localdomain (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.gmail.com with ESMTPSA id q200-v6sm19527855wmd.2.2018.09.23.21.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Sep 2018 21:43:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: Set ARM/LPC18XX architecture orphan
Date:   Mon, 24 Sep 2018 06:42:33 +0200
Message-Id: <1537764195-19117-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While sending patches around, Joachim Eastwood was Cc'ed but I got an error
its mailbox was full and the mail can not be delivered which makes me think
there is no body at the other end of the line.

After doing some statistics, it appears the latest commit as author/commiter
is:

commit b16ebc017ebf52a81e5e88743ccd68fc25e99ba9
Author: Joachim Eastwood <manabian@gmail.com>
Date:   Mon Oct 31 14:45:17 2016 +0000

Remove the maintainer entry and set the component as orphan.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67e877c..f3612f6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1599,9 +1599,8 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
 ARM/LPC18XX ARCHITECTURE
-M:	Joachim Eastwood <manabian@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Orphan
 F:	arch/arm/boot/dts/lpc43*
 F:	drivers/clk/nxp/clk-lpc18xx*
 F:	drivers/clocksource/timer-lpc32xx.c
-- 
2.7.4

