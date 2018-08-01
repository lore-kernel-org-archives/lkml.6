Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83516C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3237420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3237420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbeHAT4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:56:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405735AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CAF291156;
        Wed,  1 Aug 2018 17:05:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 233/336] mlxsw: spectrum_router: Return an error for non-default FIB rules
Date:   Wed,  1 Aug 2018 18:49:28 +0200
Message-Id: <20180801165037.986283131@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 6290182b2b3bda119ecb243fb3d6bcc98a74344f ]

Since commit 9776d32537d2 ("net: Move call_fib_rule_notifiers up in
fib_nl_newrule") it is possible to forbid the installation of
unsupported FIB rules.

Have mlxsw return an error for non-default FIB rules in addition to the
existing extack message.

Example:
# ip rule add from 198.51.100.1 table 10
Error: mlxsw_spectrum: FIB rules not supported.

Note that offload is only aborted when non-default FIB rules are already
installed and merely replayed during module initialization.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -5882,24 +5882,24 @@ static int mlxsw_sp_router_fib_rule_even
 	switch (info->family) {
 	case AF_INET:
 		if (!fib4_rule_default(rule) && !rule->l3mdev)
-			err = -1;
+			err = -EOPNOTSUPP;
 		break;
 	case AF_INET6:
 		if (!fib6_rule_default(rule) && !rule->l3mdev)
-			err = -1;
+			err = -EOPNOTSUPP;
 		break;
 	case RTNL_FAMILY_IPMR:
 		if (!ipmr_rule_default(rule) && !rule->l3mdev)
-			err = -1;
+			err = -EOPNOTSUPP;
 		break;
 	case RTNL_FAMILY_IP6MR:
 		if (!ip6mr_rule_default(rule) && !rule->l3mdev)
-			err = -1;
+			err = -EOPNOTSUPP;
 		break;
 	}
 
 	if (err < 0)
-		NL_SET_ERR_MSG_MOD(extack, "FIB rules not supported. Aborting offload");
+		NL_SET_ERR_MSG_MOD(extack, "FIB rules not supported");
 
 	return err;
 }
@@ -5926,8 +5926,8 @@ static int mlxsw_sp_router_fib_event(str
 	case FIB_EVENT_RULE_DEL:
 		err = mlxsw_sp_router_fib_rule_event(event, info,
 						     router->mlxsw_sp);
-		if (!err)
-			return NOTIFY_DONE;
+		if (!err || info->extack)
+			return notifier_from_errno(err);
 	}
 
 	fib_work = kzalloc(sizeof(*fib_work), GFP_ATOMIC);


