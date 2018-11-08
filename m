Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4555520883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkqVW5ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4555520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeKIHzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732165AbeKIHod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:33 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F45208A3;
        Thu,  8 Nov 2018 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714822;
        bh=BlTxpn+n3wx5dSi/PZDvEo2hS9Tn56+ezEm5rGj23V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkqVW5ZNE9LR5KpVJUB/CmfohrfYZdxOqrVnz0k28vugz4V2U0K20PH7QUUcO1W2v
         U/kv1/h2oCsPTQsfcAzs2U9UYRUFFdXzjgRFy1k6oxE8J3L5rFa8d8rYxziyayUcUX
         oEMez7DTdjgBVwvdayi5hEHnNSHJn9aja7zNi5X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 133/171] perf tools: Disable parallelism for make clean
Date:   Thu,  8 Nov 2018 13:51:43 -0800
Message-Id: <20181108215136.774264688@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit da15fc2fa9c07b23db8f5e479bd8a9f0d741ca07 ]

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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180705131527.19749-1-linux@rasmusvillemoes.dk
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -83,10 +83,10 @@ endif # has_clean
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


