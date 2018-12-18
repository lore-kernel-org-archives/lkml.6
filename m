Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C648C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EE5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171212;
	bh=DoXv6SwlrgG/eyjDqStJUjknRRYHo7GebEVgwxuZbes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KQhJ8UAHC8rWR/urdadhzLVQwaZ6kWFWqJt7LRYMUtayZc4L+xyDQSkxnJzcBSvCs
	 UQpq5mSn/XWfU2yf7bm1j/AjmCugrvZ3+vlkpOWkyxRdE9jwawW0iOHuDckGNHfV9B
	 aWj8qs4Vu1kY0T1Tai0KA70KffriLUm1qCysd4D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeLRWNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeLRWN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:29 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CA5217D9;
        Tue, 18 Dec 2018 22:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171208;
        bh=DoXv6SwlrgG/eyjDqStJUjknRRYHo7GebEVgwxuZbes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSXrKh5obh3ZRJN9/3W11Odsv5PSVOgiu2k3JLUkysApG9rLh611xYOqWFphsj3Ou
         MEsnHxF6M2rwpkZLyHCkhoD7QjTA5cidzD00uySYJw67WZoiPmBNIHvcuIVVjVpz4w
         QXyZ3meCVnrbjrPSXo+BTvX+4f+oLaAuXL5zm3kE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 39/63] perf trace: Allow configuring default for perf_event_attr.inherit
Date:   Tue, 18 Dec 2018 19:07:09 -0300
Message-Id: <20181218220733.15839-40-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.f. if children should inherit the parent perf_event configuration,
i.e. if we should trace children as well or just the parent.

The default is to follow children, to disable this and have a behaviour
similar to strace, set this config option or use the --no_inherit 'perf
trace' option.

E.g.:

Default:

  # perf config trace.no_inherit
  # trace -e clone,*sleep time sleep 1
     0.000 time/21107 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11, newsp: 0, child_tidptr: 0x7f7b8f9ae810) = 21108 (time)
         ? time/21108  ... [continued]: clone()
     0.691 sleep/21108 nanosleep(rqtp: 0x7ffed01d0540, rmtp: 0                               ) = 0
  0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 1988maxresident)k
  0inputs+0outputs (0major+76minor)pagefaults 0swaps
  #

Disable it:

  # trace -e clone,*sleep time sleep 1
     0.000 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11, newsp: 0, child_tidptr: 0x7ff41e100810) = 21414 (time)
  0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 1964maxresident)k
  0inputs+0outputs (0major+76minor)pagefaults 0swaps
  #

Notice that since there is just one thread, the "comm/TID" column is
suppressed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-thd8s16pagyza71ufi5vjlan@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 3 +++
 tools/perf/builtin-trace.c               | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 0d641b0d15ae..cd9bf12fb255 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -529,6 +529,9 @@ trace.*::
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
 
+	trace.no_inherit::
+		Do not follow children threads.
+
 	trace.show_duration::
 		Show syscall duration.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4355dadad232..a4e2290e57e0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3542,6 +3542,8 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_duration = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_zeros")) {
 		trace->show_zeros = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.no_inherit")) {
+		trace->opts.no_inherit = perf_config_bool(var, value);
 	}
 
 	return err;
-- 
2.19.2

