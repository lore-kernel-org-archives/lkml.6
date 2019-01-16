Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50634C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180C220651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSC6QX8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405414AbfAPRKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:10:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35338 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391517AbfAPRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3103406pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6lU/QXZ6PixbpkGrYwz26+me4JRjz2P8Wqin4wO2y6M=;
        b=eSC6QX8WfE0rag8cfgMdkJN3CCSoBhtoh6K1UYVX2FwEpCEB1asANskYRWgMLCGJID
         8LX//X1dn7zi6X1zurVR11JxF1GaX2qaxub+uGrH7JUX+TaGbBUMuQyWdiMt35DmVie+
         GwMiHHW82fDsFCTx2GY6p/tUFM6UJ0IQuVyC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6lU/QXZ6PixbpkGrYwz26+me4JRjz2P8Wqin4wO2y6M=;
        b=lVA/Xhr0MQE5deQBZ1OoN9c503902hEW6Wq3fnOaHOQYqQVOP6rw08SvWADeL3kkBr
         w+NwwDuzKddD3yf95EknWRtPdH8jZWnkd/+Dca3+zxEJmtHATVPk2y+ikM7abZuecZ7h
         MEk0xjGhwsEFgXWac/18E4ZuKAIgS45FMe7UnmReFP4n3nvq8bQD3WPxh1x9UZq7B98l
         aDQ0eBPGN1PBe8DwFbB4ydikjhrDgBgajNWjcc/qF2Er47k61gfyG/IihwxdyRACq3IZ
         BCOjJtuqsDDe4ImcYf/KD3NNvFvlmcKTBAqpor7k93YxzIajl4uRQrUt31TjYcpb56t0
         Humg==
X-Gm-Message-State: AJcUuked9FMVp4eG9GYtvkVy4R91tJ1ko+uW+2BH7BvA0l/Npr+9O4cr
        c1pF3CUIg5l5awKU8Xv8gN9apB32LIUu3g==
X-Google-Smtp-Source: ALg8bN4aeDHRM6MhJ58qVrHEyVr3pC2SujM5CGqXC7rRAq11+k/dU8aM5R4KyLc0sdIGmVxpa92PXg==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr10745642pfe.152.1547658642471;
        Wed, 16 Jan 2019 09:10:42 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:41 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8 v4] k3dma patches to add support for hi3660/HiKey960
Date:   Wed, 16 Jan 2019 09:10:21 -0800
Message-Id: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on recent work by Tanglei Han, and
adds support for hi3660 SoCs as found on the HiKey960 board,
along with a few patches I've been carrying.

thanks
-john

New in v4:
* Rework hisi,dma-avail-chans to generic dma-channel-mask, per Rob's suggestion

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
CC: devicetree@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


John Stultz (3):
  Documentation: bindings: dma: Add binding for dma-channel-mask
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask

Li Yu (2):
  dma: k3dma: Delete axi_config
  dma: k3dma: Add support for dma-channel-mask

Youlin Wang (3):
  Documentation: bindings: k3dma: Extend the k3dma driver binding to
    support hisi-asp
  dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
  arm64: dts: hi3660: Add hisi asp dma device

 Documentation/devicetree/bindings/dma/dma.txt   |  4 ++
 Documentation/devicetree/bindings/dma/k3dma.txt |  4 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 20 ++++++++-
 drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
 4 files changed, 77 insertions(+), 11 deletions(-)

-- 
2.7.4

