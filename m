Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BB320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH1rK6UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BB320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbeKAIfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730244AbeKAIJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E101120664;
        Wed, 31 Oct 2018 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027337;
        bh=CcRV/kLR6yrTXK2LsYZVJ1fn+J7L4h2aDCegqemHkzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nH1rK6UKz/6sKe7CMqE62nIR7yvGjFaDA/3KSu49uXeAhOeNwG1d6d9nkNhB3RqrS
         sAO35sRJNLpDdbL/Jr6SOL8Vp2zmbZSNtiBSL5f7bc51SpwX+cJePcWUOOi/qQb7rD
         wNdnhpBIsrJF5VNocninFwi192gQfUWa6Qf5CJlE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shannon Nelson <shannon.nelson@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 068/126] ixgbe: disallow IPsec Tx offload when in SR-IOV mode
Date:   Wed, 31 Oct 2018 19:06:56 -0400
Message-Id: <20181031230754.29029-68-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>

[ Upstream commit 47b6f50077e68bcd544f657526dad4bfdce7e87d ]

There seems to be a problem in the x540's internal switch wherein if SR-IOV
mode is enabled and an offloaded IPsec packet is sent to a local VF,
the packet is silently dropped.  This might never be a problem as it is
somewhat a corner case, but if someone happens to be using IPsec offload
from the PF to a VF that just happens to get migrated to the local box,
communication will mysteriously fail.

Not good.

A simple way to protect from this is to simply not allow any IPsec offloads
for outgoing packets when num_vfs != 0.  This doesn't help any offloads that
were created before SR-IOV was enabled, but we'll get to that later.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index da4322e4daed..add124e0381d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -676,6 +676,9 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 	} else {
 		struct tx_sa tsa;
 
+		if (adapter->num_vfs)
+			return -EOPNOTSUPP;
+
 		/* find the first unused index */
 		ret = ixgbe_ipsec_find_empty_idx(ipsec, false);
 		if (ret < 0) {
-- 
2.17.1

