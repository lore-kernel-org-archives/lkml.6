Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeDIPqq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:46:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34367 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeDIPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:46:39 -0400
X-Google-Smtp-Source: AIpwx4/QYkJcLFxcQ/xKyW23gztK6bmOkfmaTN78ptgrA90FmoKYtdbBDIdFKHXM7lkjdibRojtyFg==
From: Jan Glauber <jglauber@cavium.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mahipal Challa <Mahipal.Challa@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 3/5] crypto: thunderx_zip: Prevent division by zero
Date: Mon,  9 Apr 2018 17:45:52 +0200
Message-Id: <20180409154554.7578-4-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180409154554.7578-1-jglauber@cavium.com>
References: <20180409154554.7578-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid two potential divisions by zero when calculating average
values for the zip statistics.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Reviewed-by: Robert Richter <rrichter@cavium.com>
---
 drivers/crypto/cavium/zip/zip_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
index 1cd8aa488185..79b449e0f955 100644
--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -482,10 +482,11 @@ static int zip_show_stats(struct seq_file *s, void *unused)
 				atomic64_add(val, &st->pending_req);
 			}
 
-			avg_chunk = (atomic64_read(&st->comp_in_bytes) /
-				     atomic64_read(&st->comp_req_complete));
-			avg_cr = (atomic64_read(&st->comp_in_bytes) /
-				  atomic64_read(&st->comp_out_bytes));
+			val = atomic64_read(&st->comp_req_complete);
+			avg_chunk = (val) ? atomic64_read(&st->comp_in_bytes) / val : 0;
+
+			val = atomic64_read(&st->comp_out_bytes);
+			avg_cr = (val) ? atomic64_read(&st->comp_in_bytes) / val : 0;
 			seq_printf(s, "        ZIP Device %d Stats\n"
 				      "-----------------------------------\n"
 				      "Comp Req Submitted        : \t%lld\n"
-- 
2.16.2
