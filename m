Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2857C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F22B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wEsK6Z+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F22B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeJYWvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbeJYWvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:02 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E5F620869;
        Thu, 25 Oct 2018 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477085;
        bh=4yseitOg8JrFs32hsvJP8qLP1b0UQfA2UGyUGxf+2To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wEsK6Z+WyqDCSY5if/+b5EPdAt+71rlIPwQA1zQTCP/Ds4iyNoOolaJCjymdY9NhS
         N64reWVpd76yOJdWPhIAX2yV9QStrLeKbzNXfx/JdmrZbDZBrQwpM8u18JTVCuJXwa
         oHkpIwShXF0UXzS0ASb6FMWwkwQaiQvu4FMZIZ38=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dauchy <william@gandi.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 36/65] ixgbevf: Fix handling of NAPI budget when multiple queues are enabled per vector
Date:   Thu, 25 Oct 2018 10:16:36 -0400
Message-Id: <20181025141705.213937-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dauchy <william@gandi.net>

[ Upstream commit d0f71afffa1c3d5a36a4a278f1dbbd2643176dc3 ]

This is the same patch as for ixgbe but applied differently according to
busy polling.  See commit 5d6002b7b822c74 ("ixgbe: Fix handling of NAPI
budget when multiple queues are enabled per vector")

Signed-off-by: William Dauchy <william@gandi.net>
Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 50bbad37d640..723bda33472a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1014,6 +1014,8 @@ static int ixgbevf_poll(struct napi_struct *napi, int budget)
 	ixgbevf_for_each_ring(ring, q_vector->tx)
 		clean_complete &= ixgbevf_clean_tx_irq(q_vector, ring);
 
+	if (budget <= 0)
+		return budget;
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	if (!ixgbevf_qv_lock_napi(q_vector))
 		return budget;
-- 
2.17.1

