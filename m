Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56C9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49B20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A49B20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbeG3OcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730482AbeG3OcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:32:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 238B4AF54;
        Mon, 30 Jul 2018 12:57:30 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id C3EF8A0BE8; Mon, 30 Jul 2018 14:57:29 +0200 (CEST)
Message-Id: <2b2634cb14380ed15e69357bccdcc82ada2df4f0.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 21/23] netlink: add netlink handler for
 schannels (-L)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:57:29 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool -L <dev>" subcommand using netlink interface command
ETHNL_CMD_SET_PARAMS.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c        |  3 ++-
 netlink/extapi.h |  1 +
 netlink/params.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index b6e322af9c8a..9ac7f3c57ecb 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4888,6 +4888,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_scoalesce	NULL
 #define nl_sring	NULL
 #define nl_spause	NULL
+#define nl_schannels	NULL
 #endif
 
 static const struct option {
@@ -5041,7 +5042,7 @@ static const struct option {
 	  "		N\n"},
 	{ "-l|--show-channels", 1, do_gchannels, nl_gchannels,
 	  "Query Channels" },
-	{ "-L|--set-channels", 1, do_schannels, NULL,
+	{ "-L|--set-channels", 1, do_schannels, nl_schannels,
 	  "Set Channels",
 	  "               [ rx N ]\n"
 	  "               [ tx N ]\n"
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 8cf1d0093aaa..bc33be82bdd5 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -27,6 +27,7 @@ int nl_gfec(struct cmd_context *ctx);
 int nl_scoalesce(struct cmd_context *ctx);
 int nl_sring(struct cmd_context *ctx);
 int nl_spause(struct cmd_context *ctx);
+int nl_schannels(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/params.c b/netlink/params.c
index 953678a0b227..5e0f0d264187 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -572,3 +572,37 @@ int nl_spause(struct cmd_context *ctx)
 	return nl_set_param(ctx, "-A", spause_params, ETHA_PARAMS_PAUSE,
 			    ETHA_PAUSE_MAX);
 }
+
+static const struct param_parser schannels_params[] = {
+	{
+		.arg		= "rx",
+		.type		= ETHA_CHANNELS_RX_COUNT,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx",
+		.type		= ETHA_CHANNELS_TX_COUNT,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "other",
+		.type		= ETHA_CHANNELS_OTHER_COUNT,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "combined",
+		.type		= ETHA_CHANNELS_COMBINED_COUNT,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_schannels(struct cmd_context *ctx)
+{
+	return nl_set_param(ctx, "-L", schannels_params, ETHA_PARAMS_CHANNELS,
+			    ETHA_CHANNELS_MAX);
+}
-- 
2.18.0

