Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C07820873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UxYVox60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C07820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeGIPVR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:21:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39196 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbeGIPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:21:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so11402998wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=v7Mgbb96FR6curU+vKXpLEnw/dME4DGBiNuzdTXvHfc=;
        b=UxYVox60GExlj2DcEeEWydqqOvleQbbW6tKaBsC561tU16FuOrFShKMXcDzr1tWvoP
         ddjZk1Dp0MaDY/Z+TpYhmUbxfl1ByDwU1HfZYUqye+aUItrKtFnim53OYShnA+FxNXur
         otH8fMzFQhLoeXvUwaSnSGcQhhbfx50tGJHycEvQiwa2XcYjlnPFGWgl9RBC65F4cReh
         E8XmeTd0LQzky1+GeDD86746Uw2agwuQU4yqzXrFxAoGZMINcgiTtAlpNbUyYm5IV/ky
         IaErqn4fK4SB9x6ZNn7jLQVfduz/uKs2MsByCDUDX1jJoks+zfE6eMdvF8B/D/rX8os1
         7Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v7Mgbb96FR6curU+vKXpLEnw/dME4DGBiNuzdTXvHfc=;
        b=K2j8wkyJNHKJu3Ldh38SIEDWAJTpMEx+6cOs9EdmVhyl1Khe+G8aIrYIFMMRBxadjl
         MtcRY5/xYzwlRyTs3ay84YfKu7UoK+sGOHeACfM+kaK4pbap4qgjDc+2o2Sy51KKLUPe
         cLt+khHcJ5EVsIwgeZPLcwlTIK35NjREHe/Zun0KHLr+fYpY6+9nQ6qC+64TFk56LXWh
         88wPYOz2VTsEdubReHr1CcF11GnZ+Ss0vowHicBZrdFvuqSE6uhiIY+HiFF8sGfAdnRm
         BFrmAgHwxDD12PwHS5MePHqTj79PZvkc6TCxfTUQZzvUprRTr8UEH3/pwjZDps0KggeK
         RJMA==
X-Gm-Message-State: APt69E0DIb980jiZ261P8V93OzRIzoQKImO5vOTsMeT4Blc93qlwHdwM
        CbrQRSbVIN1/sR7H1zITMFjBiA==
X-Google-Smtp-Source: AAOMgpc5s4HcgIEE40ozS0eBWWO2olych5Klx8rHRIIMbNy0oQYOCIiHPT8XRjDSEyNk7vzsQoGBgg==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr13993878wrg.62.1531149672947;
        Mon, 09 Jul 2018 08:21:12 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p4-v6sm14468474wrj.71.2018.07.09.08.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:21:12 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/4] sun8i: r40: add AHCI
Date:   Mon,  9 Jul 2018 15:20:54 +0000
Message-Id: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

With Moeicenowy's agreement, I have take leadership ot this patchset.

There are no really changes appart renaming struct quirck to variant.

Since the last serie is really old, I will answer comment here.
The two regulator (1.2 and 2.5V) are not for the PHY since:
- nothing in the schematic said that they are for the PHY, they seems
  only for controller
- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
  cannot be used for target)

Furthermore, the AHCI binding support only one regulator per PHY, so
using the "target" regulator is out of question for registring this two
non-phy regulator.

I hope this answer all comments done on last version.

Regards

Corentin Labbe (3):
  ata: ahci_sunxi: add support for R40 SATA controller
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

Icenowy Zheng (1):
  dt-bindings: add binding for Allwinner R40 SATA AHCI controller

 .../devicetree/bindings/ata/ahci-platform.txt      |   1 -
 .../bindings/ata/allwinner,sun4i-a10-ahci.txt      |  40 +++++++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  18 +++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |   9 ++
 drivers/ata/ahci_sunxi.c                           | 124 ++++++++++++++++++++-
 5 files changed, 188 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt

-- 
2.16.4

