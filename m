Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20AE2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxPNE/TU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20AE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbeKZWAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZWAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:00:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E73020645;
        Mon, 26 Nov 2018 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230377;
        bh=BjG6lzcT06SpvdPTlev6IwSaMZGi8F8fMoietZw6mJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxPNE/TUAq0w5tv1WJz7YVvFcW5giYIGC1kAfzT0gxMzz8TLFC5jHkuhvoDT0B2A3
         cidRZtsasTiN/Yelc8D9vzhzCvtVKq3j8H5u9gL1g2zVGo7Akc0VHXyd/9+4O4ztBa
         +Md6xhzF/06zHSYqyhzuSFk96f8rHjJ/Tg/MnjQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/118] ice: Fix the bytecount sent to netdev_tx_sent_queue
Date:   Mon, 26 Nov 2018 11:51:12 +0100
Message-Id: <20181126105104.753463979@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



