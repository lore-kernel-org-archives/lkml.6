Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83492C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A40720673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8aknY5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A40720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeGZGWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:22:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37572 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeGZGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:22:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so370104pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 22:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ceFnTmxQPfvKFlcjJPNf0KRAmeXXOimer6WKQOqkrlU=;
        b=C8aknY5SanwLy8gCmCVLLiCcUu3Cxsh/nOm/vEz0gG68vzZMiZuEyKU99qN4GAglRG
         XDUxRjtibmr4GCePjDdD7msZc0gGGwuepLMlH8qRgk2tply7NzUpJ+RZ5WLBT1xS59Ng
         R31yfa6rJGYmJp7b91+cmz90I+iA4XIWUexqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ceFnTmxQPfvKFlcjJPNf0KRAmeXXOimer6WKQOqkrlU=;
        b=jnUiE7f5jSZsof8KTSHqAA+kGNe9cXM84LnmhAlxSdwnUzFfN7jA3GzMi4/xckCc3R
         QKyPXgYMO5mQgQ0DxJzebO/4LxQ5vHfw5r7WChfTVOqdhOBgiTj0rcn3kvFGkzcWLRBo
         e5NQIONK+QIzZTr44jE+cBtcl9/Kpox7pcH+H3po3RR16QABDxy7LaUK4zzPK1ewVtVb
         F9le3+NdqSFDrVeU2lmolxXQC2/v5d3XsbjGutll9BR6uYSylV07mo+ti7ZLpl6vUBYT
         hqPvNe+2IRG7eTGQEDQx4tMmfvFEb6Ga/0jowzaJ6gPwISNVBpfmT2/emt/jI8D9oQBE
         0m8Q==
X-Gm-Message-State: AOUpUlEZib/3wvW/UPBPEMmgjj/yHUQchQOP7BRFbn3aPVbTa+zjEsO0
        fQiO7Dcc7v3bO3tO/QP2AqP+
X-Google-Smtp-Source: AAOMgpeZ+Q8BM0bqCQOlD//oWu5sJ0pbVbLGLXHWW/rfJhp86GtyjbXP220kZ8OI78R7CFXCTVvkFw==
X-Received: by 2002:a63:dc53:: with SMTP id f19-v6mr537108pgj.56.1532581639030;
        Wed, 25 Jul 2018 22:07:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6208:6a6e:a8cb:6394:3bdf:2b97])
        by smtp.gmail.com with ESMTPSA id y4-v6sm492540pfm.137.2018.07.25.22.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 22:07:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Add Actions Semi Owl family S900 DMA Controller support
Date:   Thu, 26 Jul 2018 10:36:54 +0530
Message-Id: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds DMA controller support for Actions Semi Owl family
S900 SoC. This driver has been structured in a way such that there will be only
one controller driver for the whole Owl family series (S500, S700 and
S900 SoCs).

There are 12 physical channels and 46 logical channels supported by the
DMA controller.

The DMA controller also supports 4 software configurable interrupt lines for
the priority based DMA usecase. But the DMA driver supports only 1 interrupt
for simplification. By default, the driver uses Linked list mode for all
transfers. Right now only MEMCPY support has been added and the rest
(SLAVE, CYCLIC) will be added in upcoming patches.

The driver has been tested using dmatest utility on the Bubblegum-96
board.

The DTS patches in this series depends on the pinctrl DTS patches
submitted [1], which is yet to be merged by the platform maintainer
Andreas. Since the DMA driver goes through DMA tree and the relevant
DTS patches goes through ARM-SoC tree, Andreas will pick it up once
it has been reviewed.

For the reference, I have queued up all reviewed dts patches so far
in my repo [2] from which Andreas is picking them for 4.19.

Thanks,
Mani

[1] https://patchwork.kernel.org/patch/10322937/
[2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next

Changes in v3:

As per Vinod's review:

* Removed unused header and API's
* Used GENMASK for defines
* Removed per member comment for structs
* Modified pchan* and dma* API's to use corresponding containers as
  arguments
* Removed error messages regarding the no free channels
* Added devm_free_irq in dma_remove
* Used dmaengine instead of dma for commit titles

Changes in v2:

* Fixed up the multi-line alignments according to `checkpatch --strict`

Manivannan Sadhasivam (4):
  dt-bindings: dmaengine: Add binding for Actions Semi Owl SoCs
  arm64: dts: actions: Add Actions Semi S900 DMA Controller
  dmaengine: Add Actions Semi Owl family S900 DMA driver
  MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver

 .../devicetree/bindings/dma/owl-dma.txt       |  47 +
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  13 +
 drivers/dma/Kconfig                           |   8 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/owl-dma.c                         | 971 ++++++++++++++++++
 6 files changed, 1042 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 drivers/dma/owl-dma.c

-- 
2.17.1

