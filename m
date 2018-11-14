Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A63C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98B02252F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlgD0UPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98B02252F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeKOI3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388492AbeKOI3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:51 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9043722530;
        Wed, 14 Nov 2018 22:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234287;
        bh=boWMhWuXcDeXdREyAoKxNXLm7/7kxjnMmxOr5fhpdjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlgD0UPjGVRsrXN1yMx2KOoE7QELyY/BkeCnv5pHoxCQsghMM/yEDw/TSEmoQv2Sh
         YRnxiS3Q64CKd9UsgTiRaKgPOLzenXDkMXorA4jRx8FtxenDdByXyLbmC2j9ePywAV
         ySkuwLofl/t3fNMTUid7BZbOOyCzScBow4RoQzJU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 44/59] ice: Fix the bytecount sent to netdev_tx_sent_queue
Date:   Wed, 14 Nov 2018 17:23:16 -0500
Message-Id: <20181114222335.99339-44-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit d944b46992f8e99b6bdc721e44b02e5ca294fa2b ]

Currently if the driver does a TSO offload the bytecount sent to
netdev_tx_sent_queue will be incorrect. This is because in ice_tso we
overwrite the initial value that we set in ice_tx_map. This creates a
mismatch between the Tx and Tx clean flow. In the Tx clean flow we
calculate the bytecount (called total_bytes) as we clean the
descriptors so the value used in the Tx clean path is correct. Fix this
by using += in ice_tso instead of =. This fixes the mismatch in
bytecount mentioned above.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 6481e3d86374..0c95c8f83432 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1519,7 +1519,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 
 	/* update gso_segs and bytecount */
 	first->gso_segs = skb_shinfo(skb)->gso_segs;
-	first->bytecount = (first->gso_segs - 1) * off->header_len;
+	first->bytecount += (first->gso_segs - 1) * off->header_len;
 
 	cd_tso_len = skb->len - off->header_len;
 	cd_mss = skb_shinfo(skb)->gso_size;
-- 
2.17.1

