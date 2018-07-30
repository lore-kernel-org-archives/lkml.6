Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D975420892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D975420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbeG3Obo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:31:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732050AbeG3Obn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:31:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB199AD6A;
        Mon, 30 Jul 2018 12:56:49 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 93C45A0BE8; Mon, 30 Jul 2018 14:56:49 +0200 (CEST)
Message-Id: <5b3c85cca0db879d2cdda2772f3b57da482ac32c.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 13/23] netlink: add netlink handler for gring
 (-g)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:56:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool -g <dev>" subcommand using netlink interface command
ETHNL_CMD_GET_PARAMS with ETH_PARAMS_IM_RING mask.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c         |  3 ++-
 netlink/extapi.h  |  1 +
 netlink/monitor.c |  5 +++++
 netlink/params.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 24c70c372914..ba5c73e9abbe 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4880,6 +4880,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_gfeatures	NULL
 #define nl_sfeatures	NULL
 #define nl_gcoalesce	NULL
+#define nl_gring	NULL
 #endif
 
 static const struct option {
@@ -4936,7 +4937,7 @@ static const struct option {
 	  "		[tx-usecs-high N]\n"
 	  "		[tx-frames-high N]\n"
 	  "		[sample-interval N]\n" },
-	{ "-g|--show-ring", 1, do_gring, NULL,
+	{ "-g|--show-ring", 1, do_gring, nl_gring,
 	  "Query RX/TX ring parameters" },
 	{ "-G|--set-ring", 1, do_sring, NULL,
 	  "Set RX/TX ring parameters",
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 8030bda4cbc9..cc13436c4517 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -19,6 +19,7 @@ int nl_sset(struct cmd_context *ctx);
 int nl_gfeatures(struct cmd_context *ctx);
 int nl_sfeatures(struct cmd_context *ctx);
 int nl_gcoalesce(struct cmd_context *ctx);
+int nl_gring(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/monitor.c b/netlink/monitor.c
index 5d494ba43923..10dad082de98 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -143,6 +143,11 @@ static struct monitor_option monitor_opts[] = {
 		.cmd		= ETHNL_CMD_SET_PARAMS,
 		.info_mask	= ETH_PARAMS_IM_COALESCE,
 	},
+	{
+		.pattern	= "-g|--show-ring|-G|--set-ring",
+		.cmd		= ETHNL_CMD_SET_PARAMS,
+		.info_mask	= ETH_PARAMS_IM_RING,
+	},
 };
 
 static bool pattern_match(const char *s, const char *pattern)
diff --git a/netlink/params.c b/netlink/params.c
index 30aee5758c42..6782d98a6956 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -55,6 +55,34 @@ static int show_coalesce(struct nl_context *nlctx, const struct nlattr *nest)
 	return 0;
 }
 
+static int show_ring(struct nl_context *nlctx, const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHA_RING_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	if (!nest)
+		return -EOPNOTSUPP;
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	printf("Ring parameters for %s:\n", nlctx->devname);
+	printf("Pre-set maximums:\n");
+	show_u32(tb[ETHA_RING_RX_MAX_PENDING], "RX:\t\t");
+	show_u32(tb[ETHA_RING_RX_MINI_MAX_PENDING], "RX Mini:\t");
+	show_u32(tb[ETHA_RING_RX_JUMBO_MAX_PENDING], "RX Jumbo:\t");
+	show_u32(tb[ETHA_RING_TX_MAX_PENDING], "TX:\t\t");
+	printf("Current hardware settings:\n");
+	show_u32(tb[ETHA_RING_RX_PENDING], "RX:\t\t");
+	show_u32(tb[ETHA_RING_RX_MINI_PENDING], "RX Mini:\t");
+	show_u32(tb[ETHA_RING_RX_JUMBO_PENDING], "RX Jumbo:\t");
+	show_u32(tb[ETHA_RING_TX_PENDING], "TX:\t\t");
+	putchar('\n');
+
+	return 0;
+}
+
 int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 {
 	const struct nlattr *tb[ETHA_PARAMS_MAX + 1] = {};
@@ -78,6 +106,15 @@ int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			return MNL_CB_ERROR;
 		}
 	}
+	if (mask_ok(nlctx, ETH_PARAMS_IM_RING)) {
+		ret = show_ring(nlctx, tb[ETHA_PARAMS_RING]);
+		if ((ret < 0) && show_only(nlctx, ETH_PARAMS_IM_RING)) {
+			nlctx->exit_code = 76;
+			errno = -ret;
+			perror("Cannot get device ring settings");
+			return MNL_CB_ERROR;
+		}
+	}
 
 	return MNL_CB_OK;
 }
@@ -99,3 +136,8 @@ int nl_gcoalesce(struct cmd_context *ctx)
 {
 	return params_request(ctx, ETH_PARAMS_IM_COALESCE);
 }
+
+int nl_gring(struct cmd_context *ctx)
+{
+	return params_request(ctx, ETH_PARAMS_IM_RING);
+}
-- 
2.18.0

