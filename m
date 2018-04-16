Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbeDPK1D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:27:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39376 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754134AbeDPKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:49 -0400
X-Google-Smtp-Source: AIpwx4+LPRvNrEm7zrwOJTeZYEH0SY+a2cnPZjWd1oUeow0getoPuzR2T2E+R098a/bn2PItENd0BQ==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 09/11] lightnvm: pblk: check for chunk size before allocating it
Date: Mon, 16 Apr 2018 12:25:30 +0200
Message-Id: <1523874332-6272-10-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do the check for the chunk state after making sure that the chunk type
is supported.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b52855f9336b..9e3a43346d4c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -751,14 +751,14 @@ static int pblk_setup_line_meta_20(struct pblk *pblk, struct pblk_line *line,
 		chunk->cnlb = chunk_meta->cnlb;
 		chunk->wp = chunk_meta->wp;
 
-		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
-			continue;
-
 		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
 			WARN_ONCE(1, "pblk: custom-sized chunks unsupported\n");
 			continue;
 		}
 
+		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
+			continue;
+
 		set_bit(pos, line->blk_bitmap);
 		nr_bad_chks++;
 	}
-- 
2.7.4
