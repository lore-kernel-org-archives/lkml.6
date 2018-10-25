Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39933ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCFB214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2Lz1ErL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCFB214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbeJYWx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbeJYWx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:56 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68D421479;
        Thu, 25 Oct 2018 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477258;
        bh=DFj2vPUdIJ0F4tkD/+rAV590YYMY8c4guCnyOnIRghM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2Lz1ErLKiXOXQdbBL4den2+zL4UYLNodjSWpHI3mCZnRo/RJqpbnFUCw6TMBWTF1
         jUSclThWkf0qKdmhDyguvXrGPT07YTb0knGCLSKCq0d55kaKCQcxDo2cncaow1+55H
         2JAwJnqidmkblJrID957koxwDHNyP0BHX4Dh+Uh8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 82/98] igb: Unpair the queues when changing the number of queues
Date:   Thu, 25 Oct 2018 10:18:37 -0400
Message-Id: <20181025141853.214051-82-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>

[ Upstream commit 37a5d163fb447b39f7960d0534de30e88ad395bb ]

By the commit 72ddef0506da ("igb: Fix oops caused by missing queue
pairing"), the IGB_FLAG_QUEUE_PAIRS flag can now be set when changing the
number of queues by "ethtool -L", but it is never cleared unless the igb
driver is reloaded.
This patch clears it if queue pairing becomes unnecessary as a result of
"ethtool -L".

Signed-off-by: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ffad88e8a29..84049078c4f0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2941,6 +2941,8 @@ void igb_set_flag_queue_pairs(struct igb_adapter *adapter,
 		 */
 		if (adapter->rss_queues > (max_rss_queues / 2))
 			adapter->flags |= IGB_FLAG_QUEUE_PAIRS;
+		else
+			adapter->flags &= ~IGB_FLAG_QUEUE_PAIRS;
 		break;
 	}
 }
-- 
2.17.1

