Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA042077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfBVJKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:10:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48498 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfBVJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:10:39 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gx6qs-0006R2-HM
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 09:10:38 +0000
Received: by mail-wr1-f71.google.com with SMTP id t7so732981wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JkEa9yqQoBXj1dgwBUf6tNBwAb6+AbdoaNKfGI3o5k=;
        b=CKCZJOSraBcT0L6qlH6jvf6C3UYa05dUB2Knvkj6CPLchuQ0PRg5nXsRd3zSY1eUDl
         krnVEiVCS87nD3s4AdiRVFM5oxU6AxsxtYswHph8lIw2MrBcmI8Ke1YQeIpMqRQOWcDk
         US2b5w8rwIUqqvoKo6PgS5u4krkgfhzWndwlkblTAr2yB+tDUKsljzlyrBaC/qKV3iWf
         c+xyIwy63m8IwAEyY3QuVGKMrlW/3GVxGWEdqyxBmtBJIUoTFa8vRwWO4dcQYrJL54rM
         JPIXST6asH3AR8yZ5TYM8FtZkKxAypgMyFH4POf5GkKqVbG+KDkfwy1xmDC0nnMbbUHE
         UpZQ==
X-Gm-Message-State: AHQUAubkOjqqJlR31q6WLQqoAJLvKUUSriZUqO4fdxo5t2F2zVwUj598
        BzUlXxuUvXVLpDOOiV0MzgqG3y817vL0I0xLa7QvzTQUGsOYB8H00KPqh5WMJwjEplc+hGWJTru
        NzfQ6H62XivjNUYQXcFjxkZEwcEkD8O+9GDmMbeqjSA==
X-Received: by 2002:adf:cc83:: with SMTP id p3mr2096368wrj.292.1550826637547;
        Fri, 22 Feb 2019 01:10:37 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZFsVs8xX9z7vWsK3QaklLm3dLOALLBW5JHIQOCXvxpdABkmEDBG6/BGPyYbkjG54LvC/eMzA==
X-Received: by 2002:adf:cc83:: with SMTP id p3mr2096358wrj.292.1550826637346;
        Fri, 22 Feb 2019 01:10:37 -0800 (PST)
Received: from localhost.localdomain ([194.204.107.10])
        by smtp.gmail.com with ESMTPSA id f126sm292559wmf.6.2019.02.22.01.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 01:10:36 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 1/2] selftests/ftrace: Replace echo -e with printf
Date:   Fri, 22 Feb 2019 10:10:20 +0100
Message-Id: <20190222091021.10178-2-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222091021.10178-1-juergh@canonical.com>
References: <20190220161333.28109-1-juergh@canonical.com>
 <20190222091021.10178-1-juergh@canonical.com>
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

