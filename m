Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeEaTWU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:22:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44267 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754030AbeEaTWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:22:14 -0400
X-Google-Smtp-Source: ADUXVKJ0QPDU9pr589Mai5IJUmvhoNhBMZqs1xa2iRNRWEorWfBhTTedF2tyz05ii1OsPClUf2ngpA==
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alexander.kapshuk@gmail.com
Subject: [PATCH 1/2] ver_linux: Process input coming from procmaps that matches libc only
Date: Thu, 31 May 2018 22:22:46 +0300
Message-Id: <20180531192247.9003-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, input coming from /proc/self/maps is split into fields without
checking whether or not it matches libc.so. This is not efficient.
All text processing should only be performed on lines of input that
match libc.so.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 scripts/ver_linux | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 7227994ccf63..e1dc041f903f 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -32,11 +32,13 @@ BEGIN {
 	printversion("Nfs-utils", version("showmount --version"))
 
 	while (getline <"/proc/self/maps" > 0) {
-		n = split($0, procmaps, "/")
-		if (/libc.*so$/ && match(procmaps[n], /[0-9]+([.]?[0-9]+)+/)) {
-			ver = substr(procmaps[n], RSTART, RLENGTH)
-			printversion("Linux C Library", ver)
-			break
+		if (/libc.*\.so$/) {
+			n = split($0, procmaps, "/")
+			if (match(procmaps[n], /[0-9]+([.]?[0-9]+)+/)) {
+				ver = substr(procmaps[n], RSTART, RLENGTH)
+				printversion("Linux C Library", ver)
+				break
+			}
 		}
 	}
 
-- 
2.17.1
