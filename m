Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeD1AdD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:33:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35453 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933322AbeD1Ac6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:58 -0400
X-Google-Smtp-Source: AB8JxZpGifpYVIbSDfAgMnb/Ycc4pP5saR201Pw8qNVSjF5ITPT8dSGwK/vYz2L3LRJ2YaRXQ73shA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [PATCH ethtool 2/2] ethtool: Add support for PHY test modes
Date: Fri, 27 Apr 2018 17:32:37 -0700
Message-Id: <20180428003237.1536-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new commands:

--get-phy-tests which allows fetching supported test modes by a given
  network device's PHY interface
--set-phy-test which allows entering one of the modes listed before and
  pass an eventual set of test specific data

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 ethtool.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 3289e0f6e8ec..f02cd3560197 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4854,6 +4854,118 @@ static int do_reset(struct cmd_context *ctx)
 	return 0;
 }
 
+static int do_gphytest(struct cmd_context *ctx)
+{
+	struct ethtool_gstrings *strings;
+	struct ethtool_phy_test test;
+	unsigned int i;
+	int max_len = 0, cur_len, rc;
+
+	if (ctx->argc != 0)
+		exit_bad_args();
+
+	strings = get_stringset(ctx, ETH_SS_PHY_TESTS, 0, 1);
+	if (!strings) {
+		perror("Cannot get PHY tests strings");
+		return 1;
+	}
+	if (strings->len == 0) {
+		fprintf(stderr, "No PHY tests defined\n");
+		rc = 1;
+		goto err;
+	}
+
+	/* Find longest string and align all strings accordingly */
+	for (i = 0; i < strings->len; i++) {
+		cur_len = strlen((const char*)strings->data +
+				 i * ETH_GSTRING_LEN);
+		if (cur_len > max_len)
+			max_len = cur_len;
+	}
+
+	printf("PHY tests %s:\n", ctx->devname);
+	for (i = 0; i < strings->len; i++) {
+		memset(&test, 0, sizeof(test));
+		test.cmd = ETHTOOL_GPHYTEST;
+		test.mode = i;
+
+		rc = send_ioctl(ctx, &test);
+		if (rc < 0)
+			continue;
+
+		fprintf(stdout, "     %.*s (Test data: %s)\n",
+		       max_len,
+		       (const char *)strings->data + i * ETH_GSTRING_LEN,
+		       test.len ? "Yes" : "No");
+	}
+
+	rc = 0;
+
+err:
+	free(strings);
+	return rc;
+}
+
+static int do_sphytest(struct cmd_context *ctx)
+{
+	struct ethtool_gstrings *strings;
+	struct ethtool_phy_test gtest;
+	struct ethtool_phy_test *stest;
+	unsigned int i;
+	int rc;
+
+	if (ctx->argc < 1)
+		exit_bad_args();
+
+	strings = get_stringset(ctx, ETH_SS_PHY_TESTS, 0, 1);
+	if (!strings) {
+		perror("Cannot get PHY test modes");
+		return 1;
+	}
+
+	if (strings->len == 0) {
+		fprintf(stderr, "No PHY tests defined\n");
+		rc = 1;
+		goto err;
+	}
+
+	for (i = 0; i < strings->len; i++) {
+		if (!strcmp(ctx->argp[0],
+			    (const char *)strings->data + i * ETH_GSTRING_LEN))
+			break;
+	}
+
+	if (i == strings->len)
+		exit_bad_args();
+
+	memset(&gtest, 0, sizeof(gtest));
+	gtest.cmd = ETHTOOL_GPHYTEST;
+	gtest.mode = i;
+	rc = send_ioctl(ctx, &gtest);
+	if (rc < 0) {
+		rc = 1;
+		goto err;
+	}
+
+	stest = calloc(1, sizeof(*stest) + gtest.len);
+	if (!stest) {
+		perror("Unable to allocate memory");
+		rc = 1;
+		goto err;
+	}
+
+	stest->cmd = ETHTOOL_SPHYTEST;
+	stest->len = gtest.len;
+	stest->mode = i;
+
+	rc = send_ioctl(ctx, stest);
+	free(stest);
+err:
+	free(strings);
+	return rc;
+}
+
+
 static int parse_named_bool(struct cmd_context *ctx, const char *name, u8 *on)
 {
 	if (ctx->argc < 2)
@@ -5223,6 +5335,9 @@ static const struct option {
 	{ "--show-fec", 1, do_gfec, "Show FEC settings"},
 	{ "--set-fec", 1, do_sfec, "Set FEC settings",
 	  "		[ encoding auto|off|rs|baser ]\n"},
+	{ "--get-phy-tests", 1, do_gphytest,"Get PHY test mode(s)" },
+	{ "--set-phy-test", 1, do_sphytest, "Set PHY test mode",
+	  "		[ test options ]\n" },
 	{ "-h|--help", 0, show_usage, "Show this help" },
 	{ "--version", 0, do_version, "Show version number" },
 	{}
-- 
2.14.1
