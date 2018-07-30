Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01C8208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01C8208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeG3OcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:32:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730953AbeG3OcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:32:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C880AEC7;
        Mon, 30 Jul 2018 12:57:15 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id B2441A0BE8; Mon, 30 Jul 2018 14:57:14 +0200 (CEST)
Message-Id: <5d035a962ae5ded2f7005944d85f71b1569df807.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 18/23] netlink: add netlink handler for
 scoalesce (-C)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:57:14 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool -C <dev>" subcommand using netlink interface command
ETHNL_CMD_SET_PARAMS.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c        |   3 +-
 netlink/extapi.h |   1 +
 netlink/params.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 2c838b7c7f53..8d755b3933a9 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4885,6 +4885,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_gchannels	NULL
 #define nl_geee		NULL
 #define nl_gfec		NULL
+#define nl_scoalesce	NULL
 #endif
 
 static const struct option {
@@ -4917,7 +4918,7 @@ static const struct option {
 	  "		[ tx on|off ]\n" },
 	{ "-c|--show-coalesce", 1, do_gcoalesce, nl_gcoalesce,
 	  "Show coalesce options" },
-	{ "-C|--coalesce", 1, do_scoalesce, NULL,
+	{ "-C|--coalesce", 1, do_scoalesce, nl_scoalesce,
 	  "Set coalesce options",
 	  "		[adaptive-rx on|off]\n"
 	  "		[adaptive-tx on|off]\n"
diff --git a/netlink/extapi.h b/netlink/extapi.h
index b40db721a4c5..2379309f084e 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -24,6 +24,7 @@ int nl_gpause(struct cmd_context *ctx);
 int nl_gchannels(struct cmd_context *ctx);
 int nl_geee(struct cmd_context *ctx);
 int nl_gfec(struct cmd_context *ctx);
+int nl_scoalesce(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/params.c b/netlink/params.c
index c187ca0b37c5..b86922b8d215 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -328,3 +328,185 @@ int nl_gfec(struct cmd_context *ctx)
 {
 	return params_request(ctx, ETH_PARAMS_IM_FEC);
 }
+
+/* SET_PARAMS */
+
+static int nl_set_param(struct cmd_context *ctx, const char *opt,
+			const struct param_parser *params, u16 nest_type,
+			u16 max_type)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nlattr *nest;
+	int ret;
+
+	nlctx->cmd = opt;
+	nlctx->argp = ctx->argp;
+	nlctx->argc = ctx->argc;
+	ret = msg_init(nlctx, ETHNL_CMD_SET_PARAMS, NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return 2;
+	if (ethnla_put_dev(nlctx, ETHA_PARAMS_DEV, ctx->devname))
+		return -EMSGSIZE;
+
+	nest = ethnla_nest_start(nlctx, nest_type);
+	if (!nest) {
+		fprintf(stderr, "ethtool(%s): failed to allocate message\n",
+			opt);
+		return 76;
+	}
+
+	ret = nl_parser(ctx, params, max_type);
+	if (ret < 0)
+		return 2;
+	mnl_attr_nest_end(nlctx->nlhdr, nest);
+
+	ret = ethnl_sendmsg(nlctx);
+	if (ret < 0)
+		return 75;
+	ret = ethnl_process_reply(nlctx, nomsg_reply_cb);
+	if (ret == 0)
+		return 0;
+	return nlctx->exit_code ?: 81;
+}
+
+static const struct param_parser scoalesce_params[] = {
+	{
+		.arg		= "adaptive-rx",
+		.type		= ETHA_COALESCE_RX_USE_ADAPTIVE,
+		.handler	= nl_parse_bool,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "adaptive-tx",
+		.type		= ETHA_COALESCE_TX_USE_ADAPTIVE,
+		.handler	= nl_parse_bool,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "sample-interval",
+		.type		= ETHA_COALESCE_RATE_SAMPLE_INTERVAL,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "stats-block-usecs",
+		.type		= ETHA_COALESCE_STATS_BLOCK_USECS,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "pkt-rate-low",
+		.type		= ETHA_COALESCE_PKT_RATE_LOW,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "pkt-rate-high",
+		.type		= ETHA_COALESCE_PKT_RATE_HIGH,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-usecs",
+		.type		= ETHA_COALESCE_RX_USECS,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-frames",
+		.type		= ETHA_COALESCE_RX_MAXFRM,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-usecs-irq",
+		.type		= ETHA_COALESCE_RX_USECS_IRQ,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-frames-irq",
+		.type		= ETHA_COALESCE_RX_MAXFRM_IRQ,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-usecs",
+		.type		= ETHA_COALESCE_TX_USECS,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-frames",
+		.type		= ETHA_COALESCE_TX_MAXFRM,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-usecs-irq",
+		.type		= ETHA_COALESCE_TX_USECS_IRQ,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-frames-irq",
+		.type		= ETHA_COALESCE_TX_MAXFRM_IRQ,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-usecs-low",
+		.type		= ETHA_COALESCE_RX_USECS_LOW,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-frames-low",
+		.type		= ETHA_COALESCE_RX_MAXFRM_LOW,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-usecs-low",
+		.type		= ETHA_COALESCE_TX_USECS_LOW,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-frames-low",
+		.type		= ETHA_COALESCE_TX_MAXFRM_LOW,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-usecs-high",
+		.type		= ETHA_COALESCE_RX_USECS_HIGH,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-frames-high",
+		.type		= ETHA_COALESCE_RX_MAXFRM_HIGH,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-usecs-high",
+		.type		= ETHA_COALESCE_TX_USECS_HIGH,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-frames-high",
+		.type		= ETHA_COALESCE_TX_MAXFRM_HIGH,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_scoalesce(struct cmd_context *ctx)
+{
+	return nl_set_param(ctx, "-C", scoalesce_params, ETHA_PARAMS_COALESCE,
+			    ETHA_COALESCE_MAX);
+}
-- 
2.18.0

