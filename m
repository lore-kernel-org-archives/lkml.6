Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2021ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9992B20856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9992B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbeGTSuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:50:04 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38348 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387950AbeGTSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:50:04 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fgZhn-0008E6-0U; Fri, 20 Jul 2018 12:00:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fgZhl-000132-9F; Fri, 20 Jul 2018 12:00:37 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>
Cc:     Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 20 Jul 2018 12:00:32 -0600
Message-Id: <20180720180034.3964-7-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720180034.3964-1-logang@deltatee.com>
References: <20180720180034.3964-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, allenbh@gmail.com, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 6/8] NTB: perf: Fix support for hardware that doesn't have port numbers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy drivers do not have port numbers (but is reliably only two ports)
and was broken by the recent commit that added mult-port support to
ntb_perf. This is especially important to support the cross link
topology which is perfectly symmetric and cannot assign unique port
numbers easily.

Hardware that returns zero for both the local port and the peer should
just always use gidx=0 for the only peer.

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_perf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index fe27412ffe91..6285cb8515ac 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1417,6 +1417,16 @@ static int perf_init_peers(struct perf_ctx *perf)
 	if (perf->gidx == -1)
 		perf->gidx = pidx;
 
+	/*
+	 * Hardware with only two ports may not have unique port
+	 * numbers. In this case, the gidxs should all be zero.
+	 */
+	if (perf->pcnt == 1 &&  ntb_port_number(perf->ntb) == 0 &&
+	    ntb_peer_port_number(perf->ntb, 0) == 0) {
+		perf->gidx = 0;
+		perf->peers[0].gidx = 0;
+	}
+
 	for (pidx = 0; pidx < perf->pcnt; pidx++) {
 		ret = perf_setup_peer_mw(&perf->peers[pidx]);
 		if (ret)
-- 
2.11.0

