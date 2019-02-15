Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C35222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191622;
	bh=8huM5zM2ky6GW4FfpwKlqPBSbWLv/9NU8qBPnV/NyJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nzTMpoXftW69CeeKEpBj6KS5dOxXtPKSW7AJEKM6cEkI/SdXGfCHAL1OtjduyG4tO
	 g9fZtiYi2jU2Ki7zA1485wx5lqQ8u5cOkc287V8VZ++aSTRD2PCpOWtkWBobs6phX8
	 ExIXTrvh5QAH4MsGqbrhwLpUQ4iKNNQYu9T0TspA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfBOArB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388876AbfBOAq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:46:58 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 855032229F;
        Fri, 15 Feb 2019 00:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191617;
        bh=8huM5zM2ky6GW4FfpwKlqPBSbWLv/9NU8qBPnV/NyJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkjtP0720eBWADi/qOW/fEYr2ZSQ7mbFSonhbNRAs0lDpP2L5yuj9c1bJw1rzU17r
         8WYSsW8fD1Ii1hwrDXzwuWmI1e67WzOobbgxEOKYKu6leVwyj+qnnyrQbfVFfPiCUX
         I1JCSm5Z+hSaxpXBahPAv6P29IArBNNripsnZpzQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/43] perf beauty waitid options: Fix up prefix showing logic
Date:   Thu, 14 Feb 2019 21:45:12 -0300
Message-Id: <20190215004539.23571-17-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When introducing the possibility for selecting if the common prefix to
options such as the waitid ones, i.e. all 'waitid' options start with
'W', so, to make it make it more compact if configured to suppress it,
'perf trace' will do so, other examples include mmap's PROT_ prefix for
its 'prot' argument, etc, which, when showing the syscall argument name
ends up producing duplicated info that clutters the screen, i.e.:

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/20886 mmap(len: 112595, prot: PROT_READ, flags: MAP_PRIVATE, fd: 3) = 0x7f3e986d2000
     0.041 ( 0.005 ms): sleep/20886 mmap(len: 8192, prot: PROT_READ|PROT_WRITE, flags: MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f3e986d0000
  #

So it is possible to suppress that and make it more compact by having
this in your ~/.perfconfig:

  # cat ~/.perfconfig
  [trace]
	show_prefix = no
  #

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/8009 mmap(len: 112595, prot: READ, flags: PRIVATE, fd: 3) = 0x7ff2373de000
     0.040 ( 0.005 ms): sleep/8009 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7ff2373dc000
  #

To have it look more like strace's output, we instead want to suppress
the arg name and show the prefix, so use:

  # cat ~/.perfconfig
  [trace]
	show_prefix = yes
	show_arg_names = no
  #
  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.006 ms): sleep/15513 mmap(NULL, 112595, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f7a9b6d3000
     0.020 ( 0.002 ms): sleep/15513 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f7a9b6d1000
  #

When this logic was introduced a bug came with it when processing the
waitid 'option' arg that ended up expecting 3 strings when just two were
being provided, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/waitid_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/waitid_options.c b/tools/perf/trace/beauty/waitid_options.c
index 6897fab40dcc..d4d10b33ba0e 100644
--- a/tools/perf/trace/beauty/waitid_options.c
+++ b/tools/perf/trace/beauty/waitid_options.c
@@ -11,7 +11,7 @@ static size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
 
 #define	P_OPTION(n) \
 	if (options & W##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "",  #n); \
 		options &= ~W##n; \
 	}
 
-- 
2.19.1

