Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1B520893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1B520893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeG3ObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:31:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729395AbeG3ObI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:31:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF51CAF54;
        Mon, 30 Jul 2018 12:56:14 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 682FDA0BE8; Mon, 30 Jul 2018 14:56:14 +0200 (CEST)
Message-Id: <26ffda3b080026f5f0ca1d36dcdee201923b4f33.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 06/23] netlink: add netlink handler for gdrv
 (-i)
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:56:14 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement "-i" subcommand using netlink interface command
ETHNL_CMD_GET_DRVINFO.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Makefile.am       |  1 +
 ethtool.c         |  3 ++-
 netlink/drvinfo.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 netlink/extapi.h  |  1 +
 netlink/monitor.c | 10 ++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 netlink/drvinfo.c

diff --git a/Makefile.am b/Makefile.am
index a412734fffd1..7e24fe8c50f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,6 +23,7 @@ if ETHTOOL_ENABLE_NETLINK
 ethtool_SOURCES += \
 		  netlink/netlink.c netlink/netlink.h netlink/extapi.h \
 		  netlink/strset.c netlink/strset.h netlink/monitor.c \
+		  netlink/drvinfo.c \
 		  uapi/linux/ethtool_netlink.h \
 		  uapi/linux/netlink.h uapi/linux/genetlink.h
 ethtool_CFLAGS += @MNL_CFLAGS@
diff --git a/ethtool.c b/ethtool.c
index b7f40d2f3826..0edb80b19b9d 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5056,6 +5056,7 @@ static int show_usage(struct cmd_context *ctx);
 /* Just define all netlink handlers as null when building without netlink
  * support so that we do not get unresolved symbols in args array below
  */
+#define nl_gdrv		NULL
 #endif
 
 static const struct option {
@@ -5125,7 +5126,7 @@ static const struct option {
 	{ "-K|--features|--offload", 1, do_sfeatures, NULL,
 	  "Set protocol offload and other features",
 	  "		FEATURE on|off ...\n" },
-	{ "-i|--driver", 1, do_gdrv, NULL,
+	{ "-i|--driver", 1, do_gdrv, nl_gdrv,
 	  "Show driver information" },
 	{ "-d|--register-dump", 1, do_gregs, NULL,
 	  "Do a register dump",
diff --git a/netlink/drvinfo.c b/netlink/drvinfo.c
new file mode 100644
index 000000000000..78b4394788a5
--- /dev/null
+++ b/netlink/drvinfo.c
@@ -0,0 +1,43 @@
+#include "../internal.h"
+#include "netlink.h"
+
+int drvinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHA_DRVINFO_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	struct nl_context *nlctx = data;
+	int ret;
+
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+	nlctx->devname = get_dev_name(tb[ETHA_DRVINFO_DEV]);
+	if (!dev_ok(nlctx))
+		return MNL_CB_OK;
+	if (nlctx->is_dump || nlctx->is_monitor)
+		fprintf(stdout, "\nDriver info for %s:\n", nlctx->devname);
+
+	show_string(tb, ETHA_DRVINFO_DRIVER, "driver");
+	show_string(tb, ETHA_DRVINFO_VERSION, "version");
+	show_string(tb, ETHA_DRVINFO_FWVERSION, "firmware-version");
+	show_string(tb, ETHA_DRVINFO_EROM_VER, "expansion-rom-version");
+	show_string(tb, ETHA_DRVINFO_BUSINFO, "bus-info");
+	show_u32_yn(tb, ETHA_DRVINFO_N_STATS, "supports-statistics");
+	show_u32_yn(tb, ETHA_DRVINFO_TESTINFO_LEN, "supports-test");
+	show_u32_yn(tb, ETHA_DRVINFO_EEDUMP_LEN, "supports-eeprom-access");
+	show_u32_yn(tb, ETHA_DRVINFO_REGDUMP_LEN, "supports-register-dump");
+	show_u32_yn(tb, ETHA_DRVINFO_N_PRIV_FLAGS, "supports-priv-flags");
+
+	return MNL_CB_OK;
+}
+
+int nl_gdrv(struct cmd_context *ctx)
+{
+	int ret;
+
+	ret = ethnl_prep_get_request(ctx, ETHNL_CMD_GET_DRVINFO,
+				     ETHA_DRVINFO_DEV);
+	if (ret < 0)
+		return ret;
+	return ethnl_send_get_request(ctx->nlctx, drvinfo_reply_cb);
+}
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 827e3732888a..546090a02a0d 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -13,6 +13,7 @@ struct nl_context;
 int netlink_init(struct cmd_context *ctx);
 int netlink_done(struct cmd_context *ctx);
 
+int nl_gdrv(struct cmd_context *ctx);
 int nl_monitor(struct cmd_context *ctx);
 
 void monitor_usage();
diff --git a/netlink/monitor.c b/netlink/monitor.c
index d7ed562356f1..ae7d6080e03d 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -66,6 +66,8 @@ static int monitor_event_cb(const struct nlmsghdr *nlhdr, void *data)
 	return MNL_CB_OK;
 }
 
+int drvinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data);
+
 static struct {
 	uint8_t		cmd;
 	mnl_cb_t	cb;
@@ -74,6 +76,10 @@ static struct {
 		.cmd	= ETHNL_CMD_EVENT,
 		.cb	= monitor_event_cb,
 	},
+	{
+		.cmd	= ETHNL_CMD_SET_DRVINFO,
+		.cb	= drvinfo_reply_cb,
+	},
 };
 
 static int monitor_any_cb(const struct nlmsghdr *nlhdr, void *data)
@@ -103,6 +109,10 @@ static struct monitor_option monitor_opts[] = {
 		.pattern	= "--all",
 		.cmd		= 0,
 	},
+	{
+		.pattern	= "-i|--driver",
+		.cmd		= ETHNL_CMD_SET_DRVINFO,
+	},
 };
 
 static bool pattern_match(const char *s, const char *pattern)
-- 
2.18.0

