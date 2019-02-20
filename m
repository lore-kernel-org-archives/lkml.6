Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB9A20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfBTPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:37:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57006 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:37:22 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gwTw0-000547-Hh
        for linux-kernel@vger.kernel.org; Wed, 20 Feb 2019 15:37:20 +0000
Received: by mail-wr1-f70.google.com with SMTP id l5so10890865wrv.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/dLcDBD1w25fdavzlLup87+g4lUgNGlzzNmKqv2bRo=;
        b=iBwVaziyvGIOF1qyocRodFvMZ4H4lLq9rSj61FhW5j+nyJAFCIPk75K5Ap4HxZ19b+
         rykDjhHtuuP1+hZ5ZRc7z23TOYor9Pv2nV3/7u/d64XB5F5DyrrLYY+rp63OPTPvkjqQ
         C0WZgaO1k0RsdEhzpPuqEV3RkQCZmGKmBKEf4Oh8XIfnC+8spSmMzsA8tU6gph3Z9Lid
         qVxtQkVa6jpwHqR6y2mP63THirW/rl7DKiMBa2SL+MR2fgc7niHoWDjh67xdsRcoRT05
         Ov/iJ5pZAGLmEqDoeSGD6BksLUGfJ4/ua02yaD+MppP1UyF4g/Z6VVS8FIYJUyGjQCrE
         5cIw==
X-Gm-Message-State: AHQUAub5Wu/NtX8ggVY4TiL8vK/9Av6q4TyuP8tsOhJbGkDA/P0zb5Lc
        WZsDnnxyPqaaGRoVhdlY5Y4qz/9u3crrDDqfmAtvWw26+ajljXK3cTIh+osE7243P+BS+KpCfc1
        Dibg2qpYg1N79K6BBzKFR4QvwFW5SmxS5ELRCBlZT1Q==
X-Received: by 2002:a1c:f701:: with SMTP id v1mr6824298wmh.153.1550677039908;
        Wed, 20 Feb 2019 07:37:19 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZDEIQlJ4kjdC3/uiHqjzX00elvpwh+h/zLk8HfY/U6IrXAdAu/xwDsz8KKXHQHqtIDHmx2Mg==
X-Received: by 2002:a1c:f701:: with SMTP id v1mr6824281wmh.153.1550677039615;
        Wed, 20 Feb 2019 07:37:19 -0800 (PST)
Received: from localhost.localdomain ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id t4sm22419655wrb.64.2019.02.20.07.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 07:37:18 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] selftests/ftrace: Handle the absence of tput
Date:   Wed, 20 Feb 2019 16:37:06 +0100
Message-Id: <20190220153706.24686-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In environments where tput is not availbale, we get the following
error
$ ./ftracetest: 163: [: Illegal number:
because ncolors is an empty string. Fix that by setting it to 0 if the
tput command fails.

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

