Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E838EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843A52089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edited-us.20150623.gappssmtp.com header.i=@edited-us.20150623.gappssmtp.com header.b="JW8fDnjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843A52089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=edited.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbeGMQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:18:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38192 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbeGMQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:18:06 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so12198508itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edited-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=j4lp48NyUTTA4KuzylalcZt4+Ein2ImctGaw3Vgsrpc=;
        b=JW8fDnjWZYPAob03ErDsRhaRj4H3C2N5KcUbwyRZKZ1k13dVXi65i/s4r69bopVLiT
         /CWFj8yrHZ/wq4pRz8Ow0Eoa3c6nqz6m50YihPXcTW55zVfPFUjz06MbcbXC2kWd45TJ
         Jza2u2zhNvASbvpRWn0740xm817OtOiW82GYjW0ioR4NcmuLaKHb6Nmt1ZCixDpMwHqz
         hU+v/KC6zn0l07Bfj8mro+o568Ai4dkwhLn4v3J+yVqm0woTPkpmRGh4otunZ5RoXxMF
         WHYOVUA3VhhT2sETUtllM5Qj64a9ECgPDo/5OushlzSHwhQOx0laRKqHFntERFaBXPfs
         KQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j4lp48NyUTTA4KuzylalcZt4+Ein2ImctGaw3Vgsrpc=;
        b=rCifIyrWcP2IjnX2cPv60fj1bbQlq5iYJjgCyZ3uY1jbnte7cCxkrbacCo7kBHeqmm
         dptO7AhKFot82KgFBWIj6tumapiuid9ZNrSv1gfH3jwWdir2aLLvTEzDRh70+HifDfnb
         vB9iTx4EWlQj0E6Be/RCLjwENKR8qKPkKpLiIaBL9iproNmRLaYmmpVVSejUxf+60aJQ
         PWQNzkjmwDJwTNobEfBnCiIPpqnsahG//zNjDw7Pi40+XK6QpT6dK4yz37WKR6dEDVwX
         /3oEQu4kZTpsxZrw2TixKSF9zYEpozYUuLAcuQ47DzszgTwa+1LD/C3Sag+yTQ0KnXyK
         eg2A==
X-Gm-Message-State: AOUpUlHSJmaCuHryA/UeoY/14wNHUKiWThjvNv4PUR3hcS/k0xyi5jmm
        JE2VIy6PJieTv4AfxsHb34ml3Q==
X-Google-Smtp-Source: AAOMgpcKf0adD/fSqMojXhz89Au71SwQAxQmducEm+cRUHPC9Yguh3FaFYkgjTaVBBSFUtv15gKJlA==
X-Received: by 2002:a24:f9cb:: with SMTP id l194-v6mr5407038ith.87.1531497772120;
        Fri, 13 Jul 2018 09:02:52 -0700 (PDT)
Received: from debian.hanksspec.com (ip-98-240-239-173.midwest.us.northamericancoax.com. [173.239.240.98])
        by smtp.googlemail.com with ESMTPSA id t62-v6sm8405121iof.16.2018.07.13.09.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 09:02:50 -0700 (PDT)
From:   Ryan Grachek <ryan@edited.us>
Cc:     john.stultz@linaro.org, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey: Remove keep-power-in-suspend property
Date:   Fri, 13 Jul 2018 11:02:31 -0500
Message-Id: <20180713160231.25165-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the keep-power-in-suspend property because it keeps wifi power
on during suspend. This property is only required when enabling WoWLAN
and should only be enabled based on need.

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 7f12624f6c8e..f4964bee6a1a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -323,7 +323,6 @@
 			bus-width = <0x4>;
 			non-removable;
 			cap-power-off-card;
-			keep-power-in-suspend;
 			vmmc-supply = <&reg_vdd_3v3>;
 			mmc-pwrseq = <&wl1835_pwrseq>;
 
-- 
2.11.0

