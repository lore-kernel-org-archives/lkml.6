Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970412AbeCSSkM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:40:12 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:34863 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S970430AbeCSShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:37:41 -0400
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Quarantine-ID: <UKorTSUQPEnf>
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:3db:1800:60b5:55d8:d757:229
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 02/11] block: sed-opal: unify space check in add_token_*
Date: Mon, 19 Mar 2018 19:36:44 +0100
Message-Id: <955fd10854ed68f6925612ae73cdaa4637cfb5e4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All add_token_* functions have a common set of conditions that have to
be checked. Use a common function for those checks in order to avoid
different behaviour as well as code duplication.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 5aa41744b8f1..771b4cfff95c 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -510,15 +510,24 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
 	return opal_discovery0_end(dev);
 }
 
-static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
+static bool can_add(int *err, struct opal_dev *cmd, size_t len)
 {
 	if (*err)
-		return;
-	if (cmd->pos >= IO_BUFFER_LENGTH - 1) {
-		pr_debug("Error adding u8: end of buffer.\n");
+		return false;
+
+	if (len > IO_BUFFER_LENGTH || cmd->pos >= IO_BUFFER_LENGTH - len) {
+		pr_debug("Error adding %zu bytes: end of buffer.\n", len);
 		*err = -ERANGE;
-		return;
+		return false;
 	}
+
+	return true;
+}
+
+static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
+{
+	if (!can_add(err, cmd, 1))
+		return;
 	cmd->cmd[cmd->pos++] = tok;
 }
 
@@ -563,9 +572,8 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 	msb = fls64(number);
 	len = DIV_ROUND_UP(msb, 8);
 
-	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
+	if (!can_add(err, cmd, len + 1)) {
 		pr_debug("Error adding u64: end of buffer.\n");
-		*err = -ERANGE;
 		return;
 	}
 	add_short_atom_header(cmd, false, false, len);
@@ -587,9 +595,8 @@ static void add_token_bytestring(int *err, struct opal_dev *cmd,
 		is_short_atom = false;
 	}
 
-	if (len >= IO_BUFFER_LENGTH - cmd->pos - header_len) {
+	if (!can_add(err, cmd, header_len + len)) {
 		pr_debug("Error adding bytestring: end of buffer.\n");
-		*err = -ERANGE;
 		return;
 	}
 
-- 
2.16.1
