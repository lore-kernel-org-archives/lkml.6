Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE9C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815EA20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv6Tos7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815EA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeKHQP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:15:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45571 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:15:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id o19-v6so9054144pll.12;
        Wed, 07 Nov 2018 22:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGexjXG9deRwG8qanQ+9RJFukU1QOXlQBWvNh5I7VFo=;
        b=Iv6Tos7s/yRltFGrsmruVRVaTvrDOeTstDwtvaxcvfU94lNOhFx12ADDb6BpxMMS5g
         NK4Tf0/EfTvNVQTF+hImxvmvR+f6qcRUveWtJcSrGXSkDrMhuAGcJUJdcqWNsWRpG6jz
         qF9haB79lgAcmvdkGoSYL1GpuojOhgX5mfrgv0XM6Y8vZ3D9cFqM+myBbI+p27qOGLjC
         ueTMbiOBMWn9N9vZkoZxcK6cGVYKE/ekI91SVCP9aov2OWGkiR7XtsGYt02QavBN+7x9
         6wPmd1AApus29tXLPAEX/JQc/eNC07dP2iRy9zEkOkXBBKoyinXZ6T4RNmes91QRIEc1
         4WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGexjXG9deRwG8qanQ+9RJFukU1QOXlQBWvNh5I7VFo=;
        b=LPx6D/+bbJJ+3y4HUi9Jo5QgzdqEj6e8J9iExhUTq7ZQchWR6o9g/P9S6cqeqg18D5
         1Isni/bIXs1i8XTDtlnXupBP/oFmtocv6P5qHQicCx6Q6HeQqxN5kD1QVXBAkgRC/IIq
         zrnySjxHw4UId4dEfSEsCUuQz+j+xfjARNQ9y3jQF6IASPTU9RRdUTMglL7X17jgWD3h
         OqClZWODmqMDl635GidHelBQ+wEJCBVDunfyDcnZM0zpUZChlXE7ayEjTHFwbK2/yWSv
         bVwLHke2++YDgl5LT846ddLwNOaW4KZGW8Z5yqntai3riQ7hZL+mjqqYMb/LVc6+FjU8
         WLEg==
X-Gm-Message-State: AGRZ1gLq7Nfc9N/qvfeKYdwb/dWNLF+CZhPBt3G3Go6CsMvi8/MBVBF3
        kaTt7f92+YHMHXd6nb8rVgw=
X-Google-Smtp-Source: AJdET5cPIglz9FWQ0KKomcrK6qHtHWadqgQmkkP0+YISDnOGxCIw6lq/jv02uAsXfadomd2ogzAzzQ==
X-Received: by 2002:a17:902:bc8c:: with SMTP id bb12-v6mr3211089plb.275.1541659319706;
        Wed, 07 Nov 2018 22:41:59 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id t26-v6sm3647203pfa.158.2018.11.07.22.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:41:58 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v6 0/3] Add support for audiocodec in Allwinner A64
Date:   Wed,  7 Nov 2018 22:39:26 -0800
Message-Id: <20181108063929.29720-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables sound on Pine64, SoPine boards and Pinebook.

v2: - Use simple-amplifier for speaker amp on Pinebook
    - Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve compatible
      string for other 3 I2S modules in A64 in case if there's any
      incompatibility with H3
v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
    - use ilog2() to calculate reg value for LRCK div instead of using a
      table
v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-codec,
      define our board-level widgets instead.
v5: - collect all the tags
v6: - driver patches has been merged through ASoC tree
    - rebase onto 4.20-rc1
    - Drop 'Speaker' from routes on sopine and pine64, they don't have
      speaker.

Vasily Khoruzhick (3):
  arm64: dts: allwinner: a64: add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
  arm64: dts: allwinner: a64: enable sound on Pinebook

 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 28 +++++++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 42 ++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 28 +++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 58 +++++++++++++++++++
 4 files changed, 156 insertions(+)

-- 
2.19.1

