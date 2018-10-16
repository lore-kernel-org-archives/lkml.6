Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C939DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D22205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmAZyL/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D22205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJQAyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:54:16 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39730 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeJQAyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:54:15 -0400
Received: by mail-yw1-f65.google.com with SMTP id v1-v6so9197673ywv.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaPTae517Y+bNpef4yQIvFQgsgdIAhxr/JzYA1ji4RE=;
        b=fmAZyL/XuhaSR2b0tAZm1ewvTSsWICZRbQWOkl85bVnbDxw0cff6TSdw54wgOcAnXN
         +Ey7/unYVeqNSTZBIbHYGaTypTyXZnx+cPl2seqtb4KxIrsMdSa+FC/nBV8tQnKqn52F
         TYm2LhLxClitrtIVeThsNkRG8m4w/kX28dl4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaPTae517Y+bNpef4yQIvFQgsgdIAhxr/JzYA1ji4RE=;
        b=P/VjB4tInio/t/PgmNyDelyy3NIoNCkLsmBJ6co/8Jmg+icQushQ48H7l+7A8EZyVQ
         Zm9Tys0OGG/5Sx2XfCnuCjV8yDOKxJ1AdgRrhbnizLAO6pe5siWDgiP4spxKd+ulkVXn
         k5KDsqDhxVJtcWLlnu3bYVJLiiSGTVupTh8yjnRv9qTP4EE+ro5+6YaqGHgc3qh9gmDW
         FvMNiVjEiYwZZbxJdM2Iz8YaXglAy4MvMNNlSyHlIi9SXb/oCIWqeE0IJbl3+XA+qBAs
         GJcYkQOrdWcd6SHxalM18NJ4TpGTR8ltaJMh0y7fOE0v90uvxMX8pjFVhO9efsSIvf1Z
         bEOg==
X-Gm-Message-State: ABuFfohU8ZMCv0trp27JcPcPD+a644DiEJfGFoYAVeM4useSuaZ/OGzq
        fc1NrUeuENujXIIEexr/TdoQcQ==
X-Google-Smtp-Source: ACcGV63Owz/bC1n1lNE4SmpSEXBNZ8/AnuA0FhxlN61PoEKxSUUBapLfckn1EmpfHJWWGdJimbgE4A==
X-Received: by 2002:a0d:fe07:: with SMTP id o7-v6mr9730237ywf.379.1539709374895;
        Tue, 16 Oct 2018 10:02:54 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-187-161-144-121.PCs.InterCable.net. [187.161.144.121])
        by smtp.googlemail.com with ESMTPSA id r8-v6sm5049384ywa.56.2018.10.16.10.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 10:02:53 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/ftrace: Use colored output when available
Date:   Tue, 16 Oct 2018 12:02:20 -0500
Message-Id: <20181016170220.31156-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If test is being directly executed (with stdout opened on the
terminal) and the terminal capabilities indicate enough
colors, then use the existing scheme of green, red, and blue
to show when tests pass, fail or end in a different way.

When running the tests redirecting the stdout, for instance,
to a file, then colors are not shown, thus producing a more
readable output.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/ftrace/ftracetest | 29 +++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 4946b2edfcff..d987bbec675f 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -152,6 +152,21 @@ else
   date > $LOG_FILE
 fi
 
+# Define text colors
+# Check available colors on the terminal, if any
+ncolors=`tput colors 2>/dev/null`
+color_reset=
+color_red=
+color_green=
+color_blue=
+# If stdout exists and number of colors is eight or more, use them
+if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
+  color_reset="\e[0m"
+  color_red="\e[31m"
+  color_green="\e[32m"
+  color_blue="\e[34m"
+fi
+
 prlog() { # messages
   [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | tee -a $LOG_FILE
 }
@@ -195,37 +210,37 @@ test_on_instance() { # testfile
 eval_result() { # sigval
   case $1 in
     $PASS)
-      prlog "	[\e[32mPASS\e[30m]"
+      prlog "	[${color_green}PASS${color_reset}]"
       PASSED_CASES="$PASSED_CASES $CASENO"
       return 0
     ;;
     $FAIL)
-      prlog "	[\e[31mFAIL\e[30m]"
+      prlog "	[${color_red}FAIL${color_reset}]"
       FAILED_CASES="$FAILED_CASES $CASENO"
       return 1 # this is a bug.
     ;;
     $UNRESOLVED)
-      prlog "	[\e[34mUNRESOLVED\e[30m]"
+      prlog "	[${color_blue}UNRESOLVED${color_reset}]"
       UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
       return 1 # this is a kind of bug.. something happened.
     ;;
     $UNTESTED)
-      prlog "	[\e[34mUNTESTED\e[30m]"
+      prlog "	[${color_blue}UNTESTED${color_reset}]"
       UNTESTED_CASES="$UNTESTED_CASES $CASENO"
       return 0
     ;;
     $UNSUPPORTED)
-      prlog "	[\e[34mUNSUPPORTED\e[30m]"
+      prlog "	[${color_blue}UNSUPPORTED${color_reset}]"
       UNSUPPORTED_CASES="$UNSUPPORTED_CASES $CASENO"
       return $UNSUPPORTED_RESULT # depends on use case
     ;;
     $XFAIL)
-      prlog "	[\e[31mXFAIL\e[30m]"
+      prlog "	[${color_red}XFAIL${color_reset}]"
       XFAILED_CASES="$XFAILED_CASES $CASENO"
       return 0
     ;;
     *)
-      prlog "	[\e[34mUNDEFINED\e[30m]"
+      prlog "	[${color_blue}UNDEFINED${color_reset}]"
       UNDEFINED_CASES="$UNDEFINED_CASES $CASENO"
       return 1 # this must be a test bug
     ;;
-- 
2.17.1

