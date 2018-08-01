Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AFBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C621B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="atUAY143"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C621B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbeHAXZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbeHAXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:14 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E9D208AC;
        Wed,  1 Aug 2018 21:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159446;
        bh=QyQh5V9PclJKYjyWDSlLINwyXWoCz77FZvAmG6w+OiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atUAY143C/KwyQ85P8omdHOA3Hwlr7n1qFyRgsq/FewuYkfHQJiePkr+fhIAJS9AK
         lVTe8bWOpW3N3UYLwAZpqyMVpwFLiBO3WdPzjH1A+v2MUZR1xsfP+hqVOjsAbDKD3k
         9nyfUzX/WoCJpeii6I1FGxq6CSkU+wwbd5MSsyBA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/21] perf trace: Beautify the AF_INET & AF_INET6 'socket' syscall 'protocol' args
Date:   Wed,  1 Aug 2018 18:36:35 -0300
Message-Id: <20180801213648.4814-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance:

  $ trace -e socket* ssh sandy
     0.000 ( 0.031 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     0.052 ( 0.015 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.568 ( 0.020 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.603 ( 0.012 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.699 ( 0.014 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.724 ( 0.012 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.804 ( 0.020 ms): ssh/19919 socket(family: INET, type: STREAM, protocol: TCP                      ) = 3
    17.549 ( 0.098 ms): ssh/19919 socket(family: LOCAL, type: STREAM                                    ) = 4
  acme@sandy's password:

Just like with other syscall args, the common bits are supressed so that
the output is more compact, i.e. we use "TCP" instead of "IPPROTO_TCP",
but we can make this show the original constant names if we like it by
using some command line knob or ~/.perfconfig "[trace]" section
variable.

Also needed is to make perf's event parser accept things like:

  $ perf trace -e socket*/protocol=TCP/

By using both the tracefs event 'format' files and these tables built
from the kernel sources.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-l39jz1vnyda0b6jsufuc8bz7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 632ef5f8f060..9aca65e6b9aa 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -761,10 +761,12 @@ static struct syscall_fmt {
 	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
 	{ .name	    = "socket",
 	  .arg = { [0] = STRARRAY(family, socket_families),
-		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
+		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ },
+		   [2] = { .scnprintf = SCA_SK_PROTO, /* protocol */ }, }, },
 	{ .name	    = "socketpair",
 	  .arg = { [0] = STRARRAY(family, socket_families),
-		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
+		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ },
+		   [2] = { .scnprintf = SCA_SK_PROTO, /* protocol */ }, }, },
 	{ .name	    = "stat", .alias = "newstat", },
 	{ .name	    = "statx",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	 /* fdat */ },
-- 
2.14.4

