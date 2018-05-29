Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932650AbeE2Jrt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:47:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbeE2JrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:47:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ian Kent <raven@themaw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] autofs: make autofs4 and autofs mutually exclusive
Date: Tue, 29 May 2018 11:46:46 +0200
Message-Id: <20180529094702.4092022-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:8zubNtgJPbkXhppajW2G370/zfQ9oZTkPMkWbjoMT85xL4baU0F
 VFitAGm0/1lNsZfHTjISi0s7AUZ2GGr9+ZEXXvmGJZYAx9XesoVmf61VprU8+bOmpA4kSrd
 qffusj0VC3R0r4jWPiuIM+P04hWPhUUr07bJnCV4YomCUuSBSdXQA1WZ3PEV5JLR3eLBVUA
 d1hqHFjAA0TiOR9NwAioA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NF5vkWHDBvQ=:9zDNOTHffp7QupHbmu56PM
 xp2TYwVz3BiARoT9GPGToOJ01dhbXrzPbzM8B2guVgraGYfi7AZHpA+0fo+SCpjyrPYMOsaEw
 TwaD5CaaWoJ4yzD2ZuPDksp/1muykGGKhN0+zAefRcU+SS7wRjqnxrze0UmxSnbpMr8GRK7mo
 ULMG4FPI/d/uua1PNfIgRl/XV3+VLjJ4y/M0uAWtXp4+g5TF5KwubxH3e6LvB3DVyD6+D0qir
 AeM9c2hlnLHGbWcm17a2NnznwycAhWDas5BYSoVllx5FHA2XX6QqGQf8zfOVO1F2TP7tr33Yi
 /seRCXMmy6PjQelIZmiRwiiKTRnVVEeOipFjcPGMRrZ0ZEBjuocBNv7F8a4ShAdAV4EZngxix
 HMo5kCG7G2gB0ljM6BrjsukDnVssCEAfd1cqjkyS8oesHJ8XD9URmmognHhmHkDjv1moL2m23
 5faa/CoRavl0F1vrnOWsvST/aL+MPc9Z0m5C3aq7RwzHUfg9/MrPOo+0KT2wRel2IfXl0++3f
 2FIlgTb6UoyUoHTBynol9ohI0yAC92pUr/GOv5f9jETrvfZmXcg8GOgBjcBAFGuQkrbFFId2X
 439MpPsFBgJDr7uWhBJePAZBk/d7jSBqaRi/RlCli0fuiqAYTCiY+8jYThI+u94ctEcZUZ/CZ
 QhftqmYu/KP9oY8FDP6eViNUoGZvuWnJS39Ew6FQ2U90WG3LUBM0NDM95slRnhFct1Dk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The autofs4 implementation is just a redirect to autofs now, but that
also means we can't have both built into the same kernel:

fs/autofs/inode.o: In function `autofs_new_ino':
inode.c:(.text+0x1b8): multiple definition of `autofs_new_ino'
fs/autofs/inode.o:inode.c:(.text+0x1b8): first defined here
fs/autofs/inode.o: In function `autofs_clean_ino':
inode.c:(.text+0x288): multiple definition of `autofs_clean_ino'

There is also a problem with trying to build both in parallel, which
leads to two 'make' processes writing to the same fs/autofs/.*.o.cmd
file, causing corruption that manifests like

fs/autofs4/../autofs/.expire.o.cmd:679: *** missing separator.  Stop.

Making AUTOFS4_FS depend on AUTOFS_FS being disabled should avoid all
configurations that run into either issue.

Fixes: mmotm ("autofs: update fs/autofs4/Makefile")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/autofs4/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 53bc592a250d..eccf673c6c8c 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -1,5 +1,6 @@
 config AUTOFS4_FS
 	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
+	depends on AUTOFS_FS=n
 	default n
 	help
 	  The automounter is a tool to automatically mount remote file systems
-- 
2.9.0
