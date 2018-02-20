Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeBTTiq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:38:46 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:58223 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752928AbeBTTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:38:41 -0500
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:3d7:8b00:25dd:6ce4:6608:2c3f
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: sed-opal: fix response string extraction
Date: Tue, 20 Feb 2018 20:20:38 +0100
Message-Id: <20180220192039.3912-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tokens are prefixed by a variable length of bytes. If a bytestring is
not stored in an tiny or short atom, we have to skip more than one byte
in order to have the actual bytes not prefixed by the bytes describing
the actual length of the string.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 525506bed399..33052d0111de 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -876,6 +876,9 @@ static int response_parse(const u8 *buf, size_t length,
 static size_t response_get_string(const struct parsed_resp *resp, int n,
 				  const char **store)
 {
+	u8 skip;
+	const struct opal_resp_tok *token;
+
 	*store = NULL;
 	if (!resp) {
 		pr_debug("Response is NULL\n");
@@ -888,13 +891,30 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 		return 0;
 	}
 
-	if (resp->toks[n].type != OPAL_DTA_TOKENID_BYTESTRING) {
+	token = &resp->toks[n];
+	if (token->type != OPAL_DTA_TOKENID_BYTESTRING) {
 		pr_debug("Token is not a byte string!\n");
 		return 0;
 	}
 
-	*store = resp->toks[n].pos + 1;
-	return resp->toks[n].len - 1;
+	switch (token->width) {
+	case OPAL_WIDTH_TINY:
+	case OPAL_WIDTH_SHORT:
+		skip = 1;
+		break;
+	case OPAL_WIDTH_MEDIUM:
+		skip = 2;
+		break;
+	case OPAL_WIDTH_LONG:
+		skip = 4;
+		break;
+	default:
+		pr_debug("Token has invalid width!\n");
+		return 0;
+	}
+
+	*store = token->pos + skip;
+	return token->len - skip;
 }
 
 static u64 response_get_u64(const struct parsed_resp *resp, int n)
-- 
2.13.6
