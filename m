Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeD3JMW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:12:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36176 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeD3JKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:10:22 -0400
X-Google-Smtp-Source: AB8JxZr/UnnhSzwslR/Z+dHhKK8pSnFkjzWMq4UYLm6GXgsfru+8MxYOM9EAobkCEtBvhLr2qrBh3g==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 05/11] lightnvm: pblk: warn in case of corrupted write buffer
Date: Mon, 30 Apr 2018 11:10:03 +0200
Message-Id: <1525079409-6588-6-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
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
