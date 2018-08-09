Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFE5C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E62183D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yOeIYC5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204E62183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbeHIR0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732712AbeHIR0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:42 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA99C21DEC;
        Thu,  9 Aug 2018 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826884;
        bh=j4u4ZbJo3KHXFoNXptN4veLZlTDJTcNll7PaL6ljDLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOeIYC5f3GuJAt1Adlk13sB0y/hvSIbqEiMj8m0I/4hN25Q6ReamDRXbqmg5vdAK3
         3E9kzND+qJ4bjCoueUtSv1WHTdfEXawJZePlPsnJJj3eiPnlf0XJLQZndl5f7kkr0d
         ESJFVOtjTpfMqO+6Fn0IOUTOny+z6I2iDjgSOC8s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 35/44] perf bpf: Make bpf__for_each_stdout_map() generic
Date:   Thu,  9 Aug 2018 11:58:13 -0300
Message-Id: <20180809145822.21391-36-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By passing a 'name' arg, that will eventually be used to setup more
"bpf-output" events, e.g. to create a event where to create raw_syscalls
like events that in addition to the syscall arguments will also copy the
pointer contents being passed from/to userspace.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-talrnxps9p3qozk3aeh91fgv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 3d02ae38ec56..e864a7e0ff12 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1529,12 +1529,15 @@ int bpf__apply_obj_config(void)
 	bpf_object__for_each_safe(obj, objtmp)	\
 		bpf_map__for_each(pos, obj)
 
-#define bpf__for_each_stdout_map(pos, obj, objtmp)	\
+#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
 	bpf__for_each_map(pos, obj, objtmp) 		\
 		if (bpf_map__name(pos) && 		\
-			(strcmp("__bpf_stdout__", 	\
+			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
+#define bpf__for_each_stdout_map(pos, obj, objtmp) \
+	 bpf__for_each_map_named(pos, obj, objtmp, "__bpf_stdout__")
+
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
-- 
2.14.4

