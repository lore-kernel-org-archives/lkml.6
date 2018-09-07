Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBBCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5E02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5E02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeIGRU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:20:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbeIGRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:33 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007c9-V3; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00062m-LM; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 24/25] ubifs: Enable authentication support
Date:   Fri,  7 Sep 2018 14:36:45 +0200
Message-Id: <20180907123646.12688-25-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907123646.12688-1-s.hauer@pengutronix.de>
References: <20180907123646.12688-1-s.hauer@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the preparations all being done this patch now enables authentication
support for UBIFS. Authentication is enabled when the newly introduced
auth_key and auth_hash_name mount options are passed. auth_key provides
the key which is used for authentication whereas auth_hash_name provides
the hashing algorithm used for this FS. Passing these options make
authentication mandatory and only UBIFS images that can be authenticated
with the given key are allowed.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/filesystems/ubifs.txt |  7 ++++++
 fs/ubifs/Kconfig                    | 10 ++++++++
 fs/ubifs/super.c                    | 36 ++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ubifs.txt b/Documentation/filesystems/ubifs.txt
index a0a61d2f389f..acc80442a3bb 100644
--- a/Documentation/filesystems/ubifs.txt
+++ b/Documentation/filesystems/ubifs.txt
@@ -91,6 +91,13 @@ chk_data_crc		do not skip checking CRCs on data nodes
 compr=none              override default compressor and set it to "none"
 compr=lzo               override default compressor and set it to "lzo"
 compr=zlib              override default compressor and set it to "zlib"
+auth_key=		specify the key used for authenticating the filesystem.
+			Passing this option makes authentication mandatory.
+			The passed key must be present in the kernel keyring
+			and must be of type 'logon'
+auth_hash_name=		The hash algorithm used for authentication. Used for
+			both hashing and for creating HMACs. Typical values
+			include "sha256" or "sha512"
 
 
 Quick usage instructions
diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 853c77579b4e..529856fbccd0 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -86,3 +86,13 @@ config UBIFS_FS_SECURITY
 	  the extended attribute support in advance.
 
 	  If you are not using a security module, say N.
+
+config UBIFS_FS_AUTHENTICATION
+	bool "UBIFS authentication support"
+	select CRYPTO_HMAC
+	help
+	  Enable authentication support for UBIFS. This feature offers protection
+	  against offline changes for both data and metadata of the filesystem.
+	  If you say yes here you should also select a hashing algorithm such as
+	  sha256, these are not selected automatically since there are many
+	  different options.
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 12683cb87315..e3fb4dface8c 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -579,7 +579,9 @@ static int init_constants_early(struct ubifs_info *c)
 	c->ranges[UBIFS_REF_NODE].len  = UBIFS_REF_NODE_SZ;
 	c->ranges[UBIFS_TRUN_NODE].len = UBIFS_TRUN_NODE_SZ;
 	c->ranges[UBIFS_CS_NODE].len   = UBIFS_CS_NODE_SZ;
-	c->ranges[UBIFS_AUTH_NODE].len = UBIFS_AUTH_NODE_SZ;
+	c->ranges[UBIFS_AUTH_NODE].min_len = UBIFS_AUTH_NODE_SZ;
+	c->ranges[UBIFS_AUTH_NODE].max_len = UBIFS_AUTH_NODE_SZ +
+				UBIFS_MAX_HMAC_LEN;
 
 	c->ranges[UBIFS_INO_NODE].min_len  = UBIFS_INO_NODE_SZ;
 	c->ranges[UBIFS_INO_NODE].max_len  = UBIFS_MAX_INO_NODE_SZ;
@@ -935,6 +937,8 @@ static int check_volume_empty(struct ubifs_info *c)
  * Opt_no_chk_data_crc: do not check CRCs when reading data nodes
  * Opt_override_compr: override default compressor
  * Opt_assert: set ubifs_assert() action
+ * Opt_auth_key: The key name used for authentication
+ * Opt_auth_hash_name: The hash type used for authentication
  * Opt_err: just end of array marker
  */
 enum {
@@ -946,6 +950,8 @@ enum {
 	Opt_no_chk_data_crc,
 	Opt_override_compr,
 	Opt_assert,
+	Opt_auth_key,
+	Opt_auth_hash_name,
 	Opt_ignore,
 	Opt_err,
 };
@@ -958,6 +964,8 @@ static const match_table_t tokens = {
 	{Opt_chk_data_crc, "chk_data_crc"},
 	{Opt_no_chk_data_crc, "no_chk_data_crc"},
 	{Opt_override_compr, "compr=%s"},
+	{Opt_auth_key, "auth_key=%s"},
+	{Opt_auth_hash_name, "auth_hash_name=%s"},
 	{Opt_ignore, "ubi=%s"},
 	{Opt_ignore, "vol=%s"},
 	{Opt_assert, "assert=%s"},
@@ -1081,6 +1089,16 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 			kfree(act);
 			break;
 		}
+		case Opt_auth_key:
+			c->auth_key_name = kstrdup(args[0].from, GFP_KERNEL);
+			if (!c->auth_key_name)
+				return -ENOMEM;
+			break;
+		case Opt_auth_hash_name:
+			c->auth_hash_name = kstrdup(args[0].from, GFP_KERNEL);
+			if (!c->auth_hash_name)
+				return -ENOMEM;
+			break;
 		case Opt_ignore:
 			break;
 		default:
@@ -1260,6 +1278,19 @@ static int mount_ubifs(struct ubifs_info *c)
 
 	c->mounting = 1;
 
+	if (c->auth_key_name) {
+		if (IS_ENABLED(CONFIG_UBIFS_FS_AUTHENTICATION)) {
+			err = ubifs_init_authentication(c);
+			if (err)
+				goto out_free;
+		} else {
+			ubifs_err(c, "auth_key_name, but UBIFS is built without"
+				  " authentication support");
+			err = -EINVAL;
+			goto out_free;
+		}
+	}
+
 	err = ubifs_read_superblock(c);
 	if (err)
 		goto out_free;
@@ -1577,7 +1608,10 @@ static void ubifs_umount(struct ubifs_info *c)
 	free_wbufs(c);
 	free_orphans(c);
 	ubifs_lpt_free(c, 0);
+	ubifs_exit_authentication(c);
 
+	kfree(c->auth_key_name);
+	kfree(c->auth_hash_name);
 	kfree(c->cbuf);
 	kfree(c->rcvrd_mst_node);
 	kfree(c->mst_node);
-- 
2.18.0

