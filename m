Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934743AbeCGUs6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:48:58 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40637 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934510AbeCGUs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:48:56 -0500
X-Google-Smtp-Source: AG47ELtwIor35cB9Qdv0q2toSfvND8err8xZDUXL07gUk7GSZICQy/+1KIf/dLL48l1rIy86Y/6Q7A==
Date: Wed, 7 Mar 2018 12:48:53 -0800
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "Tobin C. Harding" <tobin@apporbit.com>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH -next] pstore/ram: Do not use stack VLA for parity workspace
Message-ID: <20180307204853.GA40076@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a stack VLA for the parity workspace, preallocate a
memory region. The preallocation is done to keep from needing to perform
allocations during crash dump writing, etc. This also fixes a missed
release of librs on free.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram_core.c       | 29 ++++++++++++++++++++++-------
 include/linux/pstore_ram.h |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index e11672aa4575..951a14edcf51 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -98,24 +98,23 @@ static void notrace persistent_ram_encode_rs8(struct persistent_ram_zone *prz,
 	uint8_t *data, size_t len, uint8_t *ecc)
 {
 	int i;
-	uint16_t par[prz->ecc_info.ecc_size];
 
 	/* Initialize the parity buffer */
-	memset(par, 0, sizeof(par));
-	encode_rs8(prz->rs_decoder, data, len, par, 0);
+	memset(prz->ecc_info.par, 0,
+	       prz->ecc_info.ecc_size * sizeof(prz->ecc_info.par[0]));
+	encode_rs8(prz->rs_decoder, data, len, prz->ecc_info.par, 0);
 	for (i = 0; i < prz->ecc_info.ecc_size; i++)
-		ecc[i] = par[i];
+		ecc[i] = prz->ecc_info.par[i];
 }
 
 static int persistent_ram_decode_rs8(struct persistent_ram_zone *prz,
 	void *data, size_t len, uint8_t *ecc)
 {
 	int i;
-	uint16_t par[prz->ecc_info.ecc_size];
 
 	for (i = 0; i < prz->ecc_info.ecc_size; i++)
-		par[i] = ecc[i];
-	return decode_rs8(prz->rs_decoder, data, par, len,
+		prz->ecc_info.par[i] = ecc[i];
+	return decode_rs8(prz->rs_decoder, data, prz->ecc_info.par, len,
 				NULL, 0, NULL, 0, NULL);
 }
 
@@ -228,6 +227,15 @@ static int persistent_ram_init_ecc(struct persistent_ram_zone *prz,
 		return -EINVAL;
 	}
 
+	/* allocate workspace instead of using stack VLA */
+	prz->ecc_info.par = kmalloc_array(prz->ecc_info.ecc_size,
+					  sizeof(*prz->ecc_info.par),
+					  GFP_KERNEL);
+	if (!prz->ecc_info.par) {
+		pr_err("cannot allocate ECC parity workspace\n");
+		return -ENOMEM;
+	}
+
 	prz->corrected_bytes = 0;
 	prz->bad_blocks = 0;
 
@@ -514,6 +522,13 @@ void persistent_ram_free(struct persistent_ram_zone *prz)
 		}
 		prz->vaddr = NULL;
 	}
+	if (prz->rs_decoder) {
+		free_rs(prz->rs_decoder);
+		prz->rs_decoder = NULL;
+	}
+	kfree(prz->ecc_info.par);
+	prz->ecc_info.par = NULL;
+
 	persistent_ram_free_old(prz);
 	kfree(prz);
 }
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9395f06e8372..e6d226464838 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -39,6 +39,7 @@ struct persistent_ram_ecc_info {
 	int ecc_size;
 	int symsize;
 	int poly;
+	uint16_t *par;
 };
 
 struct persistent_ram_zone {
-- 
2.7.4


-- 
Kees Cook
Pixel Security
