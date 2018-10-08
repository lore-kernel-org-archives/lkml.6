Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2481C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF2D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWns1hS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF2D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJIA3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:29:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44919 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJIA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:29:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so8519166pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CN5s4ecUj3pRaRBc5F3N9iKtufjq28Ma2Mtwvzmhwvk=;
        b=dWns1hS3LQOD2KVT0K6ESnWaao0gmLhx41081rKNIPthLpS42aVeGylCgnSwvR+HrM
         0kM5Elrfw/6J9bS79uzRnieYgckNSoNvaa9zt7Y04KERCGtbgVdgLv9dsfr/WfctPXNV
         RRHsACNno2glKZxuWoXtwl/PqSc02R6VYbouo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CN5s4ecUj3pRaRBc5F3N9iKtufjq28Ma2Mtwvzmhwvk=;
        b=r3CsOjXQPIqf46QOsUVZmFtjR5n7KOKD7i7nYVsfVMuwUBrgcVElWPVS1qolLCcRIR
         u/G27ZD5E5N5hEs2BdHutOhpxr0VN6w3UiDCLBgrzgn4K8OAQNyq6FEb83llgPtj9tKg
         mdI9KijZ03NIA9kS3OQsBbQ2/sxFU0Zj+sU2RBOX/I8ZFpwba9TBhM2qk16dmj/sOqKc
         MA9j4qB9lU1sq3HC0Ksk+vu35dxFsiNlZcIyMiJeUr7iMAq9OHDsqfHdjHfNm1S8WQis
         OtM5z2acDfWT0HLwjYol8llmREqwkfa39R566lEpQxr/cBYmFryFDzPF1rYR0q8QTB0r
         FtIA==
X-Gm-Message-State: ABuFfoiqkQYBVJRFoK/w9wwbB5iI+a1TWFrZG5ihLGhJ07cmW+8++e7+
        KPQmCeMSTiTHEvGERKpHwNT8
X-Google-Smtp-Source: ACcGV63Xl/ug1qVoaqEwmXVQL4i/bmJvGXNSIAStTJmXckElj4a8fcpOwiGVVcBHsan+QKZW9ZYiKw==
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr25858021pfc.232.1539019017811;
        Mon, 08 Oct 2018 10:16:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:996:3731:9fd:1785:d893:1e98])
        by smtp.gmail.com with ESMTPSA id y24-v6sm8288974pfn.123.2018.10.08.10.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 10:16:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     afaerber@suse.de, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] dmaengine: owl: Fix warnings generated during build
Date:   Mon,  8 Oct 2018 22:46:31 +0530
Message-Id: <20181008171631.5603-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following warnings are generated when compiled with W=1,

drivers/dma/owl-dma.c:170: warning: Function parameter or member 'cyclic'
not described in 'owl_dma_txd'
drivers/dma/owl-dma.c:198: warning: Function parameter or member 'cfg' not
described in 'owl_dma_vchan'
drivers/dma/owl-dma.c:198: warning: Function parameter or member 'drq' not
described in 'owl_dma_vchan'
drivers/dma/owl-dma.c:225: warning: Function parameter or member 'irq' not
described in 'owl_dma'

Fix this by adding comments for relevant struct members to appear in
kernel-doc.

Fixes: d64e1b3f5cce ("dmaengine: owl: Add Slave and Cyclic mode support for
Actions Semi Owl S900 SoC")

Reported-by: Vinod Koul <vinod.koul@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/owl-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 1d26db4c9229..90bbcef99ef8 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -162,6 +162,7 @@ struct owl_dma_lli {
  * struct owl_dma_txd - Wrapper for struct dma_async_tx_descriptor
  * @vd: virtual DMA descriptor
  * @lli_list: link list of lli nodes
+ * @cyclic: flag to indicate cyclic transfers
  */
 struct owl_dma_txd {
 	struct virt_dma_desc	vd;
@@ -188,6 +189,8 @@ struct owl_dma_pchan {
  * @vc: wrappped virtual channel
  * @pchan: the physical channel utilized by this channel
  * @txd: active transaction on this channel
+ * @cfg: slave configuration for this channel
+ * @drq: physical DMA request ID for this channel
  */
 struct owl_dma_vchan {
 	struct virt_dma_chan	vc;
@@ -204,6 +207,7 @@ struct owl_dma_vchan {
  * @clk: clock for the DMA controller
  * @lock: a lock to use when change DMA controller global register
  * @lli_pool: a pool for the LLI descriptors
+ * @irq: interrupt ID for the DMA controller
  * @nr_pchans: the number of physical channels
  * @pchans: array of data for the physical channels
  * @nr_vchans: the number of physical channels
-- 
2.17.1

