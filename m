Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86356C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7ED23C98
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrBhnTLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7ED23C98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934318AbeFVDYd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:24:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38545 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934222AbeFVDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:24:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id d10-v6so2746857plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IjKMaOgE9zO1u/HVhRELMHSOg+lOul8SQchpt8VVzQc=;
        b=QrBhnTLb7S7AqMwIB2K+SBPS36RHLjjPuQimYntmqVPLmhtok0lHpBc1gVghGpja8B
         sG8urSt5BhuYE59MpUaLR2RYo6M+UBZvJODuQFBu5hTxdKTHwYfQRH1CZop101YTUtcm
         OaRxsftGLWt11yy5m3phUFKpOib33STrvYyR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IjKMaOgE9zO1u/HVhRELMHSOg+lOul8SQchpt8VVzQc=;
        b=k8V09bhL3E6+t3u3SNveCvuJ9vaLchJrqAtql0BehoiC+HvJlYNQNguIhVYWt9rja1
         AktZWwlOZOWECXz2OPIM+K5cfwQ7xzeToePgzORNPZOt8MFuCec9GqRXsnQzwwlSwnfm
         cEVywDsBoHS2igMxkdPFUVYUle94lRE5BrIEOIyXsVSq5UA+5Lf272OIlNCMW07SMgtV
         js6oo9kmvIMBPHb/1r/2HEEnB5PCbBj/bPIxV6wK44Noct+i5RZXxear4qsR6WNqlgmU
         USRnl16XoJPYX4OXIzjHICHyITYq5knTUO1zWaIbdDwsllPUxFt1YSnhEZ6OJC+1rm8K
         BgKw==
X-Gm-Message-State: APt69E1w0bha8ikB3orDmk+auu46C4Uba45ossROWlv2ii8dmbB9nnvR
        wYVbSZZVJLZVOo7BBNvlkHWbag==
X-Google-Smtp-Source: ADUXVKIi1p9j/z6mM1meF4ExFRIH9wsnPc/MuG4I06oyXe0mWSV+dBrWb4zyzy/Z+fwSq1nuN62zLA==
X-Received: by 2002:a17:902:9004:: with SMTP id a4-v6mr31386577plp.143.1529637870774;
        Thu, 21 Jun 2018 20:24:30 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.153])
        by smtp.gmail.com with ESMTPSA id a23-v6sm9286253pfn.113.2018.06.21.20.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 20:24:30 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH 0/3] k3dma: add support to reserved channels
Date:   Fri, 22 Jun 2018 11:24:13 +0800
Message-Id: <20180622032416.20133-1-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes bug people found on hikey960 when allocating DMA
channels to peripherals such as SPI. It fails because the channel is
reserved, and is not accessible by kernel.

Patch 1 and 2 add support to reserved channels for K3 DMA. Patch 3
includes a removal of axi_config who controls DMA secure/non-secure
access permission but is actually set in early stage by bootloader.

Li Yu (3):
  dt-bindings: k3dma: add optional property dma_min_chan
  k3dma: add support to reserved minimum channels
  k3dma: delete axi_config

 Documentation/devicetree/bindings/dma/k3dma.txt |  6 ++++++
 drivers/dma/k3dma.c                             | 16 ++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.17.1

