Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbeE1JFp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:05:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51096 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbeE1I65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:58:57 -0400
X-Google-Smtp-Source: AB8JxZosHQkwg1HRK4Jv2nQXsIH90XmG2D/KXSP67HyH48qB5GcgK1jjkre+opZBydZHebeoB26pyw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 05/20] lightnvm: pblk: warn in case of corrupted write buffer
Date: Mon, 28 May 2018 10:58:26 +0200
Message-Id: <20180528085841.26684-6-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180528085841.26684-1-mb@lightnvm.io>
References: <20180528085841.26684-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

When cleaning up buffer entries as we wrap up, their state should be
"completed". If any of the entries is in "submitted" state, it means
that something bad has happened. Trigger a warning immediately instead of
waiting for the state flag to eventually be updated, thus hiding the
issue.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 52fdd85dbc97..58946ffebe81 100644
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
2.11.0
