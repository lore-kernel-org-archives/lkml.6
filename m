Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5DC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487F625828
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487F625828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030331AbeGASBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:01:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030321AbeGAQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5FECF92B;
        Sun,  1 Jul 2018 16:30:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 024/157] ftrace/selftest: Have the reset_trigger code be a bit more careful
Date:   Sun,  1 Jul 2018 18:21:36 +0200
Message-Id: <20180701160853.468687043@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 756b56a9e832e063edc83be7c3889e98c536dd2b upstream.

The trigger code is picky in how it can be disabled as there may be
dependencies between different events and synthetic events. Change the order
on how triggers are reset.

 1) Reset triggers of all synthetic events first
 2) Remove triggers with actions attached to them
 3) Remove all other triggers

If this order isn't followed, then some triggers will not be reset, and an
error may happen because a trigger is busy.

Cc: stable@vger.kernel.org
Fixes: cfa0963dc474f ("kselftests/ftrace : Add event trigger testcases")
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/ftrace/test.d/functions |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -15,14 +15,29 @@ reset_tracer() { # reset the current tra
     echo nop > current_tracer
 }
 
-reset_trigger() { # reset all current setting triggers
-    grep -v ^# events/*/*/trigger |
+reset_trigger_file() {
+    # remove action triggers first
+    grep -H ':on[^:]*(' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+    grep -Hv ^# $@ |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
-	echo "!$cmd" > `echo $line | cut -f1 -d:`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" > $file
     done
 }
 
+reset_trigger() { # reset all current setting triggers
+    if [ -d events/synthetic ]; then
+        reset_trigger_file events/synthetic/*/trigger
+    fi
+    reset_trigger_file events/*/*/trigger
+}
+
 reset_events_filter() { # reset all current setting filters
     grep -v ^none events/*/*/filter |
     while read line; do


