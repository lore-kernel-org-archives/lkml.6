Return-Path: <alexander.kapshuk@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526115734; cv=none;
        d=google.com; s=arc-20160816;
        b=Mlbp0hGZHp8zq8+ow8EOrGiodU9bZfyCF9pw0tJrbZ0BnAIMDv+HNYPOx5fz7Hvl0C
         mYsQOq9Ldpq5OLU6L2f7R035oLlu43QXGKIthG33CbDHhZ0T2nXF3j9jcK1I5sr2mihM
         PRhm8kFICkhJ/bJwZ2ys8yk4x/8hQTpHM9HTmSnlwWhIkhyd47jO7OEsqQVNzIAtCDbE
         g3uuanawOiSVEKiSJbSYpfG++rbPg4DpTVnHZcxVpEcFTr9AkHcKSM2mtZIxdkLpIqIT
         4nIjaCWsh+onx8KDzjzSBnUjHeHG9RQ2xGdifM6deDWe7zI5EuMpytopkQtcCdHTExtK
         upmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vxAvgSrPGsPGmcM6OOCirwYKd7hibVem+uaK3F6PwBY=;
        b=cKtZ08eYruUMEJNw77OrGGSXCwqjudPyeTuwL0AJTW4dkPAEyoGYtwQWdtumv67baT
         bgwbeWtb8HjnH7Dadz0Wx4uv/6QXmgyfMUz75Xf+q8+mFLGJ9ngzFjhLA2uksLnX/cd/
         CwhFqVkzLqU0FpzRxtmtbRXwORfoG5I01pABdeFQfFyIskrpVgrURhxTWO1z5268u008
         r9QBramS9J7tQZsDy7JEkrReu/7SiNO/7Y2HuyKyOTBITypoQF4Cw6WyMGIslDx+21GR
         cX3kYbymDgE2Ek3q530fXOz74KyjtL7rck9rcyvcO999pEXsFVfHUsjE5FKpMdS7Sgrz
         KHCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=relG8ryi;
       spf=pass (google.com: domain of alexander.kapshuk@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexander.kapshuk@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=relG8ryi;
       spf=pass (google.com: domain of alexander.kapshuk@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexander.kapshuk@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrBoiBcPgkhRdAf9VDKlhDUfdXfH35JV3sBxWgj3DWEPCTCc/vJkbz5hibpPqNoFSBFcZDqHg==
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	alexander.kapshuk@gmail.com
Subject: [PATCH 2/2] ver_linux: Drop redundant calls to system() to test if file is readable
Date: Sat, 12 May 2018 12:02:31 +0300
Message-Id: <20180512090231.4596-2-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180512090231.4596-1-alexander.kapshuk@gmail.com>
References: <20180512090231.4596-1-alexander.kapshuk@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600248332967310294?=
X-GMAIL-MSGID: =?utf-8?q?1600248332967310294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Running 'test -r' on an awk variable name whose value is an empty
string results in test being run with no arguments, and causes system()
to return 0, which indicates success when used to test values returned
by function calls. This results in code within the if blocks being run
when it should not be.
Instead of testing if a file is accessible and readable via calls to
system("test -r " file), rely on the value returned by getline to perform
this kind of testing. Getline returns -1 on error, with the code within
the while loops not being run.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 scripts/ver_linux | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 0b301bd1637d..7227994ccf63 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -31,14 +31,12 @@ BEGIN {
 	printversion("Isdn4k-utils", version("isdnctrl"))
 	printversion("Nfs-utils", version("showmount --version"))
 
-	if (system("test -r /proc/self/maps") == 0) {
-		while (getline <"/proc/self/maps" > 0) {
-			n = split($0, procmaps, "/")
-			if (/libc.*so$/ && match(procmaps[n], /[0-9]+([.]?[0-9]+)+/)) {
-				ver = substr(procmaps[n], RSTART, RLENGTH)
-				printversion("Linux C Library", ver)
-				break
-			}
+	while (getline <"/proc/self/maps" > 0) {
+		n = split($0, procmaps, "/")
+		if (/libc.*so$/ && match(procmaps[n], /[0-9]+([.]?[0-9]+)+/)) {
+			ver = substr(procmaps[n], RSTART, RLENGTH)
+			printversion("Linux C Library", ver)
+			break
 		}
 	}
 
@@ -50,9 +48,7 @@ BEGIN {
 			break
 		}
 	}
-	if (system("test -r " libcpp) == 0)
-		printversion("Linux C++ Library", version("readlink " libcpp))
-
+	printversion("Linux C++ Library", version("readlink " libcpp))
 	printversion("Procps", version("ps --version"))
 	printversion("Net-tools", version("ifconfig --version"))
 	printversion("Kbd", version("loadkeys -V"))
@@ -62,13 +58,11 @@ BEGIN {
 	printversion("Udev", version("udevadm --version"))
 	printversion("Wireless-tools", version("iwconfig --version"))
 
-	if (system("test -r /proc/modules") == 0) {
-		while ("sort /proc/modules" | getline > 0) {
-			mods = mods sep $1
-			sep = " "
-		}
-		printversion("Modules Loaded", mods)
+	while ("sort /proc/modules" | getline > 0) {
+		mods = mods sep $1
+		sep = " "
 	}
+	printversion("Modules Loaded", mods)
 }
 
 function version(cmd,    ver) {
-- 
2.17.0
