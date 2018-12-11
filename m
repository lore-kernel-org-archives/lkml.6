Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36564C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11292087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543645;
	bh=ICRS+M4pDHlOhDRNm7u6NXo4oVULx7SeigPapauqeP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dlKXuZOckWWdym59zdPC+VR7nXFnrlNEEN7JRXxx6hfkPXJNr6Av0K3o/U1Sbkk2T
	 DvdCtbxT6iDKO+wZvwwf1Q4rqskf+te8j4ioAWYNIe2nxqusqifmvTJt1x37VDssd3
	 iBT5qsQnKge00uId1frs7yJ6+sxoSoGHlJQDREfA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11292087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeLKPyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbeLKPx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFCF52087F;
        Tue, 11 Dec 2018 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543636;
        bh=ICRS+M4pDHlOhDRNm7u6NXo4oVULx7SeigPapauqeP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdwGPjsR+cKm/oDruLFXnSmhvGuyc+zQxIR2wbLaeohBFOzqXM37R7hs2butiuCx8
         7fEADeohBgnzblr4fFRvANDuIEjaTFy0NCZdMqli7dJ6BBWV8Bk8vXRkZ7HHb3Klyo
         L7d9USBaqysNw2LAfiC54bqAFJGI7gSMXE56svfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.14 44/67] dmaengine: dw: Fix FIFO size for Intel Merrifield
Date:   Tue, 11 Dec 2018 16:41:44 +0100
Message-Id: <20181211151632.616412228@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit ffe843b18211301ad25893eba09f402c19d12304 upstream.

Intel Merrifield has a reduced size of FIFO used in iDMA 32-bit controller,
i.e. 512 bytes instead of 1024.

Fix this by partitioning it as 64 bytes per channel.

Note, in the future we might switch to 'fifo-size' property instead of
hard coded value.

Fixes: 199244d69458 ("dmaengine: dw: add support of iDMA 32-bit hardware")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/dw/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1064,12 +1064,12 @@ static void dwc_issue_pending(struct dma
 /*
  * Program FIFO size of channels.
  *
- * By default full FIFO (1024 bytes) is assigned to channel 0. Here we
+ * By default full FIFO (512 bytes) is assigned to channel 0. Here we
  * slice FIFO on equal parts between channels.
  */
 static void idma32_fifo_partition(struct dw_dma *dw)
 {
-	u64 value = IDMA32C_FP_PSIZE_CH0(128) | IDMA32C_FP_PSIZE_CH1(128) |
+	u64 value = IDMA32C_FP_PSIZE_CH0(64) | IDMA32C_FP_PSIZE_CH1(64) |
 		    IDMA32C_FP_UPDATE;
 	u64 fifo_partition = 0;
 
@@ -1082,7 +1082,7 @@ static void idma32_fifo_partition(struct
 	/* Fill FIFO_PARTITION high bits (Channels 2..3, 6..7) */
 	fifo_partition |= value << 32;
 
-	/* Program FIFO Partition registers - 128 bytes for each channel */
+	/* Program FIFO Partition registers - 64 bytes per channel */
 	idma32_writeq(dw, FIFO_PARTITION1, fifo_partition);
 	idma32_writeq(dw, FIFO_PARTITION0, fifo_partition);
 }


