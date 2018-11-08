Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F8C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B607320883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i90oSF5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B607320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbeKIHnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbeKIHnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:13 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9147221019;
        Thu,  8 Nov 2018 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714742;
        bh=2K5Xnf9C8gaaPw7hh8MQp4N66WiTxlJjdCWhyOiRKB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i90oSF5WnMvoNWoFMJGEh8fOKTgSOm/FgWL5xlGb0DePOmgsX3HWY0eZ/EcSq+sRZ
         r5787zJqka7EbVfLypG2DALVAD9wIlA3TaMo2gYL/WzW+bAsCbhQvxOm98YvAUjTjI
         FthimQVmxAFMpjcM1+dhxpDphu0HesqY721e+tIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helmut Grauer <helmut.grauer@de.ibm.com>,
        Talat Batheesh <talatb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 073/171] net/mlx5e: Fix fixpoint divide exception in mlx5e_am_stats_compare
Date:   Thu,  8 Nov 2018 13:50:43 -0800
Message-Id: <20181108215132.834039205@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e58edaa4863583b54409444f11b4f80dff0af1cd ]

Helmut reported a bug about division by zero while
running traffic and doing physical cable pull test.

When the cable unplugged the ppms become zero, so when
dividing the current ppms by the previous ppms in the
next dim iteration there is division by zero.

This patch prevent this division for both ppms and epms.

Fixes: c3164d2fc48f ("net/mlx5e: Added BW check for DIM decision mechanism")
Reported-by: Helmut Grauer <helmut.grauer@de.ibm.com>
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c
index 23ccec4cb7f5..a1f3556307c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c
@@ -197,9 +197,15 @@ static int mlx5e_am_stats_compare(struct mlx5e_rx_am_stats *curr,
 		return (curr->bpms > prev->bpms) ? MLX5E_AM_STATS_BETTER :
 						   MLX5E_AM_STATS_WORSE;
 
+	if (!prev->ppms)
+		return curr->ppms ? MLX5E_AM_STATS_BETTER :
+				    MLX5E_AM_STATS_SAME;
+
 	if (IS_SIGNIFICANT_DIFF(curr->ppms, prev->ppms))
 		return (curr->ppms > prev->ppms) ? MLX5E_AM_STATS_BETTER :
 						   MLX5E_AM_STATS_WORSE;
+	if (!prev->epms)
+		return MLX5E_AM_STATS_SAME;
 
 	if (IS_SIGNIFICANT_DIFF(curr->epms, prev->epms))
 		return (curr->epms < prev->epms) ? MLX5E_AM_STATS_BETTER :
-- 
2.17.1



