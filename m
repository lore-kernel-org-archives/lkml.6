Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6F621479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7n/rqge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6F621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbeKVCSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:18:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43892 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeKVCSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:18:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so6058189plb.10;
        Wed, 21 Nov 2018 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wl8j9Ipn9Px7YFOiZ/t4yiFTTbOE5hEimZt8Z3YAuVY=;
        b=T7n/rqgec0998R4X0bFXYdpAhLobYPdH6X67FOlV0lvpwWYDeAA7tjs2M1hILfV26P
         rgXEHqQxJ49MD/OLxCB3lBqFza3IkxvivRoVxyFmitbXVxmoeQF8hOH73Avn3J2452ZT
         mZbuGHPBEVNzBAJHaEF6m9PZIymG4vHgckCv60BmZVAHeV5kY/Mi5R25hikuTccUseNp
         M2AgXTPmRceDIfXsV4vWcDwt2WWI7qs7u5M1hENFIXvvAbLMIjUtsGdD/9MYVaHE2YMR
         1JPgSucJbk0/D7JH7c8jqrME3qucD+gZE59MroE3yQ4+rDvEdZ6n4lkMF6r1OHhpHPAH
         NuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wl8j9Ipn9Px7YFOiZ/t4yiFTTbOE5hEimZt8Z3YAuVY=;
        b=Cxd/NTx4/dpyTKZF54SSjMV70AyItemN9WtRsXp3TOYx1yXyKqsjwHSpQUIEY3bv5U
         2L+zjomEjuLjb7XrZoa7CdNHPTn9cnZs/9TB2+uRJ0luYiCv6TlU718dXawydKGfqant
         8vRgH+mLtni6LViCw53o5nETHNvE6xnfI8ejN2LMFxrQ2yvC/Yw6smJu+PFqifW+AmEO
         rE46GhZTjcgyJ8y5q78ukyDTKPmrYA5TyRzcN6ZiDyMISS9iuue1UUM7iL1rpvYjPnvL
         uf3ItRxJQZsIh60xzlWJytPqH5XDNvp9wJ/dzOvRtWCcQNCMnOEp/9k3Vz8TfyxTesAK
         ge9Q==
X-Gm-Message-State: AA+aEWaXRRkfdjchUkPdi10Yk8EP+15MWHFAXcy7OkmsISzdgpXiIdn7
        N4idjLNO87CA477R+eO5KSI=
X-Google-Smtp-Source: AFSGD/WT+rFNWxPYV+7QwARqfSlKzJpi5nXOc7fTqJ/1gZKNNb9Trffwawkjz6y1Br1Hj3hMBCaXZA==
X-Received: by 2002:a63:6782:: with SMTP id b124mr6511763pgc.151.1542814991246;
        Wed, 21 Nov 2018 07:43:11 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id i193sm57427282pgc.22.2018.11.21.07.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:43:10 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:43:01 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, maxime.ripard@free-electrons.com,
        wens@csie.org, icenowy@aosc.io
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com, hao5781286@gmail.com
Subject: [PATCH v1 0/2] Initial Allwinner T3 support.
Message-ID: <20181121154301.GA4053@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial Allwinner T3 support.

Allwinner T3 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU, and a
Mali400 MP2 GPU from ARM. It is a not-pin-compatible quad core sucessor
of the A20). It's also known as the Allwinner R40.

Hao Zhang (2):
  ARM: dts: sun8i: Add board dts file for t3-cqa3t-bv3.
  Documentation: ARM: sunxi: Add Allwinner SoC T3.

 Documentation/devicetree/bindings/arm/sunxi.txt |   3 +-
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts        | 226 ++++++++++++++++++++++++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts

-- 
2.7.4

