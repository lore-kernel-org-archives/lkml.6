Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3941ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A432075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A432075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGRNr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:47:26 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.101]:49353 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbeGRNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:47:26 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 8B7FEA9D70
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:08:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fmCGfgbTYaSeyfmCGfIVwV; Wed, 18 Jul 2018 08:08:48 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=42378 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffmCG-000K8A-1R; Wed, 18 Jul 2018 08:08:48 -0500
Date:   Wed, 18 Jul 2018 08:08:46 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: mvpp2: debugfs: fix incorrect bitwise operator
Message-ID: <20180718130846.GA5380@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1ffmCG-000K8A-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:42378
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of the | operator always leads to true, which looks rather
suspect in this case.

Fix this by using & instead.

Addresses-Coverity-ID: 1471903 ("Wrong operator used")
Fixes: dba1d918da02 ("net: mvpp2: debugfs: add entries for classifier flows")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 02dfef1..f9744a6 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -245,7 +245,7 @@ static int mvpp2_dbgfs_flow_c2_enable_show(struct seq_file *s, void *unused)
 
 	mvpp2_cls_c2_read(port->priv, MVPP22_CLS_C2_RSS_ENTRY(port->id), &c2);
 
-	enabled = !!(c2.attr[2] | MVPP22_CLS_C2_ATTR2_RSS_EN);
+	enabled = !!(c2.attr[2] & MVPP22_CLS_C2_ATTR2_RSS_EN);
 
 	seq_printf(s, "%d\n", enabled);
 
-- 
2.7.4

