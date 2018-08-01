Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70713C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294A6208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1b5tCCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294A6208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbeHALc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:32:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36094 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeHALc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:32:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so4831029wmc.1;
        Wed, 01 Aug 2018 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wKjfFTIezxAsHyRFjiMZEtQ89J84bXwgCfSxzWh5VRA=;
        b=Q1b5tCCVbvKJFmZg8UL2vNq9QVzm/+Ggw6B/4v3R5b1/e5AfQAD5TOpgzQjpO+mcB0
         3extkYMLezo3WlioMKoV3cHiy0taaWlSWVHZ1+7Go459eYl2WcZb+sAszgcLOgEmzGoM
         8QvGLaR2QwGFBSMr87AvNGLpNE7i2vkcRJfp38qwmkACvT8iIJEsgSP38X2+zhpcFDIX
         Dz6E/g2AhevQPElxlrc9br9WU5jlnesrbCeIwNBOwjcOmXP5evyY/aq5Dq87xY8bcOEO
         sI2dZt4waCbcdtDctPUB9OZ66mHjLQsFbaWJz9eHAv9YF0RP7c0DxfzZ7DeFbx2GqwWj
         57XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wKjfFTIezxAsHyRFjiMZEtQ89J84bXwgCfSxzWh5VRA=;
        b=jDQhOGSfzYIxq4kRabsXAqnNYi1myiB9NpRLpjD7/XLBg2n2puLg6KvPavtK2DP5+e
         YYJUa1urWvAP0L6Hy6DKhf6IvaA2HxleDQa66erBb8eX3hDZBbXAhKRrCp/ibVTCm6jc
         MkvmYAVRhxDLuSngpUmpNb/33uVjVmLIu3tYI9xNIYynDhxkQ52AqiFzC0qlmGxzOaaH
         rk0AP6Q0FpUz+3kNCdTFC35soQKecU/wwVepAhg+iq0DAx0NhHi+gfDnzLToExVwhLqw
         QZMuK2wqjPWDxWVzbBTy+U1oinG+K/6Uhzj+HA8GNrFAFBOSU2u9F9+hoKjCdwWfpKCt
         uHaA==
X-Gm-Message-State: AOUpUlEMHtCixtsOsE/uy3CGGX7H841uZ+Xm2h6ZB8Uf0pxxa3iSZkRb
        h7cOAYe+siFFq9b7f4xDA+o=
X-Google-Smtp-Source: AAOMgpeEyilL3O5lw87aRT/WMU8uPnjAM34hWyuzbU4rI3TXcoN5QbYuCQWPdsq5gk48wwHfIdiO1Q==
X-Received: by 2002:a1c:e455:: with SMTP id b82-v6mr2418695wmh.93.1533116883246;
        Wed, 01 Aug 2018 02:48:03 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id r12-v6sm13580217wmh.0.2018.08.01.02.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 02:48:02 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v7 0/4] IR support for A83T
Date:   Wed,  1 Aug 2018 11:47:57 +0200
Message-Id: <20180801094801.26627-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the sunxi A83T ir module and enhances 
the sunxi-ir driver. Right now the base clock frequency for the ir driver
is a hard coded define and is set to 8 MHz.
This works for the most common ir receivers. On the Sinovoip Bananapi M3 
the ir receiver needs, a 3 MHz base clock frequency to work without
problems with this driver.

This patch series adds support for an optinal property that makes it able
to override the default base clock frequency and enables the ir interface 
on the a83t and the Bananapi M3.

changes since v6:
* update Acked-by
* add missing a83t compatile on patch 2

changes since v5:
* removed already merged patches
* adapt patch 2 to be applyable to current rc-1

changes since v4:
* rename cir pin from cir_pins to r_cir_pin
* drop unit-address from r_cir_pin
* add a83t compatible to the cir node
* move muxing options to dtsi
* rename cir label and reorder it in the bananpim3.dts file

changes since v3:
* collecting all acks & reviewd by
* fixed typos

changes since v2:
* reorder cir pin (alphabetical)
* fix typo in documentation

changes since v1:
* fix typos, reword Documentation
* initialize 'b_clk_freq' to 'SUNXI_IR_BASE_CLK' & remove if statement
* change dev_info() to dev_dbg()
* change naming to cir* in dts/dtsi
* Added acked Ackedi-by to related patch
* use whole memory block instead of registers needed + fix for h3/h5

changes since rfc:
* The property is now optinal. If the property is not available in 
  the dtb the driver uses the default base clock frequency.
* the driver prints out the the selected base clock frequency.
* changed devicetree property from base-clk-frequency to clock-frequency

Regards,
Philipp


Philipp Rossak (4):
  ARM: dts: sun8i: a83t: Add the cir pin for the A83T
  ARM: dts: sun8i: a83t: Add support for the cir interface
  ARM: dts: sun8i: a83t: bananapi-m3: Enable IR controller
  ARM: dts: sun8i: h3-h5: ir register size should be the whole memory
    block

 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts |  5 +++++
 arch/arm/boot/dts/sun8i-a83t.dtsi            | 18 ++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.11.0

