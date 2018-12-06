Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBC9C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D7920989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131658;
	bh=xRWoKTT5IBluDexeAv7T/c2r7ehrF69TOgT3zp2r4BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QfGguoAQP5AXEeCNutlzi6dkQ3lGCoNoG8eelJbrq81TGLqJu/ALO3iyW4YhM8Wun
	 rnSIm6EUYgDm0Br8fNQsavpJVyhxIDg9emHCFnpQlJ2UApmptT9I0MmVmQa4DqWLeu
	 2I9648ZRf0NPIbCYbB0eDQsLNer53OVQR9KwBuTQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D7920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLFV1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLFV1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:36 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26CBD208E7;
        Thu,  6 Dec 2018 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131656;
        bh=xRWoKTT5IBluDexeAv7T/c2r7ehrF69TOgT3zp2r4BA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXDmjJxL+To0KmzaW0Y0adjEeTreHO/uVIlL+ZaBoDmhM/jNhSaRKMdNEIDS75F+b
         g8qhhRScFeqXPmnA9OvDmS5PX1POUrT7tHAWyT5y20BPGWckCZJdut3iXAFkNA6WQF
         /Hw+OOGjAB9T/nIqrnG4x+KggnB2slOhkcSrB4Aw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 15/75] perf top: Allow passing a kallsyms file
Date:   Thu,  6 Dec 2018 18:25:02 -0300
Message-Id: <20181206212602.20474-16-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This basically replicates what was done for 'perf report' in:

   b226a5a72901 ("perf report: Allow user to specify path to kallsyms file")

This should help with resolving eBPF symbols, that are in kallsyms but,
of course, not in vmlinux.

Reported-by: Ivan Babrou <ibobrik@gmail.com>
Tested-by: Ivan Babrou <ibobrik@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x52mx1ybq8128rtg9hjrj5qk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 3 +++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 808b664343c9..44d89fb9c788 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -70,6 +70,9 @@ Default is to monitor all CPUS.
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--kallsyms=<file>::
+	kallsyms pathname
+
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aa0c73e57924..1252d1759064 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1289,6 +1289,8 @@ int cmd_top(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
 		    "don't load vmlinux even if found"),
+	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
+		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
 		    "hide kernel symbols"),
 	OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",
-- 
2.19.2

