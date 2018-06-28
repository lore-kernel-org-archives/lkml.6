Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D275F24C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D275F24C9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbeF1Unt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:43:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37984 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbeF1Uns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:43:48 -0400
Received: by mail-yb0-f193.google.com with SMTP id f12-v6so2533925ybp.5;
        Thu, 28 Jun 2018 13:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MBw/TUiTzAGrYRjToKJCmT0iIojVoEoD7cDXN8AgjeM=;
        b=G4O9jLbsOakH7IbCPfH0eo0xBFz19svkalP+GbyypB4tYoijzwNSR7Jndc9YS2xn1l
         glPOuJEd/t00LVJj3dtycwNdDz0mcoxh3NTpyfy2m357ruBYsIryOPVe8USlnVXR6jO3
         nwllldTT36SLaiX1NkvzcOkf0gxuheroGEJMF2o34Urya1I0vyJ8r9eSqByNPH1r7sc/
         9Fm+T1u7K/9CMOKpK/c8g6gg0mvuJbECMAv7BqGwaEQFPZ60T1T+EpNL6NOT3HBDtDq4
         L9bXSwChNzHd8yZkZrIkeatJs9WSA5Pn4hN2bU1B4eiRHDZpAB4LfJNAgYUDMeNtI/BY
         BDRQ==
X-Gm-Message-State: APt69E2FqFQbP6GX2GaZkFzGOoi80eh/SJWt+CVzB1IpX+HC8YQYnPJQ
        cbo7WxVHtOox4AKl2rfl6A==
X-Google-Smtp-Source: ADUXVKJmKl8Gg9rNXsxCoRB/JGRirF3V9rcZTLumzmEvuauj4CGRKQ/AvTT9JgUlbS+7/nFAMdFE1A==
X-Received: by 2002:a5b:451:: with SMTP id s17-v6mr5987573ybp.310.1530218627636;
        Thu, 28 Jun 2018 13:43:47 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm427913ywi.32.2018.06.28.13.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 13:43:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/6] Make deferring probe forever optional
Date:   Thu, 28 Jun 2018 14:43:38 -0600
Message-Id: <20180628204344.13973-1-robh@kernel.org>
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

v2 of this series can be found here[2].

Rob

[1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html
[2] https://lore.kernel.org/patchwork/project/lkml/list/?series=347413

Rob Herring (6):
  driver core: allow stopping deferred probe after init
  dt-bindings: pinctrl: add a 'pinctrl-use-default' property
  pinctrl: Support stopping deferred probe after initcalls
  iommu: Stop deferring probe at end of initcalls
  iommu: Remove IOMMU_OF_DECLARE
  PM / Domains: Stop deferring probe at the end of initcall

 .../admin-guide/kernel-parameters.txt         |  9 +++
 .../bindings/pinctrl/pinctrl-bindings.txt     |  6 ++
 drivers/base/dd.c                             | 57 +++++++++++++++++++
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
 16 files changed, 88 insertions(+), 50 deletions(-)

--
2.17.1
