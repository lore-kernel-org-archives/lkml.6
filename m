Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61078C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C93C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfAVLfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:35:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfAVLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:35:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MBYZki2929511
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 03:34:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MBYZtf2929508;
        Tue, 22 Jan 2019 03:34:35 -0800
Date:   Tue, 22 Jan 2019 03:34:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-96167167b6e17b25c0e05ecc31119b73baeab094@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        ak@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: acme@redhat.com, mingo@kernel.org, ak@linux.intel.com,
          hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190117194834.21940-1-andi@firstfloor.org>
References: <20190117194834.21940-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Fix crash with printing mixed trace
 point and other events
Git-Commit-ID: 96167167b6e17b25c0e05ecc31119b73baeab094
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

Commit-ID:  96167167b6e17b25c0e05ecc31119b73baeab094
Gitweb:     https://git.kernel.org/tip/96167167b6e17b25c0e05ecc31119b73baeab094
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 17 Jan 2019 11:48:34 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 18 Jan 2019 09:53:07 -0300

perf script: Fix crash with printing mixed trace point and other events

'perf script' crashes currently when printing mixed trace points and
other events because the trace format does not handle events without
trace meta data. Add a simple check to avoid that.

  % cat > test.c
  main()
  {
      printf("Hello world\n");
  }
  ^D
  % gcc -g -o test test.c
  % sudo perf probe -x test 'test.c:3'
  % perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
  % perf script
  <segfault>

Committer testing:

Before:

  # perf probe -x /lib64/libc-2.28.so malloc
  Added new event:
    probe_libc:malloc    (on malloc in /usr/lib64/libc-2.28.so)

  You can now use it in all perf tools, such as:

	perf record -e probe_libc:malloc -aR sleep 1

  # perf probe -l
  probe_libc:malloc    (on __libc_malloc@malloc/malloc.c in /usr/lib64/libc-2.28.so)
  # perf record -e '{cpu/cpu-cycles,period=10000/,probe_libc:*}:S' sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.023 MB perf.data (40 samples) ]
  # perf script
  Segmentation fault (core dumped)
  ^C
  #

After:

  # perf script | head -6
     sleep 2888 94796.944981: 16198 cpu/cpu-cycles,period=10000/: ffffffff925dc04f get_random_u32+0x1f (/lib/modules/5.0.0-rc2+/build/vmlinux)
     sleep 2888 [-01] 94796.944981: probe_libc:malloc:
     sleep 2888 94796.944983:  4713 cpu/cpu-cycles,period=10000/: ffffffff922763af change_protection+0xcf (/lib/modules/5.0.0-rc2+/build/vmlinux)
     sleep 2888 [-01] 94796.944983: probe_libc:malloc:
     sleep 2888 94796.944986:  9934 cpu/cpu-cycles,period=10000/: ffffffff922777e0 move_page_tables+0x0 (/lib/modules/5.0.0-rc2+/build/vmlinux)
     sleep 2888 [-01] 94796.944986: probe_libc:malloc:
  #

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190117194834.21940-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d079f36d342d..357906ed1898 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1794,7 +1794,7 @@ static void process_event(struct perf_script *script,
 		return;
 	}
 
-	if (PRINT_FIELD(TRACE)) {
+	if (PRINT_FIELD(TRACE) && sample->raw_data) {
 		event_format__fprintf(evsel->tp_format, sample->cpu,
 				      sample->raw_data, sample->raw_size, fp);
 	}
