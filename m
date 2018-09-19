Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70C7ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE2320877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBnIo/wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE2320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeISLO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:14:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37035 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISLO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:14:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so5279857wmc.2;
        Tue, 18 Sep 2018 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7OO9ZjfdDfredXmhzZcuDZQ8HZkc06lbp3sjLT1Lw0=;
        b=BBnIo/waY0u/rNawwBZIe8HXyZDAlyC0GtTmJcNnegytI1Ur6XkeuZ9ZhQwW9CwwgL
         3G7sOkzaslFXac700D++h4RET/dbk7hDJziJHEF8+Rt8bOGsLGwqICy7IP4+NNJLaVHe
         pfh36LZCLAotHopxZC2pWMUGb3LNRJ/IezXykS2YsFe2e8MkNNUU+L+ywMf3jKAIzfVq
         ASmHOwFafbVUZrr1WdXaZ7f9ppPfCmQtPmcwWFJidMOS4ceeTjElZuS1AGM2TMXUFzLV
         C/6myFVCB65oh4QYsRqvUISKD6nDuhBkf4ZiFFJt8NYLaBAQj84zNFDwoEErmvyT4hU7
         5gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7OO9ZjfdDfredXmhzZcuDZQ8HZkc06lbp3sjLT1Lw0=;
        b=G9H7uvX0op6Xwszyp1sgSzyNubJQeT1RR59BekuTDXjr9p0uIRXZ5c/P+8NDu7UyaJ
         P5h2wOHUqPCtyVoTH7IBFjYgjwBjsZXBQlhQD9MJiUCurJG0Hp5xXfpdhGjhYwA/xV7t
         B8XilHgEdUKKTn0HX2eZIfNDtn+2fYiN+cgmX+BuJaUKAWf52nx3rKZFicXILApsxbR1
         rmSFERdGJXqg5Kp58YZ5IKO7hVtrVDna4xofx8NxG8c26WI54ZgGgLNWzR3oGklv1pSw
         QyWID8ncwhMuqpQEfFoWqiKv27iBoutWicUABhh/0jEY8LobVaKl6S8YYzdTZqYPlGj5
         mAqA==
X-Gm-Message-State: APzg51AIvyPQJvoK4rrKRlx7RcZ4fv/7hB3ltiooeKkaPxGKuRwvE2L5
        ri1cC+gAV5X4qIp2bjHWs30=
X-Google-Smtp-Source: ANB0VdaPVbdMLQSztl//kEif40TqeVophYf5lXB653U5ptMXh/kuTdqjAkGdX5Dh4H25bhY7hloSPw==
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr1428005wmb.19.1537335521536;
        Tue, 18 Sep 2018 22:38:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x15-v6sm17265416wrt.53.2018.09.18.22.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 22:38:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] PCI: kirin: Fix section mismatch warning
Date:   Tue, 18 Sep 2018 22:38:29 -0700
Message-Id: <20180919053829.4858-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
the function kirin_pcie_probe() to the function
.init.text:kirin_add_pcie_port()
The function kirin_pcie_probe() references
the function __init kirin_add_pcie_port().
This is often because kirin_pcie_probe lacks a __init
annotation or the annotation of kirin_add_pcie_port is wrong.

Remove '__init' from kirin_add_pcie_port so there is no mismatch.

Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 5352e0c3be82..9b599296205d 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
 	return 0;
 }
 
-static int __init kirin_add_pcie_port(struct dw_pcie *pci,
-				      struct platform_device *pdev)
+static int kirin_add_pcie_port(struct dw_pcie *pci,
+			       struct platform_device *pdev)
 {
 	int ret;
 
-- 
2.19.0

