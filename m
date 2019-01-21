Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB7AC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3AC2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548095740;
	bh=Q6FORiGHNSBbj3H/Ni6KFm+7XOcewWGAsI4EqCSFAiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NwfYabUWQvZdZeDmiwp7xIXjq1PF3HUPPxkZA/LTY1mIQAo8QXwoNoxLq5FDpYeJA
	 pMLXyQa8c/VIJo1m2dp+FwLLqz2jJAyXFv5u4JGHPUnd4Xlzvwbjcrbu1wquDz4wPw
	 Yvzbn4puIOrJtD6wZp+OtAYq/aQfTrAPICzUN7Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfAUSfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfAUSfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:35:38 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC6620989;
        Mon, 21 Jan 2019 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548095737;
        bh=Q6FORiGHNSBbj3H/Ni6KFm+7XOcewWGAsI4EqCSFAiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSfChQKn+DA8FvJpu4hyfJzUsJqIn8lFmO65fiT0UtDVXBANg5llg3OmANCTZ1u1B
         MsmZJwGMUuHFsePNm3QApdoSbm97SXn8aGmwFIhOPs7+6zcHD4Ju0wQXA21Ar5UXwY
         oPcndoL1uwAK7aUzlmV16jLl8HjkoyBqSqbDIyHE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 2/7] perf script: Fix crash with printing mixed trace point and other events
Date:   Mon, 21 Jan 2019 15:35:02 -0300
Message-Id: <20190121183507.23490-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.20.1

