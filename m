Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321DC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ED82089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbweuMaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ED82089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeJQBD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32732089E;
        Tue, 16 Oct 2018 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709953;
        bh=FquvUbr5S8euvjNrO1XNYr3oDgt8td59qxVRTJVJK5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbweuMaXutZ7gCYO41ZxTwadLpwDGNAAVCxn+Fhv+vO+jNhtWfD+xS+ioy1h92T4c
         lJouoiSypsywXfr/A6mJPvm1k5gTtLjAf2OVGheeSIQ3K3+w0u6aEObwRT1T3szm9z
         bCs7EFKHXBK6tPbozWhntXKw3Hj4xw2WGrPEaYS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 054/135] bnxt_en: Fix enables field in HWRM_QUEUE_COS2BW_CFG request
Date:   Tue, 16 Oct 2018 19:04:44 +0200
Message-Id: <20181016170518.308265180@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 5db0e0969af6501ad45fe0494039d3b9c797822b ]

In HWRM_QUEUE_COS2BW_CFG request, enables field should have the bits
set only for the queue ids which are having the valid parameters.

This causes firmware to return error when the TC to hardware CoS queue
mapping is not 1:1 during DCBNL ETS setup.

Fixes: 2e8ef77ee0ff ("bnxt_en: Add TC to hardware QoS queue mapping logic.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -98,13 +98,13 @@ static int bnxt_hwrm_queue_cos2bw_cfg(st
 
 	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_QUEUE_COS2BW_CFG, -1, -1);
 	for (i = 0; i < max_tc; i++) {
-		u8 qidx;
+		u8 qidx = bp->tc_to_qidx[i];
 
 		req.enables |= cpu_to_le32(
-			QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID0_VALID << i);
+			QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID0_VALID <<
+			qidx);
 
 		memset(&cos2bw, 0, sizeof(cos2bw));
-		qidx = bp->tc_to_qidx[i];
 		cos2bw.queue_id = bp->q_info[qidx].queue_id;
 		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_STRICT) {
 			cos2bw.tsa =


