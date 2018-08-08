Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D79AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B69216E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KnVOKtw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B69216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeHHVfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:35:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41350 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHVfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:35:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so1525331pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMRWED+cKPB+pR2VngBwf6nTGoXWIYqIT5aRIpsJTSk=;
        b=KnVOKtw1gNhx9Eepq9czC/4K3n2KE9YfQpINHSFwxKeXCWrT7lbhG//XsOr14eG8kV
         b5i8mqcKF5SsRLvFIVF+Lh30EhnFsaZA5DpJ/oT2dJBGnHRnMLxdKsOYyiZR0+k1NmVZ
         EEWG38GwLD3jh/yz7K4lgVM5Vt5pWb1shEPPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMRWED+cKPB+pR2VngBwf6nTGoXWIYqIT5aRIpsJTSk=;
        b=cQBKEHKo3UndvV0doo7PVtyCfy7gPml3HxSCvYN8zhkBS43ySC937LGSiUjkiCmf+v
         nlzeIqSSX4Vj1RPJyUtKqvgSdvcqAX4TVUHl35SkvDfFTV1+LJa1yYO2VOa9cuvgSftX
         L95h0Lr57mLpThvg+2OriLdUShYHkMHrpnriqWHAb4fqBVEfrDHsP42o4NsERaMZVQa4
         eZBUPVFXV52/F80zsqrMIg7CJPrbmno9TtI2gqfGg4N/0x61rUCxam3lupn1g50HzMb9
         l4RKB4QuT5H1QvzBmGtC68GPbv8JjRn4y1CqixUG0mZRYnFrbNomS/uwR9scb/n0H2EE
         kwtQ==
X-Gm-Message-State: AOUpUlGeiN98Lqyazu1+R8LO3+BPeP6t4H6P68P4hGpVtTBuGtKum8VO
        ci51lNy1d8IEFlWr6zqMpNX+og==
X-Google-Smtp-Source: AA+uWPxJaomB5ZFA1mnvEpEPPSNp4luGqUTUD2olKdbVAxQebsK8kVKVDY00bgZ9E9GZn/jxKcxCWQ==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr4232146pfb.29.1533755652121;
        Wed, 08 Aug 2018 12:14:12 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5431136pga.58.2018.08.08.12.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 12:14:11 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/3] arm64: dts: qcom: pm8998: Add ADC node and die temperature channel
Date:   Wed,  8 Aug 2018 12:13:36 -0700
Message-Id: <20180808191339.16875-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
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

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=2c909be15f45c96d3dc6a84e56a76e5c3c7a60ae

(This series has a trivial conflict with the temp alarm series mentioned
above, if desired I can rebase it on that, I wasn't sure whether it's a
good idea to create a dependency on it)

Matthias Kaehlcke (3):
  dt-bindings: iio: vadc: Fix documentation of 'reg'
  arm64: dts: qcom: pm8998: Add adc node
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 .../bindings/iio/adc/qcom,spmi-vadc.txt        |  4 ++--
 arch/arm64/boot/dts/qcom/pm8998.dtsi           | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

