Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeCMNJi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:09:38 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:40317 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932484AbeCMNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:09:30 -0400
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Quarantine-ID: <9mIWoGAQP-yN>
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:3c2:e00:dbd1:5c46:f440:b630
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] block: sed-opal: unify space check in add_token_*
Date: Tue, 13 Mar 2018 14:08:55 +0100
Message-Id: <946b37d9bba3d72c6a5e616452976fa7889b3e82.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All add_token_* functions have a common set of conditions that have to
be checked. Use a common function for those checks in order to avoid
different behaviour.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index f9d94ce64b08..a228a13f0a08 100644
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
 
@@ -564,9 +573,8 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 	msb = fls(number);
 	len = DIV_ROUND_UP(msb, 4);
 
-	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
+	if (!can_add(err, cmd, len + 1)) {
 		pr_debug("Error adding u64: end of buffer.\n");
-		*err = -ERANGE;
 		return;
 	}
 	add_short_atom_header(cmd, false, false, len);
@@ -590,9 +598,8 @@ static void add_token_bytestring(int *err, struct opal_dev *cmd,
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
