Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A08A2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfBTQNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:13:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58214 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:13:42 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gwUVA-0007xa-P1
        for linux-kernel@vger.kernel.org; Wed, 20 Feb 2019 16:13:40 +0000
Received: by mail-wr1-f72.google.com with SMTP id z16so5626392wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=est5SEaXnoCDsneSXFSYSOEklQW0Agf+4DU6KB/sNXk=;
        b=i4ESQvS6dqRfurQMBLnZF1lHzjX0IUTteQhjWBTe5QrDK2L+PRJ0E4JTVJHeIS0HEA
         6rbuMW3x4mIw4P0Ufh2RlhGg/gh9mPWC+E+Qu8W3ceL2EUyn8NHd4z5gvKTrWeykY9bv
         TDz1XDs1zH247iwLz9NPuMOFsDBjwGgd4AUZu4/849zqMdmlRXFQJ7zfsSuEYOifxYpT
         EfYOi3qvs4cc4tptD2KYXf97MiwEGdbqCFaemZzUcH8ss+8uKPjx/1H7Pn3clX4CZ+cK
         N3G7FfrblHHTGB3EZTcr0/hMCmyTsoKxGHQSN1CE29sxWYpWLBDbBg50rnw1ndOsRcKQ
         dfiw==
X-Gm-Message-State: AHQUAubJRVdh7tIRqrL6473A3MfFmC7WP6oOOiOOVmcBD12mskhPOpCv
        FL+vuy9OFmB2mP2Zk8C2f06OphIzi6GnBHDCZVZkESfXoChxFEzOgPFcK89PAUuCnU6jXutUguj
        XWhmckAMp969JvmjtD2NizFgb9WcqnWwG71nWkqBCaQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr26795343wrv.126.1550679220168;
        Wed, 20 Feb 2019 08:13:40 -0800 (PST)
X-Google-Smtp-Source: AHgI3IY8f1VBp0tEVXqUlhnMyJESyQ+CmIL1aJT6ZCpA9ONG58ifAjkEvVfSe41ThhG7IPbuYhydOQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr26795327wrv.126.1550679219940;
        Wed, 20 Feb 2019 08:13:39 -0800 (PST)
Received: from localhost.localdomain ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id h126sm8875472wmf.2.2019.02.20.08.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 08:13:39 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] selftests/ftrace: Make the coloring POSIX compliant
Date:   Wed, 20 Feb 2019 17:13:33 +0100
Message-Id: <20190220161333.28109-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

echo -e and \e are not POSIX. Depending on what /bin/sh is, we can get
incorrect output like:
$ -e -n [1] Basic trace file check
$ -e 	[PASS]

Fix that by using \033 instead of \e and printf.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index fc755e1b50f1..f200898e3e2c 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -161,10 +161,10 @@ color_green=
 color_blue=
 # If stdout exists and number of colors is eight or more, use them
 if [ -t 1 -a "$ncolors" -ge 8 ]; then
-  color_reset="\e[0m"
-  color_red="\e[31m"
-  color_green="\e[32m"
-  color_blue="\e[34m"
+  color_reset="\033[0m"
+  color_red="\033[31m"
+  color_green="\033[32m"
+  color_blue="\033[34m"
 fi
 
 strip_esc() {
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
+  printf "$@$newline"
+  [ "$LOG_FILE" ] && printf "$@$newline" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
   cat $1
-- 
2.19.1

