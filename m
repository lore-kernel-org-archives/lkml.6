Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF8C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F09721479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FAzNdVeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F09721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJDHFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:05:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45986 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJDHFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:05:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so2431652pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pew+TlToS4X8xcH8taZB7koK5NQKzPZUZeU6FAJeCtc=;
        b=FAzNdVehXaJF0OF6K5KwFqLDUtM8w8oZZnQ1xhNV65IQEXWkdHX8kpSaLXwdSpR0ae
         Q3xlZnct7AX1rVlS+NCXeXTYdWlsQMa2b8kj1qpH9Y3uUVabc+RwjPkuc1Xj4wkcm8oE
         F/m9e9VOmhA1m9qMU9+Z6i1MGLCe7HMnetdSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pew+TlToS4X8xcH8taZB7koK5NQKzPZUZeU6FAJeCtc=;
        b=ALF4QpIqRK7moW0c+pxAat4YFdKVD3W/tE7dwf5ICQ3yreZfl1cHBi+dfChgwlODfv
         GODnUwILT9W9LxqpRPPQ9gQOcqfT2+A3hLvT9MyvHkUb1j9d6IGd5rhWB/xDAh2Tl/Ed
         Bif0aVoDitqRxJKxAnGnCnsN6oP2Ma+eFjqFIkxMDJirOejxbUFPjheduFQl5pNmnSvv
         lJRALdzS+2F2cSujgZXWgWcYhqzZDGu4fM7Jx0DereDQlP57qgBwJR+l+98p6FSno1Rj
         7J8HrgPBBArJQv6+cd4bLjQlWfa6O9e/VCsApzsTEGRmQni2CNwGAmxiwBnivZwc4L/y
         xT6Q==
X-Gm-Message-State: ABuFfoiag5JPMyMD/9oPywutS27iXdRoNlY+d91u1C50/G7I6dnYpJSd
        li+u2F6UnPTjKspIj8S57I0EWA==
X-Google-Smtp-Source: ACcGV618mN9kEegZlkUgYDrJvsABsuzEM4e87n4Gu/Y3rlfmyI5l8LdFZ/WSiT3Xg6dijNEkplR9TQ==
X-Received: by 2002:a62:cf04:: with SMTP id b4-v6mr4066486pfg.224.1538612090060;
        Wed, 03 Oct 2018 17:14:50 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b81-v6sm6497051pfm.96.2018.10.03.17.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 17:14:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 0/2] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date:   Wed,  3 Oct 2018 17:14:30 -0700
Message-Id: <20181004001432.21218-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a channel for the die temperature to the QCOM SPMI
PMIC5 ADC. It also fixes an example in the DT documentation.

The die temperature is going to be used by the temperature alarm driver
(https://lore.kernel.org/patchwork/project/lkml/list/?series=361416).

The former name of the series was "arm64: dts: qcom: pm8998: Add ADC
node and die temperature channel"
(https://patchwork.kernel.org/project/linux-arm-msm/list/?series=17165),
2 of the 3 patches of this series already landed in Andy's tree, hence
the new name.

Matthias Kaehlcke (2):
  dt-bindings: iio: vadc: Update example to include unit address for
    node 'usb-id-nopull'
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi                         | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.19.0.605.g01d371f741-goog

