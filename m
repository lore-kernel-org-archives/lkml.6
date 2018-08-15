Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F2C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EDD216ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kQdQhrX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EDD216ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeHOIwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:52:08 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:54026 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeHOIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:52:08 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w7F5xsZi013655;
        Wed, 15 Aug 2018 14:59:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w7F5xsZi013655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534312794;
        bh=oULS+0WXiytoM/CiXvb0+OtUros6tp5B9Xh7Pk6/W0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=kQdQhrX+SEpT+1rjBaFTkkL8rxuHhfHq8wJ4ojJ6/C81mxE63L2M0HiOeKcyr3bO8
         OzooqJbz4EiR8W3xm7O4O3eneT3JpPBLchjb3ehV0BNgmpkdsuQK3GAqWb3i2KHkPG
         xukfE2v1RaB6egch/rA1dBEf88QvyhaT/DdsrQGm+AObUDe7Wqnm9dS6lNeN1VcGts
         IgSgOdmUfe3RkFzpMFQBbJ/N73z7QsYZOBTPS0/ol2IyhORRxY0lInkh5G0BGXJ/az
         Fmshwf0CmX53DOyRwWZcsm4rlIPZVUKIUup/xtjsSA3aWg7Q8WucgPR/s5vO90ErI6
         O9NBMYmZRU+3Q==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] kconfig: error out when seeing recursive dependency
Date:   Wed, 15 Aug 2018 14:59:43 +0900
Message-Id: <1534312785-28434-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, recursive dependency was a fatal error for Kconfig
because Kconfig cannot compute symbol values in such a situation.

Commit d595cea62403 ("kconfig: print more info when we see a recursive
dependency") changed it to a warning, which I guess was not intentional.

Get it back to an error again.

Also, rename the unit test directory "warn_recursive_dep" to
"err_recursive_dep" so that it matches to the behavior.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Newly added

 scripts/kconfig/symbol.c                                       |  3 ---
 .../tests/{warn_recursive_dep => err_recursive_dep}/Kconfig    |  0
 scripts/kconfig/tests/err_recursive_dep/__init__.py            | 10 ++++++++++
 .../{warn_recursive_dep => err_recursive_dep}/expected_stderr  |  0
 scripts/kconfig/tests/warn_recursive_dep/__init__.py           |  9 ---------
 5 files changed, 10 insertions(+), 12 deletions(-)
 rename scripts/kconfig/tests/{warn_recursive_dep => err_recursive_dep}/Kconfig (100%)
 create mode 100644 scripts/kconfig/tests/err_recursive_dep/__init__.py
 rename scripts/kconfig/tests/{warn_recursive_dep => err_recursive_dep}/expected_stderr (100%)
 delete mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 4ec8b1f..688f487 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1248,9 +1248,6 @@ struct symbol *sym_check_deps(struct symbol *sym)
 		sym->flags &= ~SYMBOL_CHECK;
 	}
 
-	if (sym2 && sym2 == sym)
-		sym2 = NULL;
-
 	return sym2;
 }
 
diff --git a/scripts/kconfig/tests/warn_recursive_dep/Kconfig b/scripts/kconfig/tests/err_recursive_dep/Kconfig
similarity index 100%
rename from scripts/kconfig/tests/warn_recursive_dep/Kconfig
rename to scripts/kconfig/tests/err_recursive_dep/Kconfig
diff --git a/scripts/kconfig/tests/err_recursive_dep/__init__.py b/scripts/kconfig/tests/err_recursive_dep/__init__.py
new file mode 100644
index 0000000..5f3821b
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_dep/__init__.py
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+Detect recursive dependency error.
+
+Recursive dependency should be treated as an error.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 1
+    assert conf.stderr_contains('expected_stderr')
diff --git a/scripts/kconfig/tests/warn_recursive_dep/expected_stderr b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
similarity index 100%
rename from scripts/kconfig/tests/warn_recursive_dep/expected_stderr
rename to scripts/kconfig/tests/err_recursive_dep/expected_stderr
diff --git a/scripts/kconfig/tests/warn_recursive_dep/__init__.py b/scripts/kconfig/tests/warn_recursive_dep/__init__.py
deleted file mode 100644
index adb2195..0000000
--- a/scripts/kconfig/tests/warn_recursive_dep/__init__.py
+++ /dev/null
@@ -1,9 +0,0 @@
-"""
-Warn recursive inclusion.
-
-Recursive dependency should be warned.
-"""
-
-def test(conf):
-    assert conf.oldaskconfig() == 0
-    assert conf.stderr_contains('expected_stderr')
-- 
2.7.4

