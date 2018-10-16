Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3BDC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A400F2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNTNHaP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A400F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJQBDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69F820866;
        Tue, 16 Oct 2018 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709950;
        bh=QLQLqyN8Kdzs+9Eb5A6tSWMG2e3BvmTtSipQhKRjvlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNTNHaP7Oi0JcFqpArLiLe6mjPramzjyBL71m6T1afoGAfuV687pHCVdcXDL0CvEY
         pXHETSaG1vL/Gn2N3gmHwxJ/c5fBuKvoQuvredwVw6NbhqH2fPjSQu4QmpLWnGGpHH
         oPFvsMKPT4oIBG7b8KRiauCjp4Dm+Ib3xLAlN+s0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 053/135] net/mlx5: Check for SQ and not RQ state when modifying hairpin SQ
Date:   Tue, 16 Oct 2018 19:04:43 +0200
Message-Id: <20181016170518.261532702@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alaa Hleihel <alaa@mellanox.com>

[ Upstream commit 6b359d5550a1ae7a1269c9dc1dd73dfdc4d6fe58 ]

When modifying hairpin SQ, instead of checking if the next state equals
to MLX5_SQC_STATE_RDY, we compare it against the MLX5_RQC_STATE_RDY enum
value.

The code worked since both of MLX5_RQC_STATE_RDY and MLX5_SQC_STATE_RDY
have the same value today.

This patch fixes this issue.

Fixes: 18e568c390c6 ("net/mlx5: Hairpin pair core object setup")
Change-Id: I6758aa7b4bd137966ae28206b70648c5bc223b46
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
@@ -509,7 +509,7 @@ static int mlx5_hairpin_modify_sq(struct
 
 	sqc = MLX5_ADDR_OF(modify_sq_in, in, ctx);
 
-	if (next_state == MLX5_RQC_STATE_RDY) {
+	if (next_state == MLX5_SQC_STATE_RDY) {
 		MLX5_SET(sqc, sqc, hairpin_peer_rq, peer_rq);
 		MLX5_SET(sqc, sqc, hairpin_peer_vhca, peer_vhca);
 	}


