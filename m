Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24133C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE70020847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Qm/RgZLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70020847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeGENPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:15:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40193 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbeGENPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:15:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id a6-v6so6648016ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sEHAgctKChYdatzOfJMkr07kvMXTxfK0Y6OH1iJzdgw=;
        b=Qm/RgZLby4NyepdmBzSyWMdZB+F2u0CH8XxvO3CHFP0FFCj53aeZ9majAmgAjZ5Afq
         AKZq8CIL9x6cnSTkS7qNI1T7dlMkIzZ7boXJg1p40TQMmiGakpqV6RF1t3rgVqMV7g8J
         Ta+j0YccsgP9r44okiwqK4ahHfdLBxg8tk9us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sEHAgctKChYdatzOfJMkr07kvMXTxfK0Y6OH1iJzdgw=;
        b=rAoTBA6212OSKrnZQxp4OzegxFggVzqPEq6ppmieSf1+R9/gBkqKu2Kt0mvC088BhU
         2SUncak7E/wum7euJcVuSTGC6rcGRkYzMCmENVZfhZfsNs2HI8MTRmITz0GMPICsx/dN
         SoH7eLvK4WHlMJHQtqsUVjFkAbr6AVkJ3VC2u9lgkWKWPeOQSFYaNzP++t2ktQR1IM1b
         0GZS0gJqe6wQ0Mt69gvy039f0fEp1DdO1NwWQlmSI/WZbYFb/4yyKV1/0NxZs9SYaaU5
         cX4F/EHPcq2wEiVVavP0QAs6Fc9JnZLsb29/+Wri5RjUIP7Gg4kH2oJfXDgfF+lm1ts4
         LwTg==
X-Gm-Message-State: APt69E3YIy+F5fMeOwkhjnJl98QjXoIE3X1O0iT7sLOhO+vL7Rvo5+LN
        joKUXQfR97YdRWaMt50KGZMyKg==
X-Google-Smtp-Source: AAOMgpe5AXigtJnnCfzXOM6TjadH3UR+mWTUjkLw50wuHkTogGQfscjjK6Ku/1Fg005G8SAAnILu1w==
X-Received: by 2002:a2e:6d11:: with SMTP id i17-v6mr4035716ljc.116.1530796531489;
        Thu, 05 Jul 2018 06:15:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o9-v6sm946610ljd.18.2018.07.05.06.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 06:15:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: disable parallelism for 'make clean'
Date:   Thu,  5 Jul 2018 15:15:27 +0200
Message-Id: <20180705131527.19749-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Yocto build system does a 'make clean' when rebuilding due to
changed dependencies, and that consistently fails for me (causing the
whole BSP build to fail) with errors such as

| find: '[...]/perf/1.0-r9/perf-1.0/plugin_mac80211.so': No such file or directory
| find: '[...]/perf/1.0-r9/perf-1.0/plugin_mac80211.so': No such file or directory
| find: find: '[...]/perf/1.0-r9/perf-1.0/libtraceevent.a''[...]/perf/1.0-r9/perf-1.0/libtraceevent.a': No such file or directory: No such file or directory
|
[...]
| find: cannot delete '/mnt/xfs/devel/pil/yocto/tmp-glibc/work/wandboard-oe-linux-gnueabi/perf/1.0-r9/perf-1.0/util/.pstack.o.cmd': No such file or directory

Apparently (despite the comment), 'make clean' ends up launching
multiple sub-makes that all want to remove the same things - perhaps
this only happens in combination with a O=... parameter. In any case, we
don't lose much by explicitly disabling the parallelism for the clean
target, and it makes automated builds much more reliable.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Another option is to add -ignore_readdir_race to all find commands,
but that's a lot more invasive and only works properly together with
-delete with a very recent GNU find
(https://savannah.gnu.org/bugs/?52981).

 tools/perf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 225454416ed5..7902a5681fc8 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -84,10 +84,10 @@ endif # has_clean
 endif # MAKECMDGOALS
 
 #
-# The clean target is not really parallel, don't print the jobs info:
+# Explicitly disable parallelism for the clean target.
 #
 clean:
-	$(make)
+	$(make) -j1
 
 #
 # The build-test target is not really parallel, don't print the jobs info,
-- 
2.16.4

