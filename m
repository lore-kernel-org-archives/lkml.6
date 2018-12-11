Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B551DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCF02146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543741;
	bh=W5RneHxVSsiYOhkLM08PCTl5kHBRvLDGvily7oHi1xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gi1wcE0QLehjNbbnAE9aDBqv6odej0YtfYmFr2oya9um9ciNrXbopL3WAXzm9KPy5
	 srUl+4o4xCSzEf1WgGq4QNYDGmDx5RnUg2IG0u3rgFRC19FJOfcDksrj6j8KyLSfjZ
	 dblNrRxDXU+hn/vx+oJlJC8VWQBoq41U6FNvCs64=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCF02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbeLKPzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeLKPzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E97E208E7;
        Tue, 11 Dec 2018 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543734;
        bh=W5RneHxVSsiYOhkLM08PCTl5kHBRvLDGvily7oHi1xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vL3KvmdGu6zkG81tGJHtpV3rizjYb0niUB7cwLUtfQYtHy3RBG1Jv1o3ccM8QAcOR
         aY0YXWQj5roHFPMyJc/16RjrBdF0Hj/3l1otyclVcYGjnEU/o2HO0Mz3s5WGPXKTDC
         OxYyHnK3gB9D+GBCJpIGJiB0g0Cx+hR5Uvx1SSw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Brenda J. Butler" <bjb@mojatatu.com>,
        Lucas Bates <lucasb@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/118] tc-testing: tdc.py: Guard against lack of returncode in executed command
Date:   Tue, 11 Dec 2018 16:40:55 +0100
Message-Id: <20181211151645.696719666@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



