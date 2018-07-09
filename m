Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D941C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D242089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D242089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933622AbeGIPmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:42:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33644 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932867AbeGIPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:41:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so36754546oiy.0;
        Mon, 09 Jul 2018 08:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VN5drlHG/owW1ZCROjrGMgGuELt55Fx170XSAuwxoHY=;
        b=PeHwWVNhoyVXp+S4Ce0aeJlu63Ux4KYjCbh9t8+j38hWzGSQGFINsOEqhxJUwL9PQx
         tDir76/m0OVXtDwElYaWBerENQIYWC30SW/+sFu0SN0t9uxc68mSCOcN2MvKOhYI4nEg
         K+yOQNk1gl54ov9DTnQspl4Qqah0g6PwzFBQI1GRG3J5elmlgwnIHFP8s/Vu0XS93bXW
         RQSbez5Q+YoqgirkS4Dvym94/TKqQ3m+3VD3GK92Etyye82aV3nEJ1X9TEyG6UU+kA6v
         lbVMmVH9WxutowgBHp+QzqnVvEkISHNaL/cLtUM9CMyyHFIELjRDnXZzARHyfIBB2rmT
         KKXw==
X-Gm-Message-State: APt69E2HXyUZhtToyWQ+FnqleJzeljgYo4ETkHDbJqXR42X5nrMXjXtf
        4a3j4WEvchEsIppnRYzMvQUjNJ8=
X-Google-Smtp-Source: AAOMgpdgyQ0fyCcb0pUrfqikaS/HzQnE4xBcTtDGE9Rbm6IccdVVVcpTIVjZ8t3p9iXCn4122OxK3Q==
X-Received: by 2002:aca:f383:: with SMTP id r125-v6mr12499720oih.6.1531150918665;
        Mon, 09 Jul 2018 08:41:58 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id z196-v6sm30759391oig.12.2018.07.09.08.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:41:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/6] Make deferring probe forever optional
Date:   Mon,  9 Jul 2018 09:41:47 -0600
Message-Id: <20180709154153.15742-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series came out of a discussion on the ARM boot-architecture
list[1] about DT forwards and backwards compatibility issues. There are
issues with newer DTs breaking on older, stable kernels. Some of these
are difficult to solve, but cases of optional devices not having
kernel support should be solvable.

I tested this on a RPi3 B with the pinctrl driver forced off. With this
change, the MMC/SD and UART drivers can function without the pinctrl
driver. I left the dts change out this time.

v2 and v3 of this series can be found here[2][3].

Rob

[1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html
[2] https://lore.kernel.org/patchwork/project/lkml/list/?series=347413
[3] https://lore.kernel.org/patchwork/project/lkml/list/?series=357344

Rob Herring (6):
  driver core: allow stopping deferred probe after init
  dt-bindings: pinctrl: add a 'pinctrl-use-default' property
  pinctrl: Support stopping deferred probe after initcalls
  iommu: Stop deferring probe at end of initcalls
  iommu: Remove IOMMU_OF_DECLARE
  PM / Domains: Stop deferring probe at the end of initcall

 .../admin-guide/kernel-parameters.txt         |  9 +++
 .../bindings/pinctrl/pinctrl-bindings.txt     |  6 ++
 drivers/base/dd.c                             | 59 +++++++++++++++++++
 drivers/base/power/domain.c                   |  2 +-
 drivers/iommu/arm-smmu-v3.c                   |  2 -
 drivers/iommu/arm-smmu.c                      |  7 ---
 drivers/iommu/exynos-iommu.c                  |  2 -
 drivers/iommu/ipmmu-vmsa.c                    |  3 -
 drivers/iommu/msm_iommu.c                     |  2 -
 drivers/iommu/of_iommu.c                      | 21 +------
 drivers/iommu/qcom_iommu.c                    |  2 -
 drivers/iommu/rockchip-iommu.c                |  2 -
 drivers/pinctrl/devicetree.c                  | 15 +++--
 include/asm-generic/vmlinux.lds.h             |  2 -
 include/linux/device.h                        |  2 +
 include/linux/of_iommu.h                      |  4 --
 16 files changed, 90 insertions(+), 50 deletions(-)

--
2.17.1
