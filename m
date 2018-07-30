Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF7FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACEF20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACEF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeG3Oby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:31:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731696AbeG3Obx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05664AE4D;
        Mon, 30 Jul 2018 12:57:00 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id A05D6A0BE8; Mon, 30 Jul 2018 14:56:59 +0200 (CEST)
Message-Id: <76a97260e78fddfc7cbf4ddce075de26a830d4b6.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 15/23] netlink: add netlink handler for
 gchannels (-l)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:56:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool -l <dev>" subcommand using netlink interface command
ETHNL_CMD_GET_PARAMS with ETH_PARAMS_IM_CHANNELS mask.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c         |  3 ++-
 netlink/extapi.h  |  1 +
 netlink/monitor.c |  5 +++++
 netlink/params.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 3a12b7c0c7ce..2bcc1944ba29 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4882,6 +4882,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_gcoalesce	NULL
 #define nl_gring	NULL
 #define nl_gpause	NULL
+#define nl_gchannels	NULL
 #endif
 
 static const struct option {
@@ -5033,7 +5034,7 @@ static const struct option {
 	{ "-W|--set-dump", 1, do_setfwdump, NULL,
 	  "Set dump flag of the device",
 	  "		N\n"},
-	{ "-l|--show-channels", 1, do_gchannels, NULL,
+	{ "-l|--show-channels", 1, do_gchannels, nl_gchannels,
 	  "Query Channels" },
 	{ "-L|--set-channels", 1, do_schannels, NULL,
 	  "Set Channels",
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 3b918a443b96..fc027f62398c 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -21,6 +21,7 @@ int nl_sfeatures(struct cmd_context *ctx);
 int nl_gcoalesce(struct cmd_context *ctx);
 int nl_gring(struct cmd_context *ctx);
 int nl_gpause(struct cmd_context *ctx);
+int nl_gchannels(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/monitor.c b/netlink/monitor.c
index 18e151980c3f..1b277606a78c 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -153,6 +153,11 @@ static struct monitor_option monitor_opts[] = {
 		.cmd		= ETHNL_CMD_SET_PARAMS,
 		.info_mask	= ETH_PARAMS_IM_PAUSE,
 	},
+	{
+		.pattern	= "-l|--show-channels|-L|--set-channels",
+		.cmd		= ETHNL_CMD_SET_PARAMS,
+		.info_mask	= ETH_PARAMS_IM_CHANNELS,
+	},
 };
 
 static bool pattern_match(const char *s, const char *pattern)
diff --git a/netlink/params.c b/netlink/params.c
index b45aac166dcd..81547492532f 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -105,6 +105,34 @@ static int show_pause(struct nl_context *nlctx, const struct nlattr *nest)
 	return 0;
 }
 
+static int show_channels(struct nl_context *nlctx, const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHA_CHANNELS_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	if (!nest)
+		return -EOPNOTSUPP;
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	printf("Channel parameters for %s:\n", nlctx->devname);
+	printf("Pre-set maximums:\n");
+	show_u32(tb[ETHA_CHANNELS_MAX_RX], "RX:\t\t");
+	show_u32(tb[ETHA_CHANNELS_MAX_TX], "TX:\t\t");
+	show_u32(tb[ETHA_CHANNELS_MAX_OTHER], "Other:\t\t");
+	show_u32(tb[ETHA_CHANNELS_MAX_COMBINED], "Combined:\t");
+	printf("Current hardware settings:\n");
+	show_u32(tb[ETHA_CHANNELS_RX_COUNT], "RX:\t\t");
+	show_u32(tb[ETHA_CHANNELS_TX_COUNT], "TX:\t\t");
+	show_u32(tb[ETHA_CHANNELS_OTHER_COUNT], "Other:\t\t");
+	show_u32(tb[ETHA_CHANNELS_COMBINED_COUNT], "Combined:\t");
+	putchar('\n');
+
+	return 0;
+}
+
 int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 {
 	const struct nlattr *tb[ETHA_PARAMS_MAX + 1] = {};
@@ -146,6 +174,15 @@ int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			return MNL_CB_ERROR;
 		}
 	}
+	if (mask_ok(nlctx, ETH_PARAMS_IM_CHANNELS)) {
+		ret = show_channels(nlctx, tb[ETHA_PARAMS_CHANNELS]);
+		if ((ret < 0) && show_only(nlctx, ETH_PARAMS_IM_CHANNELS)) {
+			nlctx->exit_code = 1;
+			errno = -ret;
+			perror("Cannot get device channel parameters");
+			return MNL_CB_ERROR;
+		}
+	}
 
 	return MNL_CB_OK;
 }
@@ -177,3 +214,8 @@ int nl_gpause(struct cmd_context *ctx)
 {
 	return params_request(ctx, ETH_PARAMS_IM_PAUSE);
 }
+
+int nl_gchannels(struct cmd_context *ctx)
+{
+	return params_request(ctx, ETH_PARAMS_IM_CHANNELS);
+}
-- 
2.18.0

