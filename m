Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05750C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA4C20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rXm4MNq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA4C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933249AbeFUIdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:33:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42069 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeFUIdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:33:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so2205359wrk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=OVzP8GGrxtMxZxIyjee+lLTcDtInvxMFN+B2bmEF71U=;
        b=rXm4MNq1O8UcoUcCnL8iwKhyfEdyO39lAEvGu/vy3oRBRkfG2DdJj2+JgTmdU2McvK
         kGEqJkl0qL7N4hW7y29IROucL/+piT0Fumr5BMpqEnakOSG7MzopiGRQU47jDS8wmca6
         KdJaD7OIJ4mIojqmo3KMPXIYx1tJ+jHdSbt5bHjIs1iqIQ0q0np/e3Kux8aiw7Hfjv8+
         HPOOK3fR6zJWZzatyFpB0r1SrzBhThxOiq9LIkMO0R8WTmAmgw6zM8fxx3gnGp5lCu6e
         G5NszcbWOHu9xejj9zg5xZVVJk+7EqLo5w8KNk6UxeSeQlMtyXCOYD4+wm4cSxZ7yCDU
         TgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OVzP8GGrxtMxZxIyjee+lLTcDtInvxMFN+B2bmEF71U=;
        b=b1Jfo6HxfGeLVYzq39ygi9RKRUS298dM00oxE2z5hSIU/6qlFQWx0ovgAzqD/cwNch
         c5vUEaXIfMEuuaXu/1sdPp80znu0uiY1tdB9RJ0yobz+7G+PR0FRAsFUuUXwA/riW6Z6
         GBl56kVKU1mfii9PDrQjST35N13Wjh7QMBIQTMfwBGaPOLv7DQXxYzdos2VaYV7QqJb6
         jDUO7EWOXkoA5cM3HZobL2GSyo2se02hMkqbZmL/7KLqfVONCZqv2s7PHoPdEfNtsKb3
         noGHjR6L0Xb1OhgGHG7ryK5oTknI++AySEYewXPxQmIV3zBM1JepluUPPN17fLk8XRFt
         8kVg==
X-Gm-Message-State: APt69E2wuNo1uEnUjLvvp+KNygSmKQOaj4S8VV8EQ3WB9WsDQjZVuP79
        k55GTHgvJ6DfDx2QfIRan+mrxA==
X-Google-Smtp-Source: ADUXVKLO8SXtWGHzZ4bhYLBAFExQ5uLBkTW7mLEBMKGH5aF8inPvfI6rwm7AeJI4KyeCf2R1tLIr/Q==
X-Received: by 2002:adf:c646:: with SMTP id u6-v6mr1834478wrg.177.1529569989855;
        Thu, 21 Jun 2018 01:33:09 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id r123-v6sm6062754wmb.21.2018.06.21.01.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 01:33:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 1/3] powerpc: dts: use 'atmel' as at24 anufacturer for pdm360ng
Date:   Thu, 21 Jun 2018 10:33:03 +0200
Message-Id: <20180621083305.5322-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'at' as the <manufacturer> part of the compatible string is now
deprecated. Use a correct string: 'atmel,<model>'.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/pdm360ng.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 445b88114009..df1283b63d9b 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -98,7 +98,7 @@
 			fsl,preserve-clocking;
 
 			eeprom@50 {
-				compatible = "at,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x50>;
 			};
 
-- 
2.17.1

