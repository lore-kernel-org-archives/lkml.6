Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18CEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF46521848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfbYOAd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfA2PZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:25:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38976 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2PZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:25:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so8874096pgl.6;
        Tue, 29 Jan 2019 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jsK7RsBEyiyXYTpRVcowXJMK7pXPpcPrFLCk40abBLw=;
        b=JfbYOAd9w1R0YskrDDeyQNsO9kI+q1OcdSDx7Cx6J8BuPlWgBVeTM1ibP2IpmiW6ON
         9UtUyZXufaWu4Qox8H+21ALp9lp2b0PIPm2Ab7u/A5Q/g0kV2n+PCoLmuJU4P6j3CJEx
         ZRxF/2bZz/H/nxFI0Wu8SAHDNEGTbUjSyNsBRUnglupkTD3BUXF2WYHWXeMIVvYMkCp7
         lzncsH7LI6OUcMXp+Yy4wh5Om+sLTrRsqlaa4VFze/fA80ZkKcLnfnQYIO6F0B0hsbJz
         bEGpafa3BREIm56KCYy3Tnp2A7af3U/C1FMkKHrtsUKIDNJHYJ108zy6ELFFZQhQYtlQ
         PxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jsK7RsBEyiyXYTpRVcowXJMK7pXPpcPrFLCk40abBLw=;
        b=mcf8oNg2Rxn4sXyy44h14JuahgHrQcb/KQijKk3kGRVG5aML8bgbzi2x7/k1WuOeAD
         wAHa9tyhnwSCfvCAowd65kU+x1hdyTZI7gp85wa88AEGs3TjuKYYaAUOsvXSif4wKbX8
         jHzzYCxQGImPVUwHfE8W/fldKJaw+RhEtlzuuCH7c/M+ooaBFvAPq67mY6KD0Kf/lgov
         tCuTcpL0CLxtvEyhkZS7yf8nhI5HHjcg83NveCFbB8Cc0Bpp7jI0vC37RljbKXzGoDsN
         On+qmOdzVoZYPmNANIYCz7JAQtC12Ke6djM08JW3ORq+wop+TF0+VRIOKw1IEsEcJ4mk
         I9vA==
X-Gm-Message-State: AJcUukfmbvrfIzP3az4oI0YTNUrBlFsB6625acUog6ojahquVMbc+zjJ
        VTcWUw1JArTgzW549K+Ov/U=
X-Google-Smtp-Source: ALg8bN5AgA8PsSPz1nkOdfK2fC65cTO5rmnS2/nTWF9DHP3MT5Cpdop30c9e2tkykwksKYVBbZ6+hA==
X-Received: by 2002:a63:5026:: with SMTP id e38mr24165629pgb.123.1548775536671;
        Tue, 29 Jan 2019 07:25:36 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id l5sm57380459pgu.86.2019.01.29.07.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 07:25:36 -0800 (PST)
Date:   Tue, 29 Jan 2019 20:55:27 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Joe Perches <joe@perches.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Select PINCTRL_RT2880 when RALINK is enabled
Message-ID: <20190129152522.GA24872@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch selects config PINCTRL_RT2880 when config RALINK is
enabled as per drivers/staging/mt7621-pinctrl/TODO list. PINCTRL
is also selected when RALINK is enabled to avoid config dependency
warnings.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e2fc88da0223..cea529cf6284 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -623,6 +623,8 @@ config RALINK
 	select CLKDEV_LOOKUP
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
+	select PINCTRL
+	select PINCTRL_RT2880
 
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
-- 
2.17.1

