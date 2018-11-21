Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95571214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6RPmWyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95571214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbeKVFmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbeKVFmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B337C206BB;
        Wed, 21 Nov 2018 19:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827230;
        bh=TQaE+WPs9JFBSc8pMFBDmzU7DOZlH0KNb/zW88eCxas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6RPmWyUIupT8XeW/m5geVuET1vykVGZ+inPuCfVJEdlxvO9gGl1wtIjuyN99IKh/
         0uA4/xH6TXxL6KHiCSEwk5GJkVX6sOfhWtBPBjS1uLEaLKIeDGS3bOeAzWwJ7oolIC
         rt8eq0ZX2ciFB4X8MNwqa/sdjV6fY4EMSlta0Uj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 23/42] net/mlx5e: Always use the match level enum when parsing TC rule match
Date:   Wed, 21 Nov 2018 20:05:59 +0100
Message-Id: <20181121183149.014037057@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit 83621b7df6a646e550fd3d36db2e301cf9a5096b ]

We get the match level (none, l2, l3, l4) while going over the match
dissectors of an offloaded tc rule. When doing this, the match level
enum and the not min inline enum values should be used, fix that.

This worked accidentally b/c both enums have the same numerical values.

Fixes: d708f902989b ('net/mlx5e: Get the required HW match level while parsing TC flow matches')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1450,10 +1450,10 @@ static int __parse_cls_flower(struct mlx
 
 			/* the HW doesn't need L3 inline to match on frag=no */
 			if (!(key->flags & FLOW_DIS_IS_FRAGMENT))
-				*match_level = MLX5_INLINE_MODE_L2;
+				*match_level = MLX5_MATCH_L2;
 	/* ***  L2 attributes parsing up to here *** */
 			else
-				*match_level = MLX5_INLINE_MODE_IP;
+				*match_level = MLX5_MATCH_L3;
 		}
 	}
 


