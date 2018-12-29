Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6202C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D4B20873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeL2SF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:05:58 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33036 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeL2SF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:05:58 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBTI5kUo015929;
        Sat, 29 Dec 2018 19:05:46 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     mingo@kernel.org, paulmck@linux.vnet.ibm.com, acme@redhat.com
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH] tools headers: move the nolibc header from rcutorture to tools/include/nolibc/
Date:   Sat, 29 Dec 2018 19:04:53 +0100
Message-Id: <20181229180453.15889-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Ingo, this header file might benefit other tools than
just rcutorture. For now it's quite limited, but is easy to extend, so
exposing it into tools/include/nolibc/ will make it much easier to
adopt by other tools.

The mkinitrd.sh script in rcutorture was updated to use this new location.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/{testing/selftests/rcutorture/bin => include/nolibc}/nolibc.h | 0
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh                  | 4 ++--
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/{testing/selftests/rcutorture/bin => include/nolibc}/nolibc.h (100%)

diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/include/nolibc/nolibc.h
similarity index 100%
rename from tools/testing/selftests/rcutorture/bin/nolibc.h
rename to tools/include/nolibc/nolibc.h
diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index da29839..d93bca1 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -124,8 +124,8 @@ if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
    | grep -q '^yes'; then
 	# architecture supported by nolibc
         ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
-		-nostdlib -include ../bin/nolibc.h -lgcc -s -static -Os \
-		-o init init.c
+		-nostdlib -include ../../../../include/nolibc/nolibc.h \
+		-lgcc -s -static -Os -o init init.c
 else
 	${CROSS_COMPILE}gcc -s -static -Os -o init init.c
 fi
-- 
2.9.0

