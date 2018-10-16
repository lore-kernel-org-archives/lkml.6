Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B558C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D6A2147E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOfsjT+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D6A2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeJQBF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA7020866;
        Tue, 16 Oct 2018 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710045;
        bh=iNrVB77DZLdt4rK37slGIUfXinw+XOXOZWTu2DlHnjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOfsjT+gcgI1DzjNwcmJ/1IeusRlMj+tsO6WKTjqBxmFXmPEchb6zAzLwB2jHKp+b
         pktlDOilF0GLpJuPcEM6Mb8faem2tW9gm/XN1a4t6J+EEPP0Jdwf7n5zd/jPX4gTp3
         PoO8jI+MEXXX3asKyZ5SFtAvrobO8VWF7bt4K6TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 038/135] net/mlx5: E-Switch, Fix out of bound access when setting vport rate
Date:   Tue, 16 Oct 2018 19:04:28 +0200
Message-Id: <20181016170517.547052900@linuxfoundation.org>
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
@@ -2000,7 +2000,7 @@ static u32 calculate_vports_min_rate_div
 	u32 max_guarantee = 0;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled || evport->info.min_rate < max_guarantee)
 			continue;
@@ -2020,7 +2020,7 @@ static int normalize_vports_min_rate(str
 	int err;
 	int i;
 
-	for (i = 0; i <= esw->total_vports; i++) {
+	for (i = 0; i < esw->total_vports; i++) {
 		evport = &esw->vports[i];
 		if (!evport->enabled)
 			continue;


