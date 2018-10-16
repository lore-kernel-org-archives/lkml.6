Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2250B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMjY3xq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2250B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeJQBJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E000320866;
        Tue, 16 Oct 2018 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710288;
        bh=fNq4Pgspj3I/WSAwTREpsz8Mand5epPCyNZwmuRMh0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMjY3xq19jl3BIA27dWo3Eom+ApFdCEkKahx+5PRoedeHdQtgNpsgiUY9qWsCXMzB
         okpqUZTjHS2i7pYGzXNjNTViIaxf1BGo+M8I4djLh+Ar/5l33Hb0WUfemoldntP9Mq
         7hCor5dsWoh8M0wzclo3ExeT02TyZvC4Zo67J6U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianbo Liu <jianbol@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 029/109] net/mlx5e: Set vlan masks for all offloaded TC rules
Date:   Tue, 16 Oct 2018 19:04:57 +0200
Message-Id: <20181016170526.646986703@linuxfoundation.org>
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

From: Jianbo Liu <jianbol@mellanox.com>

[ Upstream commit cee26487620bc9bc3c7db21b6984d91f7bae12ae ]

In flow steering, if asked to, the hardware matches on the first ethertype
which is not vlan. It's possible to set a rule as follows, which is meant
to match on untagged packet, but will match on a vlan packet:
    tc filter add dev eth0 parent ffff: protocol ip flower ...

To avoid this for packets with single tag, we set vlan masks to tell
hardware to check the tags for every matched packet.

Fixes: 095b6cfd69ce ('net/mlx5e: Add TC vlan match parsing')
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -864,6 +864,9 @@ static int __parse_cls_flower(struct mlx
 			MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_prio, mask->vlan_priority);
 			MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_prio, key->vlan_priority);
 		}
+	} else {
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, svlan_tag, 1);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {


