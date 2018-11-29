Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C3EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885BD208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTHmjsSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885BD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeK2RDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeK2RDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:13 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016A621019;
        Thu, 29 Nov 2018 05:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471142;
        bh=FLPv6N3d8dgB5oJyDU+vYBVfl41Ct1O16N/X+WZAHrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTHmjsSzvhAB3winDQs8Fhv58Wb8XTC9rx7yf7LbfijSZUIvtHE892CEzJjo4wBUj
         bJtg5OGAPs03ysf6QYw/T5OSsTKEgX2QRcgY9b1WhagNwkVSZsEMtbT97LTFDvDdQh
         YttkpEwAgf6Tj8+FjgtooDL8tWmRyuPIfTlpsmIo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Brenda J. Butler" <bjb@mojatatu.com>,
        Lucas Bates <lucasb@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/68] tc-testing: tdc.py: Guard against lack of returncode in executed command
Date:   Thu, 29 Nov 2018 00:55:27 -0500
Message-Id: <20181129055559.159228-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Brenda J. Butler" <bjb@mojatatu.com>

[ Upstream commit c6cecf4ae44e4ce9158ef8806358142c3512cd33 ]

Add some defensive coding in case one of the subprocesses created by tdc
returns nothing. If no object is returned from exec_cmd, then tdc will
halt with an unhandled exception.

Signed-off-by: Brenda J. Butler <bjb@mojatatu.com>
Signed-off-by: Lucas Bates <lucasb@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/tc-testing/tdc.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 9b3f414ff1e9..7607ba3e3cbe 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -169,6 +169,8 @@ def prepare_env(args, pm, stage, prefix, cmdlist, output = None):
                   file=sys.stderr)
             print("\n{} *** Error message: \"{}\"".format(prefix, foutput),
                   file=sys.stderr)
+            print("returncode {}; expected {}".format(proc.returncode,
+                                                      exit_codes))
             print("\n{} *** Aborting test run.".format(prefix), file=sys.stderr)
             print("\n\n{} *** stdout ***".format(proc.stdout), file=sys.stderr)
             print("\n\n{} *** stderr ***".format(proc.stderr), file=sys.stderr)
@@ -195,12 +197,18 @@ def run_one_test(pm, args, index, tidx):
         print('-----> execute stage')
     pm.call_pre_execute()
     (p, procout) = exec_cmd(args, pm, 'execute', tidx["cmdUnderTest"])
-    exit_code = p.returncode
+    if p:
+        exit_code = p.returncode
+    else:
+        exit_code = None
+
     pm.call_post_execute()
 
-    if (exit_code != int(tidx["expExitCode"])):
+    if (exit_code is None or exit_code != int(tidx["expExitCode"])):
         result = False
-        print("exit:", exit_code, int(tidx["expExitCode"]))
+        print("exit: {!r}".format(exit_code))
+        print("exit: {}".format(int(tidx["expExitCode"])))
+        #print("exit: {!r} {}".format(exit_code, int(tidx["expExitCode"])))
         print(procout)
     else:
         if args.verbose > 0:
-- 
2.17.1

