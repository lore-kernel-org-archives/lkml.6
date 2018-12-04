Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB656C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09C620851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u64yVJK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09C620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLDLcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbeLDKzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02981214D9;
        Tue,  4 Dec 2018 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920952;
        bh=qop8BhrjJAnvhd/UHRRzaR8sJKsnyGw1/RLDgBaXy9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u64yVJK6VIdLwHfT0Z/6tqDCIlVo60ngUF8yhAIsZTQZ6NGdrneQRojoZCu0QrYYw
         t2tBPbOHSiUNj2hHQ85P8geTdTAEa6T8OtVnJZ9mZcXpz1G+QoEZfkFZ9o0vmMwohL
         8X4AMJvZQLO2NI1AZnOkKo8Djss5vrGtZpDNGeWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 023/139] net/dim: Update DIM start sample after each DIM iteration
Date:   Tue,  4 Dec 2018 11:48:24 +0100
Message-Id: <20181204103650.932471064@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/net_dim.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -406,6 +406,8 @@ static inline void net_dim(struct net_di
 		}
 		/* fall through */
 	case NET_DIM_START_MEASURE:
+		net_dim_sample(end_sample.event_ctr, end_sample.pkt_ctr, end_sample.byte_ctr,
+			       &dim->start_sample);
 		dim->state = NET_DIM_MEASURE_IN_PROGRESS;
 		break;
 	case NET_DIM_APPLY_NEW_PROFILE:


