Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C70D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Qok7mAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C70D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbeJQBJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbeJQBJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D20C20866;
        Tue, 16 Oct 2018 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710308;
        bh=IeuBVkdMiHwY2wlnmIQu2hRR1ALt3IRpmNfbvyF8eNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Qok7mANXAuSV7eouvDIQ1CC2m/fsAXUVIwOVO/GuNH9DBZAU7jSlYz9c04vsZTRV
         J20OotlT8qZg418RI/yGqXriPsEoCSehT0JWios61JgWQ+zJjRdaz6Em9dAZn3D/PK
         mV8N7WzEHnVZ8VUUkoINiLVUrbcnLOffnPCzBfMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 031/109] net/mlx5: E-Switch, Fix out of bound access when setting vport rate
Date:   Tue, 16 Oct 2018 19:04:59 +0200
Message-Id: <20181016170526.758258078@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 11aa5800ed66ed0415b7509f02881c76417d212a ]

The code that deals with eswitch vport bw guarantee was going beyond the
eswitch vport array limit, fix that.  This was pointed out by the kernel
address sanitizer (KASAN).

The error from KASAN log:
[2018-09-15 15:04:45] BUG: KASAN: slab-out-of-bounds in
mlx5_eswitch_set_vport_rate+0x8c1/0xae0 [mlx5_core]

Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1922,7 +1922,7 @@ static u32 calculate_vports_min_rate_div
 	u32 max_guarantee = 0;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled || evport->info.min_rate < max_guarantee)
 			continue;
@@ -1942,7 +1942,7 @@ static int normalize_vports_min_rate(str
 	int err;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled)
 			continue;


