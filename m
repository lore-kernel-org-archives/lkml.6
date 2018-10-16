Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EDDC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25A42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3NxRSgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25A42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJQBDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeJQBDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65A3A20866;
        Tue, 16 Oct 2018 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709944;
        bh=uyUBVmW0oq+jLo0TYzr194fC/RPTOwk3mekCXbjzxZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3NxRSgDXExYVxFWkVSgxrUSMc03h9mu7HHGvhSJeiMSZJEK8boCyhpk8NoZCZf+v
         yV5A9mNDcuhp/aZvgV6cw5wU5Bi5bXxYQSmOaenGdNyOZL8EIOQroKRJ60e9BnMbmF
         MfyhbpRsmTILqG3YhzZRWWX7h2m3Pn9+Bu2+MvAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 051/135] bnxt_en: Fix VNIC reservations on the PF.
Date:   Tue, 16 Oct 2018 19:04:41 +0200
Message-Id: <20181016170518.175043239@linuxfoundation.org>
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

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit dbe80d446c859873820eedfff4abc61c71f1927b ]

The enables bit for VNIC was set wrong when calling the HWRM_FUNC_CFG
firmware call to reserve VNICs.  This has the effect that the firmware
will keep a large number of VNICs for the PF, and having very few for
VFs.  DPDK driver running on the VFs, which requires more VNICs, may not
work properly as a result.

Fixes: 674f50a5b026 ("bnxt_en: Implement new method to reserve rings.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4651,7 +4651,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt
 				      FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
 		enables |= ring_grps ?
 			   FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS : 0;
-		enables |= vnics ? FUNC_VF_CFG_REQ_ENABLES_NUM_VNICS : 0;
+		enables |= vnics ? FUNC_CFG_REQ_ENABLES_NUM_VNICS : 0;
 
 		req->num_rx_rings = cpu_to_le16(rx_rings);
 		req->num_hw_ring_grps = cpu_to_le16(ring_grps);


