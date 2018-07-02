Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E15C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54222518F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FggABiQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54222518F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeGBP41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:56:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38011 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeGBP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:56:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so7711421pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7sgR3XWb0ZjhnXliIyW3/K457TTRxSTFst5nLbjcNV8=;
        b=FggABiQqwWjx5dBkx9/Xc0dLo9ZCFmCWp4XNprXC5r9MTEGWSaQLjjLoI6bxwAEbq/
         JpkZ+DT/cN/SPVcc0Sqic0F4+x6gJjdbZ2qEwDTDmC5/ry8T6X95OkqT/GOwADGWDZHi
         8uIPegkjPgSR3wtqNiAdF25VnxNdPs3cTy/5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7sgR3XWb0ZjhnXliIyW3/K457TTRxSTFst5nLbjcNV8=;
        b=a6wJwhkEU1wnDaAq8MJU4CiUmhskcSulDjafwWJHRcSbPe0TCYIXgUb4a3NVosDRcs
         neNWbRp56JupGzPDxZNHHerPkdyjgmWfVgWEPDeT/A1g71UnCNwkAHi239lXuE1M92QR
         fTeY+Vv27omDUHkDJjmkznn4pCuKp57pNaKT3ZPZX5ascX2oAX4kWzhVKXnKcTzFb8oq
         AKvLcEDir53QBBLZzB9bc+seuHyTaR7yjg04x+yK55KJuDoIFoGyJlY0jCtUsW8xRotD
         NZY9SxbfUNpZdf01W2lN23JL7EcPKA5bf7yVMpe7KoLnEm2tbYjDPBa4THAKQKsvdNZH
         21Lg==
X-Gm-Message-State: APt69E0PuGIEnxsvxGBCy6sE0kEPB9E6MPxjljOOmCDdE5XjS3+uokeJ
        sL+sQPjUMy26AYBOjznZ9LUbAOjcue4=
X-Google-Smtp-Source: AAOMgpdUedS5JSPLBHQOIbAFBycB1rD2VZwUQcHr++db/twPxBRfGwHDkdy3yW21y0JHhupq+srRoQ==
X-Received: by 2002:a65:6398:: with SMTP id h24-v6mr5576172pgv.245.1530546984098;
        Mon, 02 Jul 2018 08:56:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b62-v6sm26084830pfj.123.2018.07.02.08.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 08:56:22 -0700 (PDT)
Date:   Mon, 2 Jul 2018 08:56:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: mpc5200: Remove VLA usage
Message-ID: <20180702155621.GA16047@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a stack size large enough for the saved routine and
adds a sanity check making sure the routine doesn't overflow into the
0x600 exception handler.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use "0x600-0x500" for size calculation to illustrate handler sizes
---
 arch/powerpc/platforms/52xx/mpc52xx_pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index 31d3515672f3..b1d208ded981 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -117,7 +117,10 @@ int mpc52xx_pm_enter(suspend_state_t state)
 	u32 intr_main_mask;
 	void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
 	unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
-	char saved_0x500[mpc52xx_ds_cached_size];
+	char saved_0x500[0x600-0x500];
+
+	if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
+		return -ENOMEM;
 
 	/* disable all interrupts in PIC */
 	intr_main_mask = in_be32(&intr->main_mask);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
