Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeBVRuU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:50:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933441AbeBVRuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:50:16 -0500
From: Colin King <colin.king@canonical.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ath25: check for kzalloc allocation failure
Date: Thu, 22 Feb 2018 17:50:12 +0000
Message-Id: <20180222175012.11076-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is no null check on a failed allocation of board_data,
and hence a null pointer dereference will occurr.  Fix this by checking
for the out of memory null pointer.

Fixes: a7473717483e ("MIPS: ath25: add board configuration detection")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/mips/ath25/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
index 9ab48ff80c1c..6d11ae581ea7 100644
--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -135,6 +135,8 @@ int __init ath25_find_config(phys_addr_t base, unsigned long size)
 	}
 
 	board_data = kzalloc(BOARD_CONFIG_BUFSZ, GFP_KERNEL);
+	if (!board_data)
+		goto error;
 	ath25_board.config = (struct ath25_boarddata *)board_data;
 	memcpy_fromio(board_data, bcfg, 0x100);
 	if (broken_boarddata) {
-- 
2.15.1
