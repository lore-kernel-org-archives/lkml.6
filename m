Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D5C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E232170F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="XW05+3ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E232170F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeHCCMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:12:38 -0400
Received: from onstation.org ([52.200.56.107]:33936 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeHCCMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:12:38 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 513C211;
        Fri,  3 Aug 2018 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1533255542;
        bh=JIhKB1VJ6eBa+WHVMZQ0V0LVa80s3LeQOMpxqGs2jlM=;
        h=From:To:Cc:Subject:Date:From;
        b=XW05+3ZAxjGY/qZ5FQylAAJbAh0q5WOQnPAxwY6RsOUgLFjbU0CIZEfmbURoi4qlh
         C3edCxxzChCQsdBnwqctiDOfhJv+O00wNEkO2w41sFfAk5zmyjGho1eDvYyVwUANfO
         evY7MhAjEB4OKu6onz53ULUMNw8Futs/lEykaUGo=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: [PATCH v3 0/9] treewide: add support for various sensors on the LG Nexus 5 (hammerhead)
Date:   Thu,  2 Aug 2018 20:18:51 -0400
Message-Id: <20180803001900.25371-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for the gyroscope / accelerometer
(mpu6515), magnetometer (ak8963), temperature / pressure (bmp280), and
proximity / ALS (tsl2772) sensors to the LG Nexus 5 (hammerhead) phone.

Changes since v2:
- Updated dt property names for tsl2772: amstaos,proximity-diodes and
  led-max-microamp based on feedback from Jonathan Cameron and Rob
  Herring.
- Removed regulator_enabled flags.
- Refactored tsl2772 regulator code.
- Split out device tree bindings into separate patches.

Changes since v1:
- Correct mpu6050 patch based on feedback from Jonathan Cameron. See
  that patch for more details.
- Add support for proximity / ALS driver (tsl2772).

Brian Masney (9):
  iio: imu: mpu6050: add support for regulator framework
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    mpu6515
  iio: tsl2772: add support for reading proximity led settings from
    device tree
  dt-bindings: iio: tsl2772: add new bindings
  iio: tsl2772: add support for regulator framework
  dt-bindings: iio: tsl2772: add bindings for regulator framework
  iio: tsl2772: add support for avago,apds9930
  dt-bindings: iio: tsl2772: add binding for avago,apds9930
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for ALS /
    proximity

 .../bindings/iio/imu/inv_mpu6050.txt          |   1 +
 .../devicetree/bindings/iio/light/tsl2772.txt |  42 ++++
 .../devicetree/bindings/trivial-devices.txt   |  10 -
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  83 ++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  22 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  62 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   2 +
 drivers/iio/light/tsl2772.c                   | 194 +++++++++++++++++-
 8 files changed, 403 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt

-- 
2.17.1

