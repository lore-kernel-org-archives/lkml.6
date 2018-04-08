Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeDHUWy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752616AbeDHUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B89821840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201833.978612109@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 05/23] ktest: Set buildonly=1 for CONFIG_BISECT_TYPE=build
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-ktest-Set-buildonly-1-for-CONFIG_BISECT_TYPE-build.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

Rather than adding a third copy of the same logic, rework it to cover
all three buildonly cases at once.

In the future, please consider using the same variable to perform the
same function regardless of context...

Link: http://lkml.kernel.org/r/20170717001630.10518-2-swood@redhat.com

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index c85a9f9342f4..80091dfbce4b 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -721,21 +721,13 @@ sub set_value {
 
     my $prvalue = process_variables($rvalue);
 
-    if ($buildonly && $lvalue =~ /^TEST_TYPE(\[.*\])?$/ && $prvalue ne "build") {
+    if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
+	$prvalue !~ /^(config_|)bisect$/ &&
+	$prvalue !~ /^build$/ &&
+	$buildonly) {
+
 	# Note if a test is something other than build, then we
 	# will need other mandatory options.
-	if ($prvalue ne "install") {
-	    # for bisect, we need to check BISECT_TYPE
-	    if ($prvalue ne "bisect") {
-		$buildonly = 0;
-	    }
-	} else {
-	    # install still limits some mandatory options.
-	    $buildonly = 2;
-	}
-    }
-
-    if ($buildonly && $lvalue =~ /^BISECT_TYPE(\[.*\])?$/ && $prvalue ne "build") {
 	if ($prvalue ne "install") {
 	    $buildonly = 0;
 	} else {
-- 
2.16.3
