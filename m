Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF96C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91F20869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HCKpZE8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A91F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeIGBmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:42:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35927 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeIGBms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:42:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so5849603pgo.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IJ8oLUZzM/xspKzJfPCWYqTM9r7WC/yYCvxNC2tgtg=;
        b=HCKpZE8zVHAbbskP1hNmWI/QEvTCCiszP3f9fGukwG3CWukhbgSD389x7OjyqkmRMo
         8siXR+bmHGQiiRgVIVDhh43CrDk1gmm78RIAHul6V0M9fxH95RDgDBvsyU7WrdqdaKry
         59i5mMkVytmDDgFps+GirGDLjWSf9kaRh9Euw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IJ8oLUZzM/xspKzJfPCWYqTM9r7WC/yYCvxNC2tgtg=;
        b=XrkBm/3eZtfgR8FfUY8mTNo0XCzmbXc7HcpaPtKFTtD+W+z4sp5KIu3sW8lwyeBEQ1
         QlTz8OQsrGyt7yzjBEy5AMP25a/Bee/+yz8Xen5OIHZ8AdCEcXnIyCJwOGDUXRMvxT51
         fmLHWC5ad/X/TV4HLDU3sYi8nVvC5xp2gvtP08c0t9hFo1tb/k6YnRqdSAFvp9NzrBRA
         q7R1WLWBIBZTNz3qbHDeJP/kaSM5rslFFKKRwguwtBwQHxjpvIr62GOT3uCmD7Ds5i7l
         A1Ke+hwt03ipwCLGlDuNt1kC6pFasAeyeGLzL7mz024MufG8oLzVLDROkUhzWko96Ghl
         hAZA==
X-Gm-Message-State: APzg51CCFb+F0tWPVaFQKWPIIIemyZC7Kv7sz9GSNGpUmv3vYcDuy/k1
        lf1xt7ge5gCFuW064PmmMsB1gQ==
X-Google-Smtp-Source: ANB0VdbI3Lsnu+cVRX7GNfHK1IpmK2Wj2u2d+QI9CoVQaMDrreR2bxihyNuCNvawfVOfUz6OTQoSUQ==
X-Received: by 2002:a63:1d47:: with SMTP id d7-v6mr4879932pgm.180.1536267932882;
        Thu, 06 Sep 2018 14:05:32 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8271288pfn.123.2018.09.06.14.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:05:32 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: pm8998: Add ADC node and die temperature channel
Date:   Thu,  6 Sep 2018 14:04:51 -0700
Message-Id: <20180906210454.247219-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the DT node for the QCOM SPMI PMIC5 ADC and a channel
for the die temperature.

The die temperature is going to be used by the temperature alarm driver
(https://lore.kernel.org/patchwork/project/lkml/list/?series=361416).

My understanding is that some of the ADC channels are/can be universally
useful on devices with a pm8998, while the use of others is device specific
(e.g. AMUX). Siddartha / QCA folks, are there other generally useful ADC
channels that should be added here?

The driver for the QCOM SPMI PMIC5 ADC landed in the 'testing' branch of the
'iio' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=e13d757279bbc59776c8435fb94e54b5a58bdd0b

Matthias Kaehlcke (3):
  dt-bindings: iio: vadc: Fix documentation of 'reg'
  arm64: dts: qcom: pm8998: Add adc node
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 .../bindings/iio/adc/qcom,spmi-vadc.txt         |  4 ++--
 arch/arm64/boot/dts/qcom/pm8998.dtsi            | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.19.0.rc2.392.g5ba43deb5a-goog

