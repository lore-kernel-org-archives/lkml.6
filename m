Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C7B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBYNPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:15:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52926 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfBYNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:15:40 -0500
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gyG5y-0006ww-Sw
        for linux-kernel@vger.kernel.org; Mon, 25 Feb 2019 13:14:58 +0000
Received: by mail-ed1-f71.google.com with SMTP id h16so3888333edq.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 05:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05Pfz0VU4oe6f93buxQY9QkgqsOv1os77MxM6+gPtFA=;
        b=el+eZhHDFEkueJFrRPTZf35i3oqKs/FGBQ7U46HHcOliRmIZ5SrZMA/u95QaaxxJkW
         CPcasu9P+6UNuv+rsiGd/GaeZKZZmRufOvNnF7/6S46DlCRI1sRStabEQzXRlAg+vFbx
         c7ULoduw4HsJFnQVC4k5rkF0axiidFq/81w6trqxDSAwqiZP9kowcBxMK3IGfgVYXRzG
         UyFzosV6YEuOo8OzpyroOq2AzwncrmjspaokF4l6wazm7d4fkKODqOd7xie927vuzcvc
         fwRQ77HHjGLAoue4TLhUvnjUcGzUOe8zZFUcaWK/+Vu0ogDgQwsqGc5PM2MA++tPm8St
         SQ8A==
X-Gm-Message-State: AHQUAuYRGKjKogQzxYfipb2iFRwDGYU6CqCprtA0RNtFeCxG1nRUbjxE
        46XK4ViBDrDimDcRXMG6H/34OOg41xdkUA+06M61wo/PcAVhV7Dd8Aykd+JKM2rtOIy/zttgDZ+
        FSXCue0LGMmhk89dbubcLvkAj7stowQMdt3q+o5uQbg==
X-Received: by 2002:a50:b786:: with SMTP id h6mr14526772ede.85.1551100498505;
        Mon, 25 Feb 2019 05:14:58 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYkwy4pc0UTozk0rR2MjKf+t0Kb8Rj3JU9jOfxwpYicPej1v4ouavNIrrwqZsldMuzX+zcJgA==
X-Received: by 2002:a50:b786:: with SMTP id h6mr14526757ede.85.1551100498288;
        Mon, 25 Feb 2019 05:14:58 -0800 (PST)
Received: from gollum.fritz.box ([81.221.192.120])
        by smtp.gmail.com with ESMTPSA id b46sm2719464edd.18.2019.02.25.05.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 05:14:57 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     rostedt@goodmis.org, mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH] selftests/ftrace: Handle the absence of tput
Date:   Mon, 25 Feb 2019 14:14:50 +0100
Message-Id: <20190225131450.4775-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190220153706.24686-1-juergh@canonical.com>
References: <20190220153706.24686-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In environments where tput is not available, we get the following
error
$ ./ftracetest: 163: [: Illegal number:
because ncolors is an empty string. Fix that by setting it to 0 if the
tput command fails.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 75244db70331..fc755e1b50f1 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -154,13 +154,13 @@ fi
 
 # Define text colors
 # Check available colors on the terminal, if any
-ncolors=`tput colors 2>/dev/null`
+ncolors=`tput colors 2>/dev/null || echo 0`
 color_reset=
 color_red=
 color_green=
 color_blue=
 # If stdout exists and number of colors is eight or more, use them
-if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
+if [ -t 1 -a "$ncolors" -ge 8 ]; then
   color_reset="\e[0m"
   color_red="\e[31m"
   color_green="\e[32m"
-- 
2.19.1

