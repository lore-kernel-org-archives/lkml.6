Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDFGri (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:47:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46127 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDFGrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:47:36 -0400
X-Google-Smtp-Source: AIpwx4+XPctnfbpDtnBSeyzAKv/BxphNlM1PAIxDA0D06Gkb3CHaZpaIVCJ1g2yDCsZ0YMkrydw04A==
From: Tobias Regnery <tobias.regnery@gmail.com>
To: keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH] pstore: fix crypto dependencies without compression
Date: Fri,  6 Apr 2018 08:38:04 +0200
Message-Id: <20180406063804.30510-1-tobias.regnery@gmail.com>
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

Fix this by selecting CONFIG_CRYPTO unconditionally.

Fixes: 58eb5b670747 ("pstore: fix crypto dependencies")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
 fs/pstore/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 09c19ef91526..f42ea286ccd7 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -1,6 +1,6 @@
 config PSTORE
 	tristate "Persistent store support"
-	select CRYPTO if PSTORE_COMPRESS
+	select CRYPTO
 	default n
 	help
 	   This option enables generic access to platform level
-- 
2.16.3
