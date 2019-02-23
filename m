Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A86AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD202085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955891;
	bh=cFmwW7wA/LtgeLTSEQ+7NGZJkzf5bCPQEtFOKCUYsXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNm2OHrDHHHEngy4tnPUw+K/UtnMKKpcXSTRSbig1hgEvVxX9P6fj4LykvxmoI2Um
	 MkztlkNn2/ad1uHWjce5iU9QX+RbrZ7/asZLQaS5wciJGY+YDQXM1h2Bd585Lhtuc6
	 YHQufnP7u+haZ/tvgxnNN4f7ky6ecg8Mz7K/2bKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfBWVEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfBWVEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:04:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF4620861;
        Sat, 23 Feb 2019 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955875;
        bh=cFmwW7wA/LtgeLTSEQ+7NGZJkzf5bCPQEtFOKCUYsXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHYmZHOxO6YTZs4UrFSjE6LPTs9jZd1jISYprPMHedNMgtLtbihDqtvbPFhYeJ4gp
         dstXJg70uI1bdW0Z31C+ZKhsMIVFqWXGDwkTS8b/Xbx/o9nv0ZhZmtvvHaoOVYQgDJ
         +p0FHfHe4iVue84uahaX2PaijRfZ3QnC+EM7Pfe4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 08/72] perf script: Fix crash with printing mixed trace point and other events
Date:   Sat, 23 Feb 2019 16:03:18 -0500
Message-Id: <20190223210422.199966-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ Upstream commit 96167167b6e17b25c0e05ecc31119b73baeab094 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a7b4d3f611c59..5c070a600233a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1746,7 +1746,7 @@ static void process_event(struct perf_script *script,
 		return;
 	}
 
-	if (PRINT_FIELD(TRACE)) {
+	if (PRINT_FIELD(TRACE) && sample->raw_data) {
 		event_format__fprintf(evsel->tp_format, sample->cpu,
 				      sample->raw_data, sample->raw_size, fp);
 	}
-- 
2.19.1

