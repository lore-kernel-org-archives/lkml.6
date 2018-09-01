Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E04C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C869B2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/ddFPYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C869B2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeIAUzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:55:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38521 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeIAUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:55:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id f4-v6so1502424pgq.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XNJdvxTA3kkAmewIk12VKooCaTPzww9/QAvYulchVO4=;
        b=I/ddFPYHeBCAHh7eAQi0yBqXUagu30CbWJ7JleWpBs4BEHoSCg6Flr4j+nI1z2wYgC
         KAS5qsskwdBpk8KDb/tGTsbsFq69JBKiXPmbcikKIia+fvwD8pSbUnUfWt/fJV0RvGCw
         dAbbZt55/lOX0rQu+KsK0lO8j9+7Nu4xd8CMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XNJdvxTA3kkAmewIk12VKooCaTPzww9/QAvYulchVO4=;
        b=n8/KZRoUbS/dFMLwHyYvfgOWDwDBW0peM7NuBbXUSBuF9nleXlJhvg4bu97Oby28Bw
         amT4L/GC7b0VFzorIvQSwsZKRUaE9E1GX1Ra9fSZIPf3XJ+otbCRAyhG8FeVzDiLFnnw
         J+Cp93dS7ypCcLd9MvYDiJya72A8Y03C4wb1JCQV9bv/TYfr47e28w04qlZINUSv3vj6
         CPxo76/S6Cm8pL/RX1ZShwBihzAKCTMbdE+dUoblnqwpxk7exlPLJUX0Ad6GYzYsRH8Y
         CuXVIhkdvwiRJgQTno9gH26n5yeas33Tiq6CHSXDzrnMsn9GAjlR3LaOffIMBFTgx7ds
         l+DA==
X-Gm-Message-State: APzg51CfVV3Kh7BYoBYDnqPJvVcq9ieBgPNbga47vHZuVEb5+emtoRmp
        twiQYMtqdwBC0JFwVKiXSmX8
X-Google-Smtp-Source: ANB0VdYYUuB1cv/l7dz8OT9oqYKn24PoX0RiTlqaWDpBVqQwpWkZ6nnOzyPHtiLGiHVvoXpEGyA8sw==
X-Received: by 2002:a63:c347:: with SMTP id e7-v6mr19550197pgd.240.1535820156829;
        Sat, 01 Sep 2018 09:42:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:724a:4d47:6510:16:9ba1:39a3])
        by smtp.gmail.com with ESMTPSA id y7-v6sm23763595pff.181.2018.09.01.09.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 09:42:36 -0700 (PDT)
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
Subject: [PATCH 0/3] Add slave DMA support for Actios Semi S900 SoC
Date:   Sat,  1 Sep 2018 22:12:12 +0530
Message-Id: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (3):
  arm64: dts: actions: s900: Enable Tx DMA for UART5
  dmaengine: Add Slave and Cyclic mode support for Actions Semi Owl S900
    SoC
  tty: serial: Add Tx DMA support for UART in Actions Semi Owl SoCs

 arch/arm64/boot/dts/actions/s900.dtsi |   2 +
 drivers/dma/owl-dma.c                 | 273 +++++++++++++++++++++++++-
 drivers/tty/serial/owl-uart.c         | 172 +++++++++++++++-
 3 files changed, 439 insertions(+), 8 deletions(-)

-- 
2.17.1

