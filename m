Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3057C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5E42087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcdkkAlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5E42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbeJICEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbeJICEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFC9204FD;
        Mon,  8 Oct 2018 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024690;
        bh=vlZkPvKDe6/jBdxfBxfNUttO7s8cZGhO3e8LA4xX314=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcdkkAlhZ+GJ1pEECR3LvrxotEe+0vbzH6mZ1hjScAmxeq0HBHO8G2CLA2oJxoaiL
         AnhETiCAlmee9mG+wdyeV8RbM1AOitAF9k6N9mQ5kY6081YIGORELk63lys2GRzuuJ
         Crqqj+EV6xLxZnPcpMucISeAiU8E+WIZ/UREBloU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 123/168] net: ena: fix missing calls to READ_ONCE
Date:   Mon,  8 Oct 2018 20:31:43 +0200
Message-Id: <20181008175624.725073888@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -459,7 +459,7 @@ static void ena_com_handle_admin_complet
 	cqe = &admin_queue->cq.entries[head_masked];
 
 	/* Go over all the completions */
-	while ((cqe->acq_common_descriptor.flags &
+	while ((READ_ONCE(cqe->acq_common_descriptor.flags) &
 			ENA_ADMIN_ACQ_COMMON_DESC_PHASE_MASK) == phase) {
 		/* Do not read the rest of the completion entry before the
 		 * phase bit was validated
@@ -637,7 +637,7 @@ static u32 ena_com_reg_bar_read32(struct
 
 	mmiowb();
 	for (i = 0; i < timeout; i++) {
-		if (read_resp->req_id == mmio_read->seq_num)
+		if (READ_ONCE(read_resp->req_id) == mmio_read->seq_num)
 			break;
 
 		udelay(1);
@@ -1796,8 +1796,8 @@ void ena_com_aenq_intr_handler(struct en
 	aenq_common = &aenq_e->aenq_common_desc;
 
 	/* Go over all the events */
-	while ((aenq_common->flags & ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) ==
-	       phase) {
+	while ((READ_ONCE(aenq_common->flags) &
+		ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) == phase) {
 		pr_debug("AENQ! Group[%x] Syndrom[%x] timestamp: [%llus]\n",
 			 aenq_common->group, aenq_common->syndrom,
 			 (u64)aenq_common->timestamp_low +


