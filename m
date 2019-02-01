Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39A72184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej15mUwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfBADG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:06:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38901 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBADG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:06:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so2262574pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 19:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kFIyPwvmY6Z8CaxQVGctlcM25ld4uiqRnEntk+fHjBU=;
        b=ej15mUwppB6AS7nFNg9C3thXyyhlLMXsk7VqOWPN22dPJggNb2eqUQmxJqiO9Tm/s8
         NLcuf8jIqNXOJDjY8Ber+5ME8wpQKvfD4xRNCxOeu+PiKA/rLRTN6jcj5dZqOz5FYFTI
         C95O0dpNGsHqt/MD05719EeLLLVAF3u2Hqpttn3Or9Py/Q5QIU09RLwGgI80rLq5TmnF
         PeOS50STHKEQupLEp1weU7/0ynx+Ava1j/50UGJL+T4zk9pJ9ZSuMAToPYzbwPa+tVfU
         zdOCtRsZjnAppkHDdrr0rDkExfhQMtgSks1P5xKLj+T7CUSWcw8oKtlrvMMiRsGxJiRv
         P1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kFIyPwvmY6Z8CaxQVGctlcM25ld4uiqRnEntk+fHjBU=;
        b=BQkQ/yAR+mbsDiqK4Lw2VfIg36cmpOrU3Dx9e6b9dycNTpgQQYQfYWsDgmdiA+1lBf
         bxI08FxEUo3mdXZA6tET4yeXsPUynwuDw5rku0BATThDUYy1Wv3Pt7+y+oXo4JstRkPY
         B8VEFAiSGn864x25aqYvxPAQqkCwv2oj+IA/4aF83bxUo3+yd3R6C0bPUUUmAFkx7egu
         jGGOnEP9G3/ihmr8FlcusR1PA2j9PTGWHz6EVJvRR7Ag2zqG7wlWTFSc7qWAGuSrIsQB
         FUtCxdU7Qgw/KiVYJol3ZPbvi/zhoNWpcGuEW8vqponJuW0kEfjADv09Ovsc5vgudjUt
         5HVQ==
X-Gm-Message-State: AJcUukdaUgm6lXjkJwG7pQtLXZzpNfITxSbZqfhTi42xQX7asUFeIT9L
        DPLgHMtqWiIavvOC8rPypuM=
X-Google-Smtp-Source: ALg8bN7RpJ2qUIDizwGAFAt6rS+BkLDspQxNWYgWJhI88ZD8tLyO7UMp7XSpAe+4eDlXbI1g3uzagA==
X-Received: by 2002:a62:2292:: with SMTP id p18mr38483826pfj.9.1548990418286;
        Thu, 31 Jan 2019 19:06:58 -0800 (PST)
Received: from vultr.guest ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i72sm8383692pfe.181.2019.01.31.19.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 19:06:57 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] perf record: Add doc for bpf event selection
Date:   Fri,  1 Feb 2019 03:06:41 +0000
Message-Id: <20190201030641.4046-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add document for how to pass bpf program with perf.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-record.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..0925d987cad0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -88,6 +88,19 @@ OPTIONS
           If you want to profile write accesses in [0x1000~1008), just set
           'mem:0x1000/8:w'.
 
+        - a bpf source file or object file to select events by a bpf program.
+          The bpf program can attach to variant perf events based on section
+          names.
+
+          When passing '.c', perf searches installed LLVM to compile it into
+          object file first. Optional clang options can be pased by option
+          '--clang-opt'.
+
+          perf record --clang-opt "-DLINUX_VERSION_CODE=0x50000" \
+                      -e ./tests/bpf-script-example.c
+
+          Note: '--clang-opt' must place before '--event'.
+
 	- a group of events surrounded by a pair of brace ("{event1,event2,...}").
 	  Each event is separated by commas and the group should be quoted to
 	  prevent the shell interpretation.  You also need to use --group on
-- 
2.17.1

