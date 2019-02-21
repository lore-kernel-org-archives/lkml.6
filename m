Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851872084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBUQHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:07:12 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:48531 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbfBUQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:07:10 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 444zrC3xK6z1yMm;
        Thu, 21 Feb 2019 17:07:07 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.5.153
Received: from fau.de (faustud-010-021-005-153.pool.uni-erlangen.de [10.21.5.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19uoSDBXcnDC3ngvTUOgGUsS/QDmBEHt18=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 444zr84njTz1yTx;
        Thu, 21 Feb 2019 17:07:04 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Gardner <rob.gardner@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 0/3] Support inline symbols in callchains
Date:   Thu, 21 Feb 2019 17:06:49 +0100
Message-Id: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patchset supersedes my previous attempt to add inline symbols to
callchain of perf-script [1] by a more generic attempt to not hook in
the output stage but directly into the callchain generation. By a matter
of fact this adds those inline symbols automatically to other commands
like perf-report.
Additionally this fixes the regression reported by Jiri Olsa [2] that
some entries from previous outputs had been vanished and now only new
lines are added if symbols had been found.

The integration for perf-report is not completely done as there is an
issue if the root for an hist_entry as for inlined symbols there may be
multiple instances (for each address-range) with the same name. But in
util/sort.c:233 only the name is compared for inlined symbols. As a
consequence the returned hist_entry may hold a reference to another
instance for this inlined symbol (with another address range than
requested) we later on fail with -ERANGE in __symbol__inc_addr_samples
(util/annotate.c:857).
This issue does still permit perf-report to be executed without any
problems and the inlined symbols do show up but none of the samples is
actually accounted to them but to the original symbol :(

To further provide information what this changeset is doing, here is a
script-session to show the differences in the output:

[jonas@x60s]$  git reset --hard v5.0-rc7; make -C tools/perf >/dev/null; \
HEAD is now at a3b22b9f11d9 Linux 5.0-rc7
[jonas@x60s]$  git am *.patch; make -C tools/perf >/dev/null; \
	mv tools /perf/perf perf-new
Applying: perf map: add function to lookup inline symbols
Applying: perf machine: use map__inlines in append_inlines
Applying: perf machine: add inline symbols to callchains
[jonas@x60s]$  cat test.c
static int foo(int m){int r=0; for(int i=0;i<m;++i)r+=i; return r;}
static int bar(int m){int r=0; for(int i=0;i<m;++i)r+=foo(i); return r;}
static int baz(int m){int r=0; for(int i=0;i<m;++i)r+=foo(i)*bar(i); return r;}
int main() { return baz(421); }
[jonas@x60s]$  gcc -O2 -fno-omit-frame-pointer -g -o test test.c
[jonas@x60s]$  ./perf-new record --call-graph fp ./test.c
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (19 samples) ]
[jonas@x60s]$  time ./perf-old script >old.script
real	0m0.039s
user	0m0.012s
sys	0m0.022s
[jonas@x60s]$  time ./perf-new script >new.script
real	0m0.045s
user	0m0.010s
sys	0m0.032s
[jonas@x60s]$  diff -u old.script new.script
--- old.script	2019-02-21 16:30:47.997194180 +0100
+++ new.script	2019-02-21 16:30:51.757309790 +0100
@@ -23,66 +23,101 @@
 	    7f43b1148090 _start+0x0 (/lib/x86_64-linux-gnu/ld-2.27.so)
 
 test  7579 1470536.968092:     354758 cycles:uppp: 
+	    7f43b1148f4b elf_get_dynamic_info+0xab (inlined)
 	    7f43b1148f4b _dl_start+0xab (/lib/x86_64-linux-gnu/ld-2.27.so)
 	    7f43b1148098 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-2.27.so)
 [...]
 
 test  7579 1470536.969210:    1922435 cycles:uppp:
+	    563f0df9c53f foo+0x4f (inlined)
+	    563f0df9c53f bar+0x4f (inlined)
+	    563f0df9c53f baz+0x4f (inlined)
 	    563f0df9c53f main+0x4f (/home/jonas/linux/test)
 	    7f43b0d77b97 __libc_start_main+0xe7 (/lib/x86_64-linux-gnu/libc-2.27.so)
 	 75e258d4c544155 [unknown] ([unknown])
[jonas@x60s]$  time ./perf-new script --no-inline >new.noinline.script
real	0m0.035s
user	0m0.012s
sys	0m0.020s
[jonas@x60s]$  diff -u old.script new.noinline.script
[jonas@x60s]$  ./perf-old report --stdio --quiet | sed '/^$/Q'
       88.80%    88.80%  test     test              [.] main
            |
            ---0x75e258d4c544155
               __libc_start_main
               main
[jonas@x60s]$  ./perf-new report --stdio --quiet | sed '/^$/Q'
    88.80%    88.80%  test     test              [.] main
            |
            ---0x75e258d4c544155
               __libc_start_main
               main
               baz (inlined)
               bar (inlined)
               foo (inlined)
[jonas@x60s]$  ./perf-new report --stdio --quiet --no-inline | sed '/^$/Q'
    88.80%    88.80%  test     test              [.] main
            |
            ---0x75e258d4c544155
               __libc_start_main
               main

I am still trying to find a way that in the new output of report the
88.80% 'Self' are not accounted to main itself but split up for the
inlined baz, bar and foo symbols.

I'm open to any help as well as feedback,
 Jonas

[1] https://www.spinics.net/lists/linux-perf-users/msg07792.html
[2] https://www.spinics.net/lists/linux-perf-users/msg07798.html

Jonas Rabenstein (3):
  perf map: add function to lookup inline symbols
  perf machine: use map__inlines in append_inlines
  perf machine: add inline symbols to callchains

 tools/perf/util/machine.c | 130 ++++++++++++++++++++++++++------------
 tools/perf/util/map.c     |  23 +++++++
 tools/perf/util/map.h     |   3 +
 3 files changed, 115 insertions(+), 41 deletions(-)

-- 
2.19.2

