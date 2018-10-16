Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9418721477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSX8d6RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9418721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJQBDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeJQBDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D85DB20866;
        Tue, 16 Oct 2018 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709909;
        bh=uvQ501CfRdwQaRieZhJjf9n0kltezfCnZtsma9BSJFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSX8d6ROWcBcgnfhDqNdenmXWqDwkyr4wg7VDpNPgxudtnFRwLmifPw/k0IoM8ats
         gy7tm3YaBMhtuNQwkzjKzfv+bswfKTpVAdeZ5iugoua0azeLNBJf8PlXhupeFAbk6G
         GZIqVQJJ2hk6jq/JPLxcF9bTu4EPFTJBYr3agy0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianbo Liu <jianbol@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 036/135] net/mlx5e: Set vlan masks for all offloaded TC rules
Date:   Tue, 16 Oct 2018 19:04:26 +0200
Message-Id: <20181016170517.444389343@linuxfoundation.org>
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
@@ -1339,6 +1339,9 @@ static int __parse_cls_flower(struct mlx
 
 			*match_level = MLX5_MATCH_L2;
 		}
+	} else {
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, svlan_tag, 1);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
 	}
 
 	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {


