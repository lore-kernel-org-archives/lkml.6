Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29029C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C695120881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i2GgIwK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C695120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeIJU62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:58:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33162 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIJU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:58:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so10713673pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0ww0jBWDUDmCAsp7jh8C9gla0gpVzxNE9ldeq7D5L8=;
        b=i2GgIwK+/QJvfO/DwvU1xt40jjjmRA5uBf84nAIbYMMlWv7g4uO5cUWwWFS1ZyI8D1
         vFnj/V4iqXBkMfiVtlAsJpQI+1EofJjwXiSBy7iTFz9op9HBpSZOpCgl7drvCGw1WbBC
         3hWMZQnLejPzGki9EpJlFmRJwHJBAhONSJSdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0ww0jBWDUDmCAsp7jh8C9gla0gpVzxNE9ldeq7D5L8=;
        b=dTXKmNAdPBPPR+d03D5wKULh5eJBtI2lbr7Vn+xetC3LwtaH9jdmBqCT/+N6nrr2CH
         somkL06+hTLCB5ihBvt3MZyvMy5Te8jFNtY2H4O44VDwjVhuDtHyRJG/mNlQ672dqQ39
         jMNL1OzxocWkhbhyrpiK4RaqSjxVGCFNVejJhYmArNSvWOMt09NHV55pRXN5NjAfG2N3
         b/FBmEJnEztXofn9BJZndH6pf1pSUboMsjKFaRVoF3cc+wXt/YrqFsgviqLis4vFDQ8D
         gUaLFmE6xLhVPEWWeWhEbIZFwh0hk1CxqntZKVJJe6lXTeIbXY8qi9RvjRVlBpLDvCjH
         pCgg==
X-Gm-Message-State: APzg51BetFQ2ASSUmG3TxDSvB5W1GR30OcZjajMTj6bBTnh60U0sb+oB
        FAJcaUW0WBjSfhTTNJMO571c+A==
X-Google-Smtp-Source: ANB0VdbhEgX5KRQz2wWNpDXVvzbaSn1gFMAOtKZLn5KV7NIeWhxTWIjDAfKu+gLjahwUMFtIE+oUBw==
X-Received: by 2002:a62:8186:: with SMTP id t128-v6mr24135193pfd.192.1536595421831;
        Mon, 10 Sep 2018 09:03:41 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b3-v6sm33893517pgm.74.2018.09.10.09.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:03:41 -0700 (PDT)
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
Subject: [PATCH v3 0/3] arm64: dts: qcom: pm8998: Add ADC node and die temperature channel
Date:   Mon, 10 Sep 2018 09:02:58 -0700
Message-Id: <20180910160301.237538-1-mka@chromium.org>
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

