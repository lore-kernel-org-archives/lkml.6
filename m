Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C6FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A282089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="OofLD7pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A282089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeJAMG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:06:27 -0400
Received: from onstation.org ([52.200.56.107]:35930 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbeJAMG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:06:27 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id F3D51187;
        Mon,  1 Oct 2018 05:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538371827;
        bh=dXGZUhh10Wbo655nthLyXyAyNFOZhL/4JiyHCV4NvS4=;
        h=From:To:Subject:Date:From;
        b=OofLD7pYnKP75IkR+hfaI/3j6d0KTP0+0jdyTj2X+y2FMpAo3b2FV2Sf92NROAU79
         5LUFX62Rf2OaEcVlfRu/1aPqzwKQWAaJenMSMaEZMiOu0fnrdpgQ8Io2IhzHFpz+/j
         9CINNFMYvvzAYOl+FHNFplUs5sGz0bHNW9j1zgAc=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH RFC 0/5] treewide: add USB OTG support for hammerhead
Date:   Mon,  1 Oct 2018 01:30:00 -0400
Message-Id: <20181001053005.18906-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds USB OTG support for the LG Nexus 5 (hammerhead)
phone. My only question is related to patch #4 where the GPIO support
is added to bq24190_charger. Based on the information in the device tree
binding Documentation/devicetree/bindings/power/supply/bq24190.txt, I
should be using a gpio-hog. I'm not sure what my input pin would be for
this particular board since I can't find a publicly-available datasheet
for this board.

The USB OTG support works properly with this patch set. I am able to use
USB networking, and I'm also able to plug in a USB hub with a thumb
drive on the phone, and mount the drive.

All of the other msm8974-based boards in upstream use the
qcom,pm8941-charger (via the smbb node) that is defined in
qcom-pm8941.dtsi. USB networking works for me with that driver, however
I'm not able to get any devices connected to my USB hub to show up on
the phone, even when I port the GPIO code into that driver. I can see
the USB hub node with lsusb, but no devices on the hub.

Thanks in advance for any assistance that you can provide.

Brian Masney (1):
  dt-bindings: power: supply: bq24190_charger: add bq24192 and
    usb-otg-vbus

Jonathan Marek (4):
  power: supply: bq24190_charger: add support for bq24192 variant
  power: supply: bq24190_charger: add of_match for usb-otg-vbus
    regulator
  power: supply: bq24190_charger: add support for extcon and GPIO for
    USB OTG support
  ARM: dts: qcom: msm8974-hammerhead: add USB OTG support

 .../bindings/power/supply/bq24190.txt         |  7 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 54 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 drivers/power/supply/bq24190_charger.c        | 51 +++++++++++++++++-
 4 files changed, 121 insertions(+), 2 deletions(-)

-- 
2.17.1

