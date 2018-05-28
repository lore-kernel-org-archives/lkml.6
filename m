Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164983AbeE1LER (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164721AbeE1LEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:04:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 495/496] kdb: make "mdr" command repeat
Date: Mon, 28 May 2018 12:04:40 +0200
Message-Id: <20180528100340.741286876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 1e0ce03bf142454f38a5fc050bf4fd698d2d36d8 ]

The "mdr" command should repeat (continue) when only Enter/Return
is pressed, so make it do so.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/debug/kdb/kdb_main.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1566,6 +1566,7 @@ static int kdb_md(int argc, const char *
 	int symbolic = 0;
 	int valid = 0;
 	int phys = 0;
+	int raw = 0;
 
 	kdbgetintenv("MDCOUNT", &mdcount);
 	kdbgetintenv("RADIX", &radix);
@@ -1575,9 +1576,10 @@ static int kdb_md(int argc, const char *
 	repeat = mdcount * 16 / bytesperword;
 
 	if (strcmp(argv[0], "mdr") == 0) {
-		if (argc != 2)
+		if (argc == 2 || (argc == 0 && last_addr != 0))
+			valid = raw = 1;
+		else
 			return KDB_ARGCOUNT;
-		valid = 1;
 	} else if (isdigit(argv[0][2])) {
 		bytesperword = (int)(argv[0][2] - '0');
 		if (bytesperword == 0) {
@@ -1613,7 +1615,10 @@ static int kdb_md(int argc, const char *
 		radix = last_radix;
 		bytesperword = last_bytesperword;
 		repeat = last_repeat;
-		mdcount = ((repeat * bytesperword) + 15) / 16;
+		if (raw)
+			mdcount = repeat;
+		else
+			mdcount = ((repeat * bytesperword) + 15) / 16;
 	}
 
 	if (argc) {
@@ -1630,7 +1635,10 @@ static int kdb_md(int argc, const char *
 			diag = kdbgetularg(argv[nextarg], &val);
 			if (!diag) {
 				mdcount = (int) val;
-				repeat = mdcount * 16 / bytesperword;
+				if (raw)
+					repeat = mdcount;
+				else
+					repeat = mdcount * 16 / bytesperword;
 			}
 		}
 		if (argc >= nextarg+1) {
@@ -1640,8 +1648,15 @@ static int kdb_md(int argc, const char *
 		}
 	}
 
-	if (strcmp(argv[0], "mdr") == 0)
-		return kdb_mdr(addr, mdcount);
+	if (strcmp(argv[0], "mdr") == 0) {
+		int ret;
+		last_addr = addr;
+		ret = kdb_mdr(addr, mdcount);
+		last_addr += mdcount;
+		last_repeat = mdcount;
+		last_bytesperword = bytesperword; // to make REPEAT happy
+		return ret;
+	}
 
 	switch (radix) {
 	case 10:
