Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C81C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEE82145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEE82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeHBKBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:01:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeHBKBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:01:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728AvGX3431006
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:10:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728AvOb3431003;
        Thu, 2 Aug 2018 01:10:57 -0700
Date:   Thu, 2 Aug 2018 01:10:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-l39jz1vnyda0b6jsufuc8bz7@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, dsahern@gmail.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        tglx@linutronix.de
Reply-To: jolsa@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
          dsahern@gmail.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Beautify the AF_INET & AF_INET6
 'socket' syscall 'protocol' args
Git-Commit-ID: 162d3edbe591a97939516b546162b9ba05ec62cb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  162d3edbe591a97939516b546162b9ba05ec62cb
Gitweb:     https://git.kernel.org/tip/162d3edbe591a97939516b546162b9ba05ec62cb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Jul 2018 09:26:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:52:49 -0300

perf trace: Beautify the AF_INET & AF_INET6 'socket' syscall 'protocol' args

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
