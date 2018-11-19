Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B898C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB11208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLjV6AhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB11208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbeKTDR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390361AbeKTDR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7604320851;
        Mon, 19 Nov 2018 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646392;
        bh=gsfdiFH9a7DuL/9mHKjCraKTvOSpW9g3c2T/clp78Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLjV6AhEJr5LF0qQ4bKfoodvDGRiFVnXqWDhpYe5CnEAk9/ifJuUSigdIoKzwaJWN
         EjJ4xFLKDtp9k6S2sXxEJ2c4tlkpUUudn4dty2SGcAd5Ckmttxr5SXv224NwtKMxn/
         HzaB27r3BiJg7G3xRx8CTHuNoQXeTd4zftSG0W9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 23/83] e1000: avoid null pointer dereference on invalid stat type
Date:   Mon, 19 Nov 2018 17:28:49 +0100
Message-Id: <20181119162616.810594886@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
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

[ Upstream commit 5983587c8c5ef00d6886477544ad67d495bc5479 ]

Currently if the stat type is invalid then data[i] is being set
either by dereferencing a null pointer p, or it is reading from
an incorrect previous location if we had a valid stat type
previously.  Fix this by skipping over the read of p on an invalid
stat type.

Detected by CoverityScan, CID#113385 ("Explicit null dereferenced")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index e84574b1eae7..2a81f6d72140 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -1826,11 +1826,12 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	int i;
-	char *p = NULL;
 	const struct e1000_stats *stat = e1000_gstrings_stats;
 
 	e1000_update_stats(adapter);
-	for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
+	for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++, stat++) {
+		char *p;
+
 		switch (stat->type) {
 		case NETDEV_STATS:
 			p = (char *)netdev + stat->stat_offset;
@@ -1841,15 +1842,13 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 		default:
 			WARN_ONCE(1, "Invalid E1000 stat type: %u index %d\n",
 				  stat->type, i);
-			break;
+			continue;
 		}
 
 		if (stat->sizeof_stat == sizeof(u64))
 			data[i] = *(u64 *)p;
 		else
 			data[i] = *(u32 *)p;
-
-		stat++;
 	}
 /* BUG_ON(i != E1000_STATS_LEN); */
 }
-- 
2.17.1



