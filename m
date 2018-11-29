Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE43C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F30C2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dGtLMlP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F30C2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeK3KQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46433 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeK3KQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1596304pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nIeLl3OW3lj4zGgU4HrhVDDzANdcxPOOLFi2e91J6rM=;
        b=dGtLMlP9p8dUzxsg3KStPPy0xWZIduBa0s2Fl6OjyLse+0VB+mCqhLztK2ZlWhaKtU
         CbO2MLgm6Vb+ZVcSd+BeDp2mHXpN8BSPDCSk8RsR2H3ibEGM2Vnfehj12MOlVpemWyQA
         +YbYh/Ah1QvhV1MC1pAYYk2Qb0fr0XvQbRrCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nIeLl3OW3lj4zGgU4HrhVDDzANdcxPOOLFi2e91J6rM=;
        b=FM5ldlhDLAyQuDvcUeGzR3q/0WLwfOe8pQ3rqB4F96GydnA3+2Uil6cDuUr9jqgF4Z
         8N/JtINb9z5Psbsp1kJSVZ4jRKVww22aVlW6SgvpSv4WKGKnj4HcTcsRSGxaxUPOcxYt
         GFFAWzt4rZJeA8oryBYk7Zmgb57vwkSK89jVFLl9T3KeitocYhr9hDbezF0BjCQTBrHA
         U4bq8fDshfkRW2HpvZViBsHKeX2y2VNme1m6eH+6bxsziALv1GT0wua86e4cQlbSCzOV
         25Y/ffzXo+yhp3pRLLdch8Q+zJxKnkvx75eO/yHCSeYY/8iTBAcN5g8BzW+fgqlc1QiE
         2wow==
X-Gm-Message-State: AA+aEWYyG0TJ5/WrFOSv+fVqZ5S+JXXMAkkSZ5l3j1I/scHgvkgNTrrx
        xSamYMr7FfLNcnH6BrxCAD+ukGf1wlDGpg==
X-Google-Smtp-Source: AFSGD/W7+yhrLpxeowWoelePr/LczTF44MIMX7NZnCXHuFVcnIBLzXhMIPJ9OGkObfX2lPnaQlhVPg==
X-Received: by 2002:a62:3687:: with SMTP id d129-v6mr3348704pfa.56.1543532934021;
        Thu, 29 Nov 2018 15:08:54 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q1sm4131385pfb.96.2018.11.29.15.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 03/12] pstore: Remove needless lock during console writes
Date:   Thu, 29 Nov 2018 15:08:32 -0800
Message-Id: <20181129230841.29955-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the console writer does not use the preallocated crash dump buffer
any more, there is no reason to perform locking around it.

Fixes: 70ad35db3321 ("pstore: Convert console write to use ->write_buf")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/platform.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 8b6028948cf3..a75756c48e10 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -462,31 +462,14 @@ static void pstore_unregister_kmsg(void)
 #ifdef CONFIG_PSTORE_CONSOLE
 static void pstore_console_write(struct console *con, const char *s, unsigned c)
 {
-	const char *e = s + c;
+	struct pstore_record record;
 
-	while (s < e) {
-		struct pstore_record record;
-		unsigned long flags;
-
-		pstore_record_init(&record, psinfo);
-		record.type = PSTORE_TYPE_CONSOLE;
-
-		if (c > psinfo->bufsize)
-			c = psinfo->bufsize;
+	pstore_record_init(&record, psinfo);
+	record.type = PSTORE_TYPE_CONSOLE;
 
-		if (oops_in_progress) {
-			if (!spin_trylock_irqsave(&psinfo->buf_lock, flags))
-				break;
-		} else {
-			spin_lock_irqsave(&psinfo->buf_lock, flags);
-		}
-		record.buf = (char *)s;
-		record.size = c;
-		psinfo->write(&record);
-		spin_unlock_irqrestore(&psinfo->buf_lock, flags);
-		s += c;
-		c = e - s;
-	}
+	record.buf = (char *)s;
+	record.size = c;
+	psinfo->write(&record);
 }
 
 static struct console pstore_console = {
-- 
2.17.1

