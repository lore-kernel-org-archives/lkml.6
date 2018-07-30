Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB88CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF72208A4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF72208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeG3OcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:32:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:50602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730482AbeG3OcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:32:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F895AE83;
        Mon, 30 Jul 2018 12:57:25 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id BD9EBA0BE8; Mon, 30 Jul 2018 14:57:24 +0200 (CEST)
Message-Id: <163ed9f92a0367fc687625e851aa3db87e2092cf.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 20/23] netlink: add netlink handler for spause
 (-A)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:57:24 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool -A <dev>" subcommand using netlink interface command
ETHNL_CMD_SET_PARAMS.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c        |  3 ++-
 netlink/extapi.h |  1 +
 netlink/params.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 792283c46d35..b6e322af9c8a 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4887,6 +4887,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_gfec		NULL
 #define nl_scoalesce	NULL
 #define nl_sring	NULL
+#define nl_spause	NULL
 #endif
 
 static const struct option {
@@ -4912,7 +4913,7 @@ static const struct option {
 	  "		[ msglvl %d[/%d] | type on|off ... [--] ]\n" },
 	{ "-a|--show-pause", 1, do_gpause, nl_gpause,
 	  "Show pause options" },
-	{ "-A|--pause", 1, do_spause, NULL,
+	{ "-A|--pause", 1, do_spause, nl_spause,
 	  "Set pause options",
 	  "		[ autoneg on|off ]\n"
 	  "		[ rx on|off ]\n"
diff --git a/netlink/extapi.h b/netlink/extapi.h
index d6d01ee9eae3..8cf1d0093aaa 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -26,6 +26,7 @@ int nl_geee(struct cmd_context *ctx);
 int nl_gfec(struct cmd_context *ctx);
 int nl_scoalesce(struct cmd_context *ctx);
 int nl_sring(struct cmd_context *ctx);
+int nl_spause(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/params.c b/netlink/params.c
index ee0d5e0c51c6..953678a0b227 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -544,3 +544,31 @@ int nl_sring(struct cmd_context *ctx)
 	return nl_set_param(ctx, "-G", sring_params, ETHA_PARAMS_RING,
 			    ETHA_RING_MAX);
 }
+
+static const struct param_parser spause_params[] = {
+	{
+		.arg		= "autoneg",
+		.type		= ETHA_PAUSE_AUTONEG,
+		.handler	= nl_parse_bool,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx",
+		.type		= ETHA_PAUSE_RX,
+		.handler	= nl_parse_bool,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx",
+		.type		= ETHA_PAUSE_TX,
+		.handler	= nl_parse_bool,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_spause(struct cmd_context *ctx)
+{
+	return nl_set_param(ctx, "-A", spause_params, ETHA_PARAMS_PAUSE,
+			    ETHA_PAUSE_MAX);
+}
-- 
2.18.0

