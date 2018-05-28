Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbeE1JEg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:04:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40046 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754193AbeE1I7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:02 -0400
X-Google-Smtp-Source: AB8JxZr+AwqP4yFYnNMfJKuFH+FjUkp+ywV+Yzl4dqAKSWcXhHaS3s8KoiMHqtNWcmB/Kcm3T1JG8g==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/20] lightnvm: pblk: check for chunk size before allocating it
Date: Mon, 28 May 2018 10:58:30 +0200
Message-Id: <20180528085841.26684-10-mb@lightnvm.io>
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

Do the check for the chunk state after making sure that the chunk type
is supported.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
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
2.11.0
