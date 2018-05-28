Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754390AbeE1JDD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:03:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38860 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754146AbeE1I7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:12 -0400
X-Google-Smtp-Source: AB8JxZpx7cxjDzd63wGHe2ib/f1yzGcKu1x1PlngNbT5bcaKUPjHtVb7GFPfaUhdY4NCZaxAWm/uYg==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/20] lightnvm: error handling when whole line is bad
Date: Mon, 28 May 2018 10:58:37 +0200
Message-Id: <20180528085841.26684-17-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180528085841.26684-1-mb@lightnvm.io>
References: <20180528085841.26684-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

When all the blocks (chunks) in line are marked as bad (offline)
we shouldn't try to read smeta during init process.

Currently we are trying to do so by passing -1 as PPA address,
what causes multiple warnings, that we issuing IOs to out-of-bound
PPAs.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Updated title.
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a20b41c355c5..e3e883547198 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -868,6 +868,11 @@ int pblk_line_read_smeta(struct pblk *pblk, struct pblk_line *line)
 {
 	u64 bpaddr = pblk_line_smeta_start(pblk, line);
 
+	if (bpaddr == -1) {
+		/* Whole line is bad - do not try to read smeta. */
+		return 1;
+	}
+
 	return pblk_line_submit_smeta_io(pblk, line, bpaddr, PBLK_READ_RECOV);
 }
 
-- 
2.11.0
