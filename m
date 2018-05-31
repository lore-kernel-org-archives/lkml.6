Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeEaTWX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:22:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43828 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754050AbeEaTWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:22:15 -0400
X-Google-Smtp-Source: ADUXVKLa/FB11hLHeLxgWYc9BO9MnMMpvLBTuB1O8PIGHRe90pUAG6LeDaW/oWn36acPyVD1GCQLAg==
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alexander.kapshuk@gmail.com
Subject: [PATCH 2/2] ver_linux: Do not check for ver_linux pattern in version function
Date: Thu, 31 May 2018 22:22:47 +0300
Message-Id: <20180531192247.9003-2-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180531192247.9003-1-alexander.kapshuk@gmail.com>
References: <20180531192247.9003-1-alexander.kapshuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking whether output of commands matches the ver_linux pattern in
the version function is original shell implementation legacy code. When
the original implementation failed to locate a particular utility,
it generated error output along the lines of:

ver_linux:line number: command not found.

The awk implementation, does not contain the name of the script within the
body of the error message returned by the subshell when a given utility
fails to be located. The error message returned is along the lines of:

sh: name of utility: command not found

Safeguarding against the ver_linux pattern being found in the output
being parsed may thus be safely omitted.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 scripts/ver_linux | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index e1dc041f903f..a6c728db05ce 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -70,7 +70,7 @@ BEGIN {
 function version(cmd,    ver) {
 	cmd = cmd " 2>&1"
 	while (cmd | getline > 0) {
-		if (!/ver_linux/ && match($0, /[0-9]+([.]?[0-9]+)+/)) {
+		if (match($0, /[0-9]+([.]?[0-9]+)+/)) {
 			ver = substr($0, RSTART, RLENGTH)
 			break
 		}
-- 
2.17.1
