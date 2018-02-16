Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbeBPUXk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:23:40 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40503 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeBPUXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:23:34 -0500
X-Google-Smtp-Source: AH8x224YSGC1ShDb4Zx/J/7MO8FSwIiNe/Ln1YAUHbAUb1hjCCORfaTzEtEJOfV2c1pnTA+F2gdUAA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: apw@canonical.com, joe@perches.com
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 3/3] checkpatch: kconfig: prefer 'help' over '---help---'
Date: Fri, 16 Feb 2018 21:22:55 +0100
Message-Id: <20180216202255.25307-4-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180216202255.25307-1-ulfalizer@gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMO, we should discourage '---help---' for new help texts, even in cases
where it would be consistent with other help texts in the file. This
will help if we ever want to get rid of '---help---' in the future.

Also simplify the code to only check for exactly '---help---'. Since
commit c2264564df3d ("kconfig: warn of unhandled characters in Kconfig
commands"), '---help---' is a proper keyword and can only appear in that
form. Prior to that commit, '---help---' working was more of a syntactic
quirk.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 scripts/checkpatch.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 54b782fab4fd..2784f6ab309f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2817,7 +2817,11 @@ sub process {
 
 				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
 					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
+				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
+					if ($lines[$ln - 1] =~ "---help---") {
+						WARN("CONFIG_DESCRIPTION",
+						     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
+					}
 					$length = -1;
 				}
 
-- 
2.14.1
