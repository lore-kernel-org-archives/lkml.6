Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA420893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeG3Oca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:32:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730482AbeG3Oc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B2B4ADDD;
        Mon, 30 Jul 2018 12:57:35 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id CA221A0BE8; Mon, 30 Jul 2018 14:57:34 +0200 (CEST)
Message-Id: <622072b1376dc468eec9f322c909d5b6b9d206c8.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 22/23] netlink: add netlink handler for seee
 (--set-eee)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:57:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool --set-eee <dev>" subcommand using netlink interface
command ETHNL_CMD_SET_PARAMS.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c        |  5 +++--
 netlink/extapi.h |  1 +
 netlink/params.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 9ac7f3c57ecb..bd85b0c50ce2 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4889,6 +4889,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_sring	NULL
 #define nl_spause	NULL
 #define nl_schannels	NULL
+#define nl_seee		NULL
 #endif
 
 static const struct option {
@@ -5061,10 +5062,10 @@ static const struct option {
 	  "		[ length N ]\n" },
 	{ "--show-eee", 1, do_geee, nl_geee,
 	  "Show EEE settings"},
-	{ "--set-eee", 1, do_seee, NULL,
+	{ "--set-eee", 1, do_seee, nl_seee,
 	  "Set EEE settings",
 	  "		[ eee on|off ]\n"
-	  "		[ advertise %x ]\n"
+	  "		[ advertise %x[/%x] | mode on|off ... ]\n"
 	  "		[ tx-lpi on|off ]\n"
 	  "		[ tx-timer %d ]\n"},
 	{ "--set-phy-tunable", 1, do_set_phy_tunable, NULL,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index bc33be82bdd5..80ed4afb5227 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -28,6 +28,7 @@ int nl_scoalesce(struct cmd_context *ctx);
 int nl_sring(struct cmd_context *ctx);
 int nl_spause(struct cmd_context *ctx);
 int nl_schannels(struct cmd_context *ctx);
+int nl_seee(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/params.c b/netlink/params.c
index 5e0f0d264187..1cc2ffbc4b27 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -606,3 +606,37 @@ int nl_schannels(struct cmd_context *ctx)
 	return nl_set_param(ctx, "-L", schannels_params, ETHA_PARAMS_CHANNELS,
 			    ETHA_CHANNELS_MAX);
 }
+
+static const struct param_parser seee_params[] = {
+	{
+		.arg		= "advertise",
+		.type		= ETHA_EEE_LINK_MODES,
+		.handler	= nl_parse_bitset,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-lpi",
+		.type		= ETHA_EEE_TX_LPI_ENABLED,
+		.handler	= nl_parse_bool,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-timer",
+		.type		= ETHA_EEE_TX_LPI_TIMER,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "eee",
+		.type		= ETHA_EEE_ENABLED,
+		.handler	= nl_parse_bool,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_seee(struct cmd_context *ctx)
+{
+	return nl_set_param(ctx, "--set-eee", seee_params, ETHA_PARAMS_EEE,
+			    ETHA_EEE_MAX);
+}
-- 
2.18.0

