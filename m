Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630CEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1C321479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrUK/DHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1C321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbeJIB4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeJIB4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:56:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC88E2087D;
        Mon,  8 Oct 2018 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024227;
        bh=yYgvJycr57r4M0yj8CDLjpobGVJ2yZP4baxlFQJA3/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrUK/DHJ7PusR+m3ARKACp6x3z8dddaOZS/Qpiz125oDnpT96AGdv23GE0mRdSkPD
         bCX3QAakSl3Vn+dmEH9tH73EsD/9Gbqe8mxBMYaXZkkB+AoE2qUVNy6idjSXiOR/Ov
         rpcEEzh2mHezvVVt7yr0uAC//E5ramQOxH18oqa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 64/94] net: ena: fix missing calls to READ_ONCE
Date:   Mon,  8 Oct 2018 20:31:45 +0200
Message-Id: <20181008175609.497041117@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 28abf4e9c9201eda5c4d29ea609d07e877b464b8 ]

Add READ_ONCE calls where necessary (for example when iterating
over a memory field that gets updated by the hardware).

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -457,7 +457,7 @@ static void ena_com_handle_admin_complet
 	cqe = &admin_queue->cq.entries[head_masked];
 
 	/* Go over all the completions */
-	while ((cqe->acq_common_descriptor.flags &
+	while ((READ_ONCE(cqe->acq_common_descriptor.flags) &
 			ENA_ADMIN_ACQ_COMMON_DESC_PHASE_MASK) == phase) {
 		/* Do not read the rest of the completion entry before the
 		 * phase bit was validated
@@ -633,7 +633,7 @@ static u32 ena_com_reg_bar_read32(struct
 	writel(mmio_read_reg, ena_dev->reg_bar + ENA_REGS_MMIO_REG_READ_OFF);
 
 	for (i = 0; i < timeout; i++) {
-		if (read_resp->req_id == mmio_read->seq_num)
+		if (READ_ONCE(read_resp->req_id) == mmio_read->seq_num)
 			break;
 
 		udelay(1);
@@ -1790,8 +1790,8 @@ void ena_com_aenq_intr_handler(struct en
 	aenq_common = &aenq_e->aenq_common_desc;
 
 	/* Go over all the events */
-	while ((aenq_common->flags & ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) ==
-	       phase) {
+	while ((READ_ONCE(aenq_common->flags) &
+		ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) == phase) {
 		pr_debug("AENQ! Group[%x] Syndrom[%x] timestamp: [%llus]\n",
 			 aenq_common->group, aenq_common->syndrom,
 			 (u64)aenq_common->timestamp_low +


