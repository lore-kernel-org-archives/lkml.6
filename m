Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77382145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcDPZx5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77382145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeK2REr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbeK2REr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:47 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55B3921104;
        Thu, 29 Nov 2018 06:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471236;
        bh=9vMIX1bgse4wUDGz7mvxAxSIu4G3V4CmnaT1rgGYmk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcDPZx5led4CxLFYEa4hDsfyUy+//FCBS42LocKGFu2R/f+lzFo4VQeRk6J91U2xY
         UCx9aGFJ4Na0/6Z199KYhWbfvAcWOBZHd74T1ybaKB1+f7I4PrnbRV1/5woUmy8hGz
         nNghEzUk0lxca0AVge84F+PrWsmrfyTkXe6h7SqI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tal Gilboa <talgi@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 59/68] net/dim: Update DIM start sample after each DIM iteration
Date:   Thu, 29 Nov 2018 00:55:50 -0500
Message-Id: <20181129055559.159228-59-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Gilboa <talgi@mellanox.com>

[ Upstream commit 0211dda68a4f6531923a2f72d8e8959207f59fba ]

On every iteration of net_dim, the algorithm may choose to
check for the system state by comparing current data sample
with previous data sample. After each of these comparison,
regardless of the action taken, the sample used as baseline
is needed to be updated.

This patch fixes a bug that causes DIM to take wrong decisions,
due to never updating the baseline sample for comparison between
iterations. This way, DIM always compares current sample with
zeros.

Although this is a functional fix, it also improves and stabilizes
performance as the algorithm works properly now.

Performance:
Tested single UDP TX stream with pktgen:
samples/pktgen/pktgen_sample03_burst_single_flow.sh -i p4p2 -d 1.1.1.1
-m 24:8a:07:88:26:8b -f 3 -b 128

ConnectX-5 100GbE packet rate improved from 15-19Mpps to 19-20Mpps.
Also, toggling between profiles is less frequent with the fix.

Fixes: 8115b750dbcb ("net/dim: use struct net_dim_sample as arg to net_dim")
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/net_dim.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index c79e859408e6..fd458389f7d1 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -406,6 +406,8 @@ static inline void net_dim(struct net_dim *dim,
 		}
 		/* fall through */
 	case NET_DIM_START_MEASURE:
+		net_dim_sample(end_sample.event_ctr, end_sample.pkt_ctr, end_sample.byte_ctr,
+			       &dim->start_sample);
 		dim->state = NET_DIM_MEASURE_IN_PROGRESS;
 		break;
 	case NET_DIM_APPLY_NEW_PROFILE:
-- 
2.17.1

