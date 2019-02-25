Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF51E21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130196;
	bh=L3y8fSo9Gb0sSkW63Ez/n5s6SRW6pQUp3BO2ljVUMvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J9d2q3C55A/SZWceZ6+2zd3JBOVNDwJ3cng77rFvyCx3tQa7Gs3W3JhABNurLhlu2
	 UJT6QrEPBQmMINpgdAYNyE/GVySkSJriMmD/0FTWetaiknWvehU6GJNViGPNINK/VB
	 KQOM08KDyMlNhgP69eBRAsIAdrcz+Dgm93DkunGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfBYV3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbfBYV3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA80E217F5;
        Mon, 25 Feb 2019 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130190;
        bh=L3y8fSo9Gb0sSkW63Ez/n5s6SRW6pQUp3BO2ljVUMvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5CBogjraxmp/cGUmuIdnjgH2SBHeQdh+AMde+1qp2F/YE8NaaMLvw/7yvy/jA9ja
         pzsOZ/f5fCRw5u/h7EV6Oj5ypqvuW/oURl4bNBccQL0fncVSmgk15+uQvo7h/Z/SmS
         MatXX3Mjh0xORFL1T1hGuDxIU6/Ple0gJhRQGUkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <dbolotin@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 042/183] qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory barrier
Date:   Mon, 25 Feb 2019 22:10:15 +0100
Message-Id: <20190225195101.729476780@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 46721c3d9e273aea880e9ff835b0e1271e1cd2fb ]

Make sure chain element is updated before ringing the doorbell.

Signed-off-by: Denis Bolotin <dbolotin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index c6f4bab67a5fc..9e728ec82c218 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -1603,6 +1603,10 @@ static void qed_ll2_post_rx_buffer_notify_fw(struct qed_hwfn *p_hwfn,
 	cq_prod = qed_chain_get_prod_idx(&p_rx->rcq_chain);
 	rx_prod.bd_prod = cpu_to_le16(bd_prod);
 	rx_prod.cqe_prod = cpu_to_le16(cq_prod);
+
+	/* Make sure chain element is updated before ringing the doorbell */
+	dma_wmb();
+
 	DIRECT_REG_WR(p_rx->set_prod_addr, *((u32 *)&rx_prod));
 }
 
-- 
2.19.1



