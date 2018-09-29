Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E1EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FEE2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmNW7ZNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FEE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeI2OOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:14:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43683 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeI2OOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:14:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id q19-v6so6012799pgn.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Le0+fZzaKqGj1u7hIshlfZ0jn3TTHXdHW4NsWzkL+MA=;
        b=jmNW7ZNXWOG80EV1F3cCgzgpKQcBbzNqPC6V6B1xZ7OpOku320rkg2Y3dX/ELomNH3
         X9tZ4fzgmQs8pXSnP/3YWzmP8cB1E7LUx2IvdnozCNPjTy5TLGumil6IDKteM7IA+862
         x3M8bt4lGU/3honV0NHwWBYmfoX0zTuXq4JDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Le0+fZzaKqGj1u7hIshlfZ0jn3TTHXdHW4NsWzkL+MA=;
        b=apo7pRc1YCLpSql8aomfgKGWYYjI3sb+7x/srO7YGnkPzRzOeYWn6KsFs5WTxZno9Z
         vR0cOx6s63Iix/7QX+8O9ykJ/yp0S9yWpRh2wQ9QOYWoaEa+9PDteRvB4iAhWUZepng3
         AKFE95Yn2AsSPnsQl3E8y/eNbENmsNA0KZ4SFp3a5tOR119SwXIz+1hfsy6HewMUI/FT
         MfGuv32MM+QgHW0gREN3I0RheCqfZ034G1TjRosVFlVDFIj9cW7u8khgECCliuBbkea8
         t+ijXLIuD26VMVpbQm3/l5S/fQjvST3KgVTzzNQgNoBCflhl7FGmyQQf8tVkpbNYiEJP
         sgzw==
X-Gm-Message-State: ABuFfoipGpfr++uk3uU9azNa7Ub0ynoAHbz5CdgiTh5B6VfWhYLhUcqm
        GxVH6jWfpxNuT7UERPgxysE/
X-Google-Smtp-Source: ACcGV61lhxiCXuv43QkJe5H4PaNljdh9W6KIHsHRH4x7NQAAKaQ5M70rJluBDmy1skaKxp7QiP4FEA==
X-Received: by 2002:a62:4e09:: with SMTP id c9-v6mr2017490pfb.105.1538207215781;
        Sat, 29 Sep 2018 00:46:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:717:b0f2:f0af:8cc:da39:e2c3])
        by smtp.gmail.com with ESMTPSA id m21-v6sm9926570pgd.6.2018.09.29.00.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 00:46:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add slave DMA support for Actions Semi S900 SoC
Date:   Sat, 29 Sep 2018 13:16:34 +0530
Message-Id: <20180929074637.9766-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds slave DMA support for Actions Semi S900 SoC of the
Owl family. As a consumer, enable TX DMA support for UART peripheral
in S900. The UART driver still supports interrupt mode if there is no
DMA property specified in DT.

The dts patch depends on the previous DMA patches which is not yet
merged.

Thanks,
Mani

Changes in v2:

* Modified the comment for bus width as per Vinod's suggestion

Manivannan Sadhasivam (3):
  arm64: dts: actions: s900: Enable Tx DMA for UART5
  dmaengine: Add Slave and Cyclic mode support for Actions Semi Owl S900
    SoC
  tty: serial: Add Tx DMA support for UART in Actions Semi Owl SoCs

 arch/arm64/boot/dts/actions/s900.dtsi |   2 +
 drivers/dma/owl-dma.c                 | 279 +++++++++++++++++++++++++-
 drivers/tty/serial/owl-uart.c         | 172 +++++++++++++++-
 3 files changed, 445 insertions(+), 8 deletions(-)

-- 
2.17.1

