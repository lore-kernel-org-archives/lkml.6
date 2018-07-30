Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F63FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FFD20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FFD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbeG3OcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:32:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730482AbeG3OcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:32:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 092A5AF65;
        Mon, 30 Jul 2018 12:57:20 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id B7A17A0BE8; Mon, 30 Jul 2018 14:57:19 +0200 (CEST)
Message-Id: <4431b6a20ada171a96ea2642e4f7ed58d9ed50d3.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 19/23] netlink: add netlink handler for sring
 (-G)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:57:19 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool -G <dev>" subcommand using netlink interface command
ETHNL_CMD_SET_PARAMS.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c        |  3 ++-
 netlink/extapi.h |  1 +
 netlink/params.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 8d755b3933a9..792283c46d35 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4886,6 +4886,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_geee		NULL
 #define nl_gfec		NULL
 #define nl_scoalesce	NULL
+#define nl_sring	NULL
 #endif
 
 static const struct option {
@@ -4944,7 +4945,7 @@ static const struct option {
 	  "		[sample-interval N]\n" },
 	{ "-g|--show-ring", 1, do_gring, nl_gring,
 	  "Query RX/TX ring parameters" },
-	{ "-G|--set-ring", 1, do_sring, NULL,
+	{ "-G|--set-ring", 1, do_sring, nl_sring,
 	  "Set RX/TX ring parameters",
 	  "		[ rx N ]\n"
 	  "		[ rx-mini N ]\n"
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 2379309f084e..d6d01ee9eae3 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -25,6 +25,7 @@ int nl_gchannels(struct cmd_context *ctx);
 int nl_geee(struct cmd_context *ctx);
 int nl_gfec(struct cmd_context *ctx);
 int nl_scoalesce(struct cmd_context *ctx);
+int nl_sring(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/params.c b/netlink/params.c
index b86922b8d215..ee0d5e0c51c6 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -510,3 +510,37 @@ int nl_scoalesce(struct cmd_context *ctx)
 	return nl_set_param(ctx, "-C", scoalesce_params, ETHA_PARAMS_COALESCE,
 			    ETHA_COALESCE_MAX);
 }
+
+static const struct param_parser sring_params[] = {
+	{
+		.arg		= "rx",
+		.type		= ETHA_RING_RX_PENDING,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-mini",
+		.type		= ETHA_RING_RX_MINI_PENDING,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-jumbo",
+		.type		= ETHA_RING_RX_JUMBO_PENDING,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx",
+		.type		= ETHA_RING_TX_PENDING,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_sring(struct cmd_context *ctx)
+{
+	return nl_set_param(ctx, "-G", sring_params, ETHA_PARAMS_RING,
+			    ETHA_RING_MAX);
+}
-- 
2.18.0

