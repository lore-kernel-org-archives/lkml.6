Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeDHUVo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752806AbeDHUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4CA21856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201835.403053050@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 13/23] ktest.pl: Detect if a config-bisect was interrupted
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0013-ktest.pl-Detect-if-a-config-bisect-was-interrupted.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a config-bisect was interrupted, then allow the user to continue, or
restart a new config-bisect.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index e04422d8f844..d4b22b5c425b 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -3215,6 +3215,20 @@ sub config_bisect {
     my %bad_configs;
     my %tmp_configs;
 
+    if (-f "$tmpdir/good_config.tmp" || -f "$tmpdir/bad_config.tmp") {
+	if (read_yn "Interrupted config-bisect. Continue (n - will start new)?") {
+	    if (-f "$tmpdir/good_config.tmp") {
+		$good_config = "$tmpdir/good_config.tmp";
+	    } else {
+		$good_config = "$tmpdir/good_config";
+	    }
+	    if (-f "$tmpdir/bad_config.tmp") {
+		$bad_config = "$tmpdir/bad_config.tmp";
+	    } else {
+		$bad_config = "$tmpdir/bad_config";
+	    }
+	}
+    }
     doprint "Run good configs through make oldconfig\n";
     assign_configs \%tmp_configs, $good_config;
     create_config "$good_config", \%tmp_configs;
-- 
2.16.3
