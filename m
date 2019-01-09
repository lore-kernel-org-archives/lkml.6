Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70837206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfAIPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:40:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:60800 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbfAIPk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:40:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 07:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="133059425"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2019 07:40:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 602373B3; Wed,  9 Jan 2019 17:40:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] seq_file: convert mangle_path() to use string_escape_str()
Date:   Wed,  9 Jan 2019 17:40:22 +0200
Message-Id: <20190109154022.23551-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since string_escape_str() does not support overlapping buffer first we check if
there is enough room in the buffer and then update a path. The side effect of
this change is in case of failure the buffer is left unchanged.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/seq_file.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1dea7a8a5255..b818b23070e6 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -421,21 +421,13 @@ EXPORT_SYMBOL(seq_printf);
  */
 char *mangle_path(char *s, const char *p, const char *esc)
 {
-	while (s <= p) {
-		char c = *p++;
-		if (!c) {
-			return s;
-		} else if (!strchr(esc, c)) {
-			*s++ = c;
-		} else if (s + 4 > p) {
-			break;
-		} else {
-			*s++ = '\\';
-			*s++ = '0' + ((c & 0300) >> 6);
-			*s++ = '0' + ((c & 070) >> 3);
-			*s++ = '0' + (c & 07);
-		}
-	}
+	size_t len = p + strlen(p) - s;
+	int ret;
+
+	ret = string_escape_str(p, NULL, 0, ESCAPE_OCTAL, esc);
+	if (ret < len)
+		return s + string_escape_str(p, s, len, ESCAPE_OCTAL, esc);
+
 	return NULL;
 }
 EXPORT_SYMBOL(mangle_path);
-- 
2.20.1

