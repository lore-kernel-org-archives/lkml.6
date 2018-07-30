Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C04213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D401F20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D401F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbeG3Obt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:31:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731696AbeG3Obs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0F3CAE5B;
        Mon, 30 Jul 2018 12:56:54 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 9A06AA0BE8; Mon, 30 Jul 2018 14:56:54 +0200 (CEST)
Message-Id: <bd697c55713e56b86a025109b687d72bef2f1dfe.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 14/23] netlink: add netlink handler for gpause
 (-a)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:56:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool -a <dev>" subcommand using netlink interface command
ETHNL_CMD_GET_PARAMS with ETH_PARAMS_IM_PAUSE mask.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c         |  3 ++-
 netlink/extapi.h  |  1 +
 netlink/monitor.c |  5 +++++
 netlink/params.c  | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index ba5c73e9abbe..3a12b7c0c7ce 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4881,6 +4881,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_sfeatures	NULL
 #define nl_gcoalesce	NULL
 #define nl_gring	NULL
+#define nl_gpause	NULL
 #endif
 
 static const struct option {
@@ -4904,7 +4905,7 @@ static const struct option {
 	  "		[ wol %d[/%d] |  p|u|m|b|a|g|s|d...[/p|u|m|b|a|g|s|d...] ]\n"
 	  "		[ sopass %x:%x:%x:%x:%x:%x ]\n"
 	  "		[ msglvl %d[/%d] | type on|off ... [--] ]\n" },
-	{ "-a|--show-pause", 1, do_gpause, NULL,
+	{ "-a|--show-pause", 1, do_gpause, nl_gpause,
 	  "Show pause options" },
 	{ "-A|--pause", 1, do_spause, NULL,
 	  "Set pause options",
diff --git a/netlink/extapi.h b/netlink/extapi.h
index cc13436c4517..3b918a443b96 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -20,6 +20,7 @@ int nl_gfeatures(struct cmd_context *ctx);
 int nl_sfeatures(struct cmd_context *ctx);
 int nl_gcoalesce(struct cmd_context *ctx);
 int nl_gring(struct cmd_context *ctx);
+int nl_gpause(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/monitor.c b/netlink/monitor.c
index 10dad082de98..18e151980c3f 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -148,6 +148,11 @@ static struct monitor_option monitor_opts[] = {
 		.cmd		= ETHNL_CMD_SET_PARAMS,
 		.info_mask	= ETH_PARAMS_IM_RING,
 	},
+	{
+		.pattern	= "-a|--show-pause|-A|--pause",
+		.cmd		= ETHNL_CMD_SET_PARAMS,
+		.info_mask	= ETH_PARAMS_IM_PAUSE,
+	},
 };
 
 static bool pattern_match(const char *s, const char *pattern)
diff --git a/netlink/params.c b/netlink/params.c
index 6782d98a6956..b45aac166dcd 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -83,6 +83,28 @@ static int show_ring(struct nl_context *nlctx, const struct nlattr *nest)
 	return 0;
 }
 
+static int show_pause(struct nl_context *nlctx, const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHA_PAUSE_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	if (!nest)
+		return -EOPNOTSUPP;
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	printf("Pause parameters for %s:\n", nlctx->devname);
+	show_bool(tb[ETHA_PAUSE_AUTONEG], "Autonegotiate:\t");
+	show_bool(tb[ETHA_PAUSE_RX], "RX:\t\t");
+	show_bool(tb[ETHA_PAUSE_TX], "TX:\t\t");
+	/* ToDo: query negotiated pause frame usage */
+	putchar('\n');
+
+	return 0;
+}
+
 int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 {
 	const struct nlattr *tb[ETHA_PARAMS_MAX + 1] = {};
@@ -115,6 +137,15 @@ int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			return MNL_CB_ERROR;
 		}
 	}
+	if (mask_ok(nlctx, ETH_PARAMS_IM_PAUSE)) {
+		ret = show_pause(nlctx, tb[ETHA_PARAMS_PAUSE]);
+		if ((ret < 0) && show_only(nlctx, ETH_PARAMS_IM_PAUSE)) {
+			nlctx->exit_code = 76;
+			errno = -ret;
+			perror("Cannot get device pause settings");
+			return MNL_CB_ERROR;
+		}
+	}
 
 	return MNL_CB_OK;
 }
@@ -141,3 +172,8 @@ int nl_gring(struct cmd_context *ctx)
 {
 	return params_request(ctx, ETH_PARAMS_IM_RING);
 }
+
+int nl_gpause(struct cmd_context *ctx)
+{
+	return params_request(ctx, ETH_PARAMS_IM_PAUSE);
+}
-- 
2.18.0

