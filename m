Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F12ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2088020832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="ZNCo8Ulc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2088020832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJYKAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:00:18 -0400
Received: from onstation.org ([52.200.56.107]:46292 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeJYKAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:00:17 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D051C3A7;
        Thu, 25 Oct 2018 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1540430988;
        bh=ht54uc2vprajxYzFag5FnYT5KWDf9eFagiwYtThu6G4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZNCo8UlcXfsj06wT8uWZLKbmtXMVFllEr1WIxuZgBzptZvLmS4I2xVZhseOfmPpjj
         L+EPGlUMJfA7wZrNELGh/9YN4lQIeY6HbDud4tOoE0gvpCA5Lbi1YmI4uDznGtRgvv
         C6wC6mU0GjxeWGzmZmMKighFLhLQHuS8ZnUpShvk=
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, masneyb@onstation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH v3 0/3] ARM: qcom: add vibrator support for various MSM SOCs
Date:   Wed, 24 Oct 2018 21:29:34 -0400
Message-Id: <20181025012937.2154-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for the vibrator found on various Qualcomm
MSM SOCs. This is based on work from:

Jonathan Marek from qcom,pwm-vibrator.c in the PostmarketOS repo:
https://gitlab.com/postmarketOS/linux-postmarketos/commit/7647fb36cb1cbd060f8b52087a68ab93583292b5

Jongrak Kwon and Devin Kim from msm_pwm_vibrator.c in the downstream
Android 3.4.0 sources:
https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-lollipop-wear-release/drivers/misc/msm_pwm_vibrator.c

Driver was tested on a LG Nexus 5 (hammerhead) phone using rumble-test:
https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

Changes since v2
- Moved from pwm to input subsystem based on feedback from
  https://lore.kernel.org/lkml/20181012114749.GC31561@ulmo/. I
  previously wired this into the input system via pwm-vibra.

Changes since v1
- Update device tree binding document based on feedback from Rob
  Herring.
- Changed the driver description to: Qualcomm PWM driver for the MSM
  vibrator.

Brian Masney (3):
  dt-bindings: Input: new bindings for MSM vibrator
  Input: add new vibrator driver for various MSM SOCs
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    vibrator

 .../bindings/input/msm-vibrator.txt           |  36 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  31 ++
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/msm-vibrator.c             | 276 ++++++++++++++++++
 5 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt
 create mode 100644 drivers/input/misc/msm-vibrator.c

-- 
2.17.2

