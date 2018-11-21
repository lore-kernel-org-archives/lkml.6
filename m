Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ECCC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2222214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9ADNyE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2222214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbeKVFoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbeKVFoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41780214D9;
        Wed, 21 Nov 2018 19:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827344;
        bh=+LDtPYFugTuCL4dTv5pFlKI/VQVa2DPVDM1R6MSPezs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9ADNyE/inbylbGWAuCyEQxrwD3AZqo9nyI3rAOGtNm6oh2PrJPsTKgqkATOxXUHR
         ONAgwFHVc4EwViPiTV8Lhwx26pJPw6UBeSi915pS0GDmW+2Y2NkSYFEHC25BuCiUf1
         mkaIv/9HI3LWd3aZZ1sjT2VxceSAl1EWMlPsz4go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shalom Toledo <shalomt@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/21] mlxsw: spectrum: Fix IP2ME CPU policer configuration
Date:   Wed, 21 Nov 2018 20:06:59 +0100
Message-Id: <20181121183422.761067038@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
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

From: Shalom Toledo <shalomt@mellanox.com>

[ Upstream commit 96801552f846460fe9ac10f1b189602992f004e1 ]

The CPU policer used to police packets being trapped via a local route
(IP2ME) was incorrectly configured to police based on bytes per second
instead of packets per second.

Change the policer to police based on packets per second and avoid
packet loss under certain circumstances.

Fixes: 9148e7cf73ce ("mlxsw: spectrum: Add policers for trap groups")
Signed-off-by: Shalom Toledo <shalomt@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3471,7 +3471,6 @@ static int mlxsw_sp_cpu_policers_set(str
 			burst_size = 7;
 			break;
 		case MLXSW_REG_HTGT_TRAP_GROUP_SP_IP2ME:
-			is_bytes = true;
 			rate = 4 * 1024;
 			burst_size = 4;
 			break;


