Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6714FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6767D20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6767D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeG3OcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:32:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731696AbeG3OcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:32:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AD6EAED4;
        Mon, 30 Jul 2018 12:57:10 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id AC2E8A0BE8; Mon, 30 Jul 2018 14:57:09 +0200 (CEST)
Message-Id: <d311802e5604a21e7bc8a87c21dca60cb3a394ef.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 17/23] netlink: add netlink handler for gfec
 (--show-fec)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:57:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool --show-fec <dev>" subcommand showing Forward Error
Correction (FEC) settings using netlink interface command
ETHNL_CMD_GET_PARAMS with ETH_PARAMS_IM_FEC mask.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 common.c          | 10 ++++++++++
 common.h          |  2 ++
 ethtool.c         |  3 ++-
 netlink/extapi.h  |  1 +
 netlink/monitor.c |  5 +++++
 netlink/params.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/common.c b/common.c
index db9a360ffae6..085014e895bf 100644
--- a/common.c
+++ b/common.c
@@ -41,6 +41,16 @@ const struct flag_info flags_msglvl[] = {
 };
 const unsigned int n_flags_msglvl = ARRAY_SIZE(flags_msglvl) - 1;
 
+const struct flag_info flags_fecenc[] = {
+	{ "none",	ETHTOOL_FEC_NONE },
+	{ "auto",	ETHTOOL_FEC_AUTO },
+	{ "off",	ETHTOOL_FEC_OFF },
+	{ "RS",		ETHTOOL_FEC_RS },
+	{ "baser",	ETHTOOL_FEC_BASER },
+	{}
+};
+const unsigned int n_flags_fecenc = ARRAY_SIZE(flags_fecenc) - 1;
+
 const char *names_duplex[] = {
 	[DUPLEX_HALF]		= "Half",
 	[DUPLEX_FULL]		= "Full",
diff --git a/common.h b/common.h
index 36f96ddaa3bd..c05e51b645f8 100644
--- a/common.h
+++ b/common.h
@@ -10,6 +10,8 @@ struct flag_info {
 
 extern const struct flag_info flags_msglvl[];
 extern const unsigned int n_flags_msglvl;
+extern const struct flag_info flags_fecenc[];
+extern const unsigned int n_flags_fecenc;
 
 
 enum link_mode_class {
diff --git a/ethtool.c b/ethtool.c
index 1ad0cd10735a..2c838b7c7f53 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4884,6 +4884,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_gpause	NULL
 #define nl_gchannels	NULL
 #define nl_geee		NULL
+#define nl_gfec		NULL
 #endif
 
 static const struct option {
@@ -5091,7 +5092,7 @@ static const struct option {
 	  "		[ ap-shared ]\n"
 	  "		[ dedicated ]\n"
 	  "		[ all ]\n"},
-	{ "--show-fec", 1, do_gfec, NULL,
+	{ "--show-fec", 1, do_gfec, nl_gfec,
 	  "Show FEC settings"},
 	{ "--set-fec", 1, do_sfec, NULL,
 	  "Set FEC settings",
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 40d708a4cb85..b40db721a4c5 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -23,6 +23,7 @@ int nl_gring(struct cmd_context *ctx);
 int nl_gpause(struct cmd_context *ctx);
 int nl_gchannels(struct cmd_context *ctx);
 int nl_geee(struct cmd_context *ctx);
+int nl_gfec(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/monitor.c b/netlink/monitor.c
index 799371fdebc2..92031052a425 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -163,6 +163,11 @@ static struct monitor_option monitor_opts[] = {
 		.cmd		= ETHNL_CMD_SET_PARAMS,
 		.info_mask	= ETH_PARAMS_IM_EEE,
 	},
+	{
+		.pattern	= "--show-fec|--set-fec",
+		.cmd		= ETHNL_CMD_SET_PARAMS,
+		.info_mask	= ETH_PARAMS_IM_FEC,
+	},
 };
 
 static bool pattern_match(const char *s, const char *pattern)
diff --git a/netlink/params.c b/netlink/params.c
index 55138b6fdc83..c187ca0b37c5 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -185,6 +185,35 @@ static int show_eee(struct nl_context *nlctx, const struct nlattr *nest)
 	return 0;
 }
 
+static int show_fec(struct nl_context *nlctx, const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHA_FEC_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	if (!nest)
+		return -EOPNOTSUPP;
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	printf("FEC parameters for %s:\n", nlctx->devname);
+	if (tb[ETHA_FEC_MODES]) {
+		const struct nla_bitfield32 *fec_encs =
+			mnl_attr_get_payload(tb[ETHA_FEC_MODES]);
+
+		printf("Active FEC encodings:\t");
+		print_flags(flags_fecenc, n_flags_fecenc, fec_encs->value);
+		putchar('\n');
+		printf("Configured FEC encodings:\t");
+		print_flags(flags_fecenc, n_flags_fecenc, fec_encs->selector);
+		putchar('\n');
+	}
+	putchar('\n');
+
+	return 0;
+}
+
 int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 {
 	const struct nlattr *tb[ETHA_PARAMS_MAX + 1] = {};
@@ -244,6 +273,15 @@ int params_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			return MNL_CB_ERROR;
 		}
 	}
+	if (mask_ok(nlctx, ETH_PARAMS_IM_FEC)) {
+		ret = show_fec(nlctx, tb[ETHA_PARAMS_FEC]);
+		if ((ret < 0) && show_only(nlctx, ETH_PARAMS_IM_FEC)) {
+			nlctx->exit_code = 1;
+			errno = -ret;
+			perror("Cannot get device FEC settings");
+			return MNL_CB_ERROR;
+		}
+	}
 
 	return MNL_CB_OK;
 }
@@ -285,3 +323,8 @@ int nl_geee(struct cmd_context *ctx)
 {
 	return params_request(ctx, ETH_PARAMS_IM_EEE);
 }
+
+int nl_gfec(struct cmd_context *ctx)
+{
+	return params_request(ctx, ETH_PARAMS_IM_FEC);
+}
-- 
2.18.0

