Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D526FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B3820892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B3820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbeG3Oce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:32:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:50646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730482AbeG3Ocd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:32:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26A87AEEB;
        Mon, 30 Jul 2018 12:57:40 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D0018A0BE8; Mon, 30 Jul 2018 14:57:39 +0200 (CEST)
Message-Id: <61559cddb892494c58aa6b72a5f1d21ecf9cb2d7.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 23/23] netlink: add netlink handler for sfec
 (--set-fec)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:57:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "ethtool --set-fec <dev>" subcommand using netlink interface
command ETHNL_CMD_SET_PARAMS.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 ethtool.c        |  3 ++-
 netlink/extapi.h |  1 +
 netlink/params.c | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index bd85b0c50ce2..8160ab200a16 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4890,6 +4890,7 @@ static int show_usage(struct cmd_context *ctx);
 #define nl_spause	NULL
 #define nl_schannels	NULL
 #define nl_seee		NULL
+#define nl_sfec		NULL
 #endif
 
 static const struct option {
@@ -5099,7 +5100,7 @@ static const struct option {
 	  "		[ all ]\n"},
 	{ "--show-fec", 1, do_gfec, nl_gfec,
 	  "Show FEC settings"},
-	{ "--set-fec", 1, do_sfec, NULL,
+	{ "--set-fec", 1, do_sfec, nl_sfec,
 	  "Set FEC settings",
 	  "		[ encoding auto|off|rs|baser ]\n"},
 	{ "-h|--help", 0, show_usage, NULL,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 80ed4afb5227..1938c6075758 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -29,6 +29,7 @@ int nl_sring(struct cmd_context *ctx);
 int nl_spause(struct cmd_context *ctx);
 int nl_schannels(struct cmd_context *ctx);
 int nl_seee(struct cmd_context *ctx);
+int nl_sfec(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/params.c b/netlink/params.c
index 1cc2ffbc4b27..95a54d0d2978 100644
--- a/netlink/params.c
+++ b/netlink/params.c
@@ -640,3 +640,20 @@ int nl_seee(struct cmd_context *ctx)
 	return nl_set_param(ctx, "--set-eee", seee_params, ETHA_PARAMS_EEE,
 			    ETHA_EEE_MAX);
 }
+
+static const struct param_parser sfec_params[] = {
+	{
+		.arg		= "modes",
+		.type		= ETHA_FEC_MODES,
+		.handler	= nl_parse_bitfield32,
+		.handler_data	= flags_fecenc,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_sfec(struct cmd_context *ctx)
+{
+	return nl_set_param(ctx, "--set-fec", sfec_params, ETHA_PARAMS_FEC,
+			    ETHA_FEC_MAX);
+}
-- 
2.18.0

