Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeDPK1e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:27:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41567 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbeDPKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:46 -0400
X-Google-Smtp-Source: AIpwx48oWFMMERTmeqUfaY7xyubsC90Cbj17Y4zDIJsP/rJGkRdDhztswRnkQTdxtpkXSDga5VRh9w==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 05/11] lightnvm: pblk: warn in case of corrupted write buffer
Date: Mon, 16 Apr 2018 12:25:26 +0200
Message-Id: <1523874332-6272-6-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cleaning up buffer entries as we wrap up, their state should be
"completed". If any of the entries is in "submitted" state, it means
that something bad has happened. Trigger a warning immediately instead of
waiting for the state flag to eventually be updated, thus hiding the
issue.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 7a632913475f..024a366a995c 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -142,10 +142,9 @@ static void clean_wctx(struct pblk_w_ctx *w_ctx)
 {
 	int flags;
 
-try:
 	flags = READ_ONCE(w_ctx->flags);
-	if (!(flags & PBLK_SUBMITTED_ENTRY))
-		goto try;
+	WARN_ONCE(!(flags & PBLK_SUBMITTED_ENTRY),
+			"pblk: overwriting unsubmitted data\n");
 
 	/* Release flags on context. Protect from writes and reads */
 	smp_store_release(&w_ctx->flags, PBLK_WRITABLE_ENTRY);
-- 
2.7.4
