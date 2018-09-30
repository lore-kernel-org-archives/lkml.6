Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E14C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAFE20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFTRbtHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAFE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeJABM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:12:28 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32784 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeJABMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:12:18 -0400
Received: by mail-yb1-f196.google.com with SMTP id u88-v6so415939ybi.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bTTvx51xrr3feNxW1j9YOiVhoDbbxXqIrUT5IdtNKeo=;
        b=ZFTRbtHhtgXqeNwQhEaWml6EQfb0uMrIH167bOVvGeT1gjvyxPMPlcnuoZStvbnBgu
         MK+alPm/MSk1kB1mcbTdIGaB3m546b9Kn//jIF+lNogPUG50nDxmFYDl7jJWYTWHbl8p
         YauMYLdm2x5wdgK7/cXWwzi6lXWy0L2G/bN/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bTTvx51xrr3feNxW1j9YOiVhoDbbxXqIrUT5IdtNKeo=;
        b=ik32ueOts7KGCC+RRDcZKa4GYyLniXyVGtKHcyXyXy+EvZtaY432rSiZOu/I7iLh9Z
         PK6cuQzOq54YGfmx8erpSDfPFjlE2LK8I4/qrgnT2Lh7VZG9aAPhW1QDqA8SiS2eEcsh
         x4bvtayTVw91btWxEC4lTM0fNLflB6rcoIteuQyMTzjGAPiaJAHDOkv0Bc4e6KRYk+6t
         awn60xczni5/7cGcttL+3o2T4K9o79X3NxsR5eUVI+2l00aT00v5Zr8yTGawZkGwtbGk
         f7SiJkJPgrQn+WuRQB9hENXSZBzh+81VfdWkpRYG+Q8hQ9YvdxDu6SmEMye8sIaKKmQK
         wkbA==
X-Gm-Message-State: ABuFfojfoGcxxojWkEDHNv7g/YTUvoMMhVz+set66mpI3co2KAKPb53d
        rZPzM0rMTMdm86McV4poCcj8cz9zKqA=
X-Google-Smtp-Source: ACcGV60/gMhc0qej3T7ncgAgEMckXjvMRHIJMDEn3lztxfr0WhNtGsiOyMczfr9yCJFeTYerlSyHTA==
X-Received: by 2002:a5b:ac2:: with SMTP id a2-v6mr4134736ybr.233.1538332690742;
        Sun, 30 Sep 2018 11:38:10 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
        by smtp.gmail.com with ESMTPSA id o202-v6sm26758222ywo.38.2018.09.30.11.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 11:38:10 -0700 (PDT)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.20
Date:   Sun, 30 Sep 2018 13:38:02 -0500
Message-Id: <1538332682-12018-5-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.20

for you to fetch changes up to ca02f96b95ca1a50344e7e2a7bb43fbb825aa3a2:

  ARM: dts: qcom: Update coresight bindings for hardware ports (2018-09-30 13:14:05 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.20

* Fix IRQ constants usage on MSM8974
* Add led, gpio-button, sdcc, and pcie nodes for IPQ8064
* Move/cleanup common nodes for IPQ8064
* Add i2c sensor nodes for MSM8974 Hammerhead
* Fixes for SAW, kpss, opp, pci range, and space/tab on IPQ4019
* Update coresight bindings

----------------------------------------------------------------
Brian Masney (3):
      ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for mpu6515
      ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for ALS / proximity
      ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value

Christian Lamparter (1):
      ARM: dts: qcom: ipq4019: fix cpu0's qcom,saw2 reg value

Frank Rowand (6):
      ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_PPI
      ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_SPI
      ARM: dts: qcom-msm8974: use named constant for interrupt flag EDGE RISING
      ARM: dts: qcom-msm8974: use named constant for interrupt flag LEVEL HIGH
      ARM: dts: qcom-msm8974: use named constant for interrupt flag NONE
      ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value

John Crispin (1):
      ARM: dts: qcom: ipq4019: fix space vs tab indenting inside qcom-ipq4019.dtsi

Mathias Kresin (1):
      ARM: dts: qcom: ipq4019: fix PCI range

Matthew McClintock (2):
      ARM: dts: qcom: ipq4019: use v2 of the kpss bringup mechanism
      ARM: dts: qcom: ipq4019: add cpu operating points for cpufreq support

Sricharan R (4):
      ARM: dts: qcom: Add pcie nodes for ipq8064
      ARM: dts: qcom: Add sdcc nodes for ipq8064
      ARM: dts: qcom: Move common nodes to ipq8064-v.1.0.dtsi
      ARM: dts: qcom: Add led and gpio-button nodes to ipq8064 boards

Suzuki K Poulose (1):
      ARM: dts: qcom: Update coresight bindings for hardware ports

 arch/arm/boot/dts/qcom-apq8064.dtsi                |  71 ++---
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 143 ++++++-----
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts           |  83 +-----
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi           | 125 +++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                | 286 +++++++++++++++++++++
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |  83 ++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 198 ++++++++------
 7 files changed, 731 insertions(+), 258 deletions(-)
