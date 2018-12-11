Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A5FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3020989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543235;
	bh=A6V1Hq06bn19ISrH+ofeByRCf3jCqEkPFyfmzRhaeqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kWioLxcD3lUndncGmq2zqCplN8c52iKYG0ZbTaLr6IVBXx8L9Rjqsf51tXDX8Zz+m
	 zZJYtmPL4rvRmN/54tW3YAsTr3+kE+r+kMe1OelHRVUh9l3fo3mVtMaZIZ9vRnfwLZ
	 NivGRZKYSpE77Q9hat1ZkdXx1PYh45TysUtsc+qM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE3020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeLKPrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbeLKPrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987342133F;
        Tue, 11 Dec 2018 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543230;
        bh=A6V1Hq06bn19ISrH+ofeByRCf3jCqEkPFyfmzRhaeqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBbfIrzS7qyk4V9eT42OgLEBLFb8qfQ3BNgW4g8Fvvavgd2JGFgEeOFXjAD0xu1Il
         t8zQMGiuPovsGZm6buRkOtMBQY+Yr2itpvOq+sjZVM/+ffZ5DjCOhU4sR+FpqW3x+W
         xjhmJm85ZpHQOnyG2oAKhQIsIi1dzaRmdKo0Gark=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 63/91] qed: Fix reading wrong value in loop condition
Date:   Tue, 11 Dec 2018 16:41:22 +0100
Message-Id: <20181211151611.216751710@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ed4eac20dcffdad47709422e0cb925981b056668 ]

The value of "sb_index" is written by the hardware. Reading its value and
writing it to "index" must finish before checking the loop condition.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_int.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.c b/drivers/net/ethernet/qlogic/qed/qed_int.c
index 9cc9d62c1fec..8b15a018d625 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.c
@@ -177,6 +177,8 @@ static int qed_int_attentions(struct qed_hwfn *p_hwfn)
 	 */
 	do {
 		index = p_sb_attn->sb_index;
+		/* finish reading index before the loop condition */
+		dma_rmb();
 		attn_bits = le32_to_cpu(p_sb_attn->atten_bits);
 		attn_acks = le32_to_cpu(p_sb_attn->atten_ack);
 	} while (index != p_sb_attn->sb_index);
-- 
2.19.1



