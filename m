Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A56F2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfBVUxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:53:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35315 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfBVUx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:53:29 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxHp1-0000GY-RK
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 20:53:27 +0000
Received: by mail-wr1-f69.google.com with SMTP id l5so1520380wrv.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRPeMIi4WkzlI/wi4uTphGWN+IH4+mQk5AY4oH1wsVE=;
        b=OKBiGGe/VXn2UPzVr5i+2mvHQZa3QMfIlhuY1auV0ZA5Kjg/CjH9u6ZD4KeloiPO/F
         SVlkfiaXJEWC4ltH+tZj5Dz+LmKDX3q/ULTA1P8V+BdridAKE7JfWawkGjZjwfiwV5Ds
         201UzEDqpNHbUZAV1BBRDez3u9VJAWR8U74Ui0rVMWX9w7XJPRBvoza/7Z+JYiozlO0b
         b0Qn74TLdkTZartTeR6FQuBJRgZYi7o52fPWkNFczIHS1uulMtjVbpsgn7424K/sZr0s
         DxQGKyOw+oDOHC9t7DS/aabe7ed5h+FF/d2CHbbD3YVnzOjrZZOX0GsokN0ix/tw+LYU
         K+kw==
X-Gm-Message-State: AHQUAuaz+xMmxJwM+8eTeQdJXWqQ1l29MJQT/rlQhS/wFzu58j85kzG4
        1Q8JTrPGvNLIP+JpQENdufELK04z/yMSSl911UlAInlWbzOJS3OWUapImae4iTv0zGNpvwkzbBq
        6JMqIIXLaIKCLIUSpD7nsyJUqaymFjpunxcb2p+q2eg==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr3702565wmj.120.1550868807207;
        Fri, 22 Feb 2019 12:53:27 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZepvi3VNA/NU7AjnkyjppU7VKKqkVpYuGuJN+EhEMcS9x9Mb3M0gVevz0RbthiPOwqBN2T6Q==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr3702561wmj.120.1550868807085;
        Fri, 22 Feb 2019 12:53:27 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id j124sm2514415wmb.48.2019.02.22.12.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:53:26 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH v2 1/2] selftests/ftrace: Replace echo -e with printf
Date:   Fri, 22 Feb 2019 21:53:17 +0100
Message-Id: <20190222205318.689-2-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222205318.689-1-juergh@canonical.com>
References: <20190222091021.10178-1-juergh@canonical.com>
 <20190222205318.689-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

echo -e is not POSIX. Depending on what /bin/sh is, we can get
incorrect output like:
$ -e -n [1] Basic trace file check
$ -e 	[PASS]

Fix that by using printf instead.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index fc755e1b50f1..20c9c0ad8682 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -173,8 +173,13 @@ strip_esc() {
 }
 
 prlog() { # messages
-  echo -e "$@"
-  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
+  newline="\n"
+  if [ "$1" = "-n" ] ; then
+    newline=
+    shift
+  fi
+  printf "$*$newline"
+  [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
   cat $1
-- 
2.19.1

