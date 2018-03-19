Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeCSL1P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:27:15 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30060 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCSL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:27:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w2JBQHQr023258
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/7] lib: zstd: clean up Makefile for simpler composite object handling
Date: Mon, 19 Mar 2018 20:26:09 +0900
Message-Id: <1521458773-14224-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, Kbuild nicely handles composite objects to avoid multiple
definition.

Makefiles can simply add the same objects multiple times across
composite objects.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

The is clean-up from build system point of view.

I will apply this for the Kbuild tree.


 lib/zstd/Makefile | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index dd0a359..a1a64cf 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -4,15 +4,7 @@ obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
 ccflags-y += -O3
 
 # Object files unique to zstd_compress and zstd_decompress
-zstd_compress-y := fse_compress.o huf_compress.o compress.o
-zstd_decompress-y := huf_decompress.o decompress.o
-
-# These object files are shared between the modules.
-# Always add them to zstd_compress.
-# Unless both zstd_compress and zstd_decompress are built in
-# then also add them to zstd_decompress.
-zstd_compress-y += entropy_common.o fse_decompress.o zstd_common.o
-
-ifneq ($(CONFIG_ZSTD_COMPRESS)$(CONFIG_ZSTD_DECOMPRESS),yy)
-	zstd_decompress-y += entropy_common.o fse_decompress.o zstd_common.o
-endif
+zstd_compress-y := fse_compress.o huf_compress.o compress.o \
+		   entropy_common.o fse_decompress.o zstd_common.o
+zstd_decompress-y := huf_decompress.o decompress.o \
+		     entropy_common.o fse_decompress.o zstd_common.o
-- 
2.7.4
