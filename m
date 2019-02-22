Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77335206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBVUwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:52:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35293 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfBVUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:52:53 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxHoR-0000Ce-ML
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 20:52:51 +0000
Received: by mail-wr1-f71.google.com with SMTP id p3so1499495wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRPeMIi4WkzlI/wi4uTphGWN+IH4+mQk5AY4oH1wsVE=;
        b=BxRZg2Rf1Qd5AuvNI6qSYMG2o6a5mn3XAYy2/2DSXAFI2ngAfJ70Ps7Sscn93qra3e
         i3Es4XYeqFRSraeJC96hsvGzL+XhsbdL1NUQRAtG+0W62I5OdYO+fTU7jQZQjDtfm7t9
         4544NgAdOr6QEvrHe3iIhXrYlQIQiVv0XIq0yibnDmBx9iiIatFbjl/+XRtOHJS3CKuz
         0cznnaDWsnAJgSC3xUeAZY/YXse40m2JVdYlhKzgVWdTTB5mzXjnh8LiiYpiYLRo/fbq
         09oBWqSLOTJOOrkj2E5+XbOJckivu15K8Jmrjnx2rUtNMZ6t6Te536I/2dS8f/SYsQLj
         Gliw==
X-Gm-Message-State: AHQUAuYgv7o732hfnbu/zxVkCnEQStB9VKIGq1GzxHL21OVHR3Q52H9n
        4901V6slawMuP/DLXyFsDW6IhPC9tiHehmGmY1dWE8z2PB90QeFpsJDZQTlSF0KVJj8iM+cXWJF
        Bt0Lj/8OAjEJQN4JsCp/mniFNI9o8tsfYaVi9qDVpJg==
X-Received: by 2002:adf:b784:: with SMTP id s4mr4211390wre.155.1550868771083;
        Fri, 22 Feb 2019 12:52:51 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZKVQO7O6v9cZu7nhampuKrCQjuiHxVea5LaqBvtfHabeEiaiDBC8lla/WHHa37nb2BOlK0Jg==
X-Received: by 2002:adf:b784:: with SMTP id s4mr4211379wre.155.1550868770882;
        Fri, 22 Feb 2019 12:52:50 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id a8sm1728962wrt.79.2019.02.22.12.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:52:50 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH v2 1/2] selftests/ftrace: Replace echo -e with printf
Date:   Fri, 22 Feb 2019 21:52:36 +0100
Message-Id: <20190222205237.606-2-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222205237.606-1-juergh@canonical.com>
References: <20190222091021.10178-1-juergh@canonical.com>
 <20190222205237.606-1-juergh@canonical.com>
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

