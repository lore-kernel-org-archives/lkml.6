Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC92321872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJlsRFt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfADU4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:56:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33977 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfADU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so17934035plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ElBjH0oOsuewQ5qkTBqSFhRYlw1E1pEbHM7AsYL8nVs=;
        b=YJlsRFt7rSdlC4/aiKztcBA0pdS+bBJo5TOoc5WsSqN7Tv27V1B+i7t8M8NrjCEXUn
         QzIZ/8EyZwgrtLiS8TssVwo8iYzUlxQgGlxjVsST6y6cbUu3nd9hxaQlN2SmTVroWiaI
         H0pfCb16JSuFLYZ6z/Oy3M8gWMXfL+ErtGsjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ElBjH0oOsuewQ5qkTBqSFhRYlw1E1pEbHM7AsYL8nVs=;
        b=W/gfyq2d19qvKeRffINVq7ew1zLpnC21nrBW98zBRp9+Uv84onMfawQWmvZsVb8cdH
         bLhpsg8YFvcLjeWC4AX6xbgdY1I4+yxJ+DjBr6TUgQ1BHQorw2DSnFoBWXlN7xYC8Mp6
         jGFGgU1CrA3YKwAYnNg4HHXHxwbn4P5MUHAqRi4gtHopW5+obwuHLjJJcL3JAX8AZwty
         /+vNv5m/DUYHJBpceLqmBDNC9nnJZCAeHDO8O9hmtc4i7WCQf8p/gkjxHzO9STz5WWSy
         AnAoUlAKkfFjvcq+63bX8xXoLZcportv7bKY3k50sfyipA0H+cw8iqoO5fAs4pI4DtCq
         tTJg==
X-Gm-Message-State: AJcUukfFYRA6SDPCzmgd1Ob6WWWC59vpNWkPF9+PDqKedwrukMBPfDiE
        ELRvinCvxE8dncKPP3hyxbS32OUfXfaEmw==
X-Google-Smtp-Source: ALg8bN7HrvutjzMcEujRyx/xslInrqd4lahi7pFchnwiJVKEJcM1nyGUsT+tNVpnxEoWdK7ZgSOkgQ==
X-Received: by 2002:a17:902:784d:: with SMTP id e13mr53096524pln.188.1546635392657;
        Fri, 04 Jan 2019 12:56:32 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:31 -0800 (PST)
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
Subject: [PATCH 0/8 v2] k3dma patches to add support for hi3660/HiKey960 
Date:   Fri,  4 Jan 2019 12:56:20 -0800
Message-Id: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on recent work by Tanglei Han, and
adds support for hi3660 SoCs as found on the HiKey960 board,
along with a few patches I've been carrying.

Review and feedback would be greatly appreciated!

thanks
-john

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
  Documentation: bindings: k3dma: Add binding for dma-avail-chan
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-avail-chan

Li Yu (2):
  dma: k3dma: Delete axi_config
  dma: k3dma: Add support to dma_avail_chan

Youlin Wang (3):
  Documentation: bindings: k3dma: Extend the k3dma driver binding to
    support hisi-asp
  dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
  arm64: dts: hi3660: Add hisi asp dma device

 Documentation/devicetree/bindings/dma/k3dma.txt |  7 ++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 22 ++++++++-
 drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
 3 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.7.4

