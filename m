Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeDFHeq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:34:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56079 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDFHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:34:44 -0400
X-Google-Smtp-Source: AIpwx48IbSBJ1yBgrziS5wvD6yRk6vdAkv9SSWcoqF+kDUJc2Yu9z7GPEmj+FyXPsAi8xBgAG9kj3g==
From: Tobias Regnery <tobias.regnery@gmail.com>
To: keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH v2] pstore: fix crypto dependencies without compression
Date: Fri,  6 Apr 2018 09:25:17 +0200
Message-Id: <20180406072517.27709-1-tobias.regnery@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 58eb5b670747 ("pstore: fix crypto dependencies") fixed up the crypto
dependencies but missed the case when no compression is selected.

With CONFIG_PSTORE=y, CONFIG_PSTORE_COMPRESS=n  and CONFIG_CRYPTO=m we see
the following link error:

fs/pstore/platform.o: In function `pstore_register':
(.text+0x1b1): undefined reference to `crypto_has_alg'
(.text+0x205): undefined reference to `crypto_alloc_base'
fs/pstore/platform.o: In function `pstore_unregister':
(.text+0x3b0): undefined reference to `crypto_destroy_tfm'

Fix this by checking at compile-time if CONFIG_PSTORE_COMPRESS is enabled.

Fixes: 58eb5b670747 ("pstore: fix crypto dependencies")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
v2: check the config at compile-time rather than change the 
    kconfig-dependency as suggested by Arnd.

---
 fs/pstore/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 1143ef351c58..dc720573fd53 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -258,7 +258,7 @@ static int pstore_decompress(void *in, void *out,
 
 static void allocate_buf_for_compression(void)
 {
-	if (!zbackend)
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
 		return;
 
 	if (!crypto_has_comp(zbackend->name, 0, 0)) {
@@ -287,7 +287,7 @@ static void allocate_buf_for_compression(void)
 
 static void free_buf_for_compression(void)
 {
-	if (!IS_ERR_OR_NULL(tfm))
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && !IS_ERR_OR_NULL(tfm))
 		crypto_free_comp(tfm);
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
-- 
2.16.3
