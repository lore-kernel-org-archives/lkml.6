Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520ED218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170997;
	bh=q26kYUyME8Itbdup8Fz9ec9eQXhUcJqoAZHC5E1/8qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LkKO8euY89gxDG+AIssmM/6f4B5mSVjuMikz0eo+4D1pvc4DsVut98w/FEhJ+ugCg
	 mHtDGYdxwljlIC71tFKEa1VVgeTD1HpIRdQO3/8y/kcy6mAlBNsj9zWLMSh0vdNEk7
	 qA2K1RKcyVjrcBSZYCp5ECbzYf6HpsOE4EEQChRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeLRWJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbeLRWJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:53 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1E5218A2;
        Tue, 18 Dec 2018 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170992;
        bh=q26kYUyME8Itbdup8Fz9ec9eQXhUcJqoAZHC5E1/8qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0mIrBm0b35f6qyJ61kXRHlfMPbqgAbwAsT4jZyiQB7KPY8MkXsqyutA/K+Tz0HAN
         nJT2rJBHQiNPBBIhlGZa1g0nInXNOYXrSYh5dJAAG0ZBVCu9Ut+zf1h9RflR4crwJw
         b95rrAQ0/DiA23wwt8JietSvSekSSRj8KkpDaYf4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 23/63] perf bpf: Move perf_event_output() from stdio.h to bpf.h
Date:   Tue, 18 Dec 2018 19:06:53 -0300
Message-Id: <20181218220733.15839-24-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we don't always carry that __bpf_output__ map, leaving that to
the scripts wanting to use that facility.

'perf trace' will be changed to look if that map is present and only
setup the bpf-output events if so.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-azwys8irxqx9053vpajr0k5h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h   | 2 ++
 tools/perf/include/bpf/stdio.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index bd5d7b4d7760..e667577207dc 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -55,4 +55,6 @@ int _version SEC("version") = LINUX_VERSION_CODE;
 static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
 static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
 
+static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
+
 #endif /* _PERF_BPF_H */
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 2899cb7bfed8..316af5b2ff35 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -9,9 +9,6 @@ struct bpf_map SEC("maps") __bpf_stdout__ = {
        .max_entries = __NR_CPUS__,
 };
 
-static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) =
-	(void *)BPF_FUNC_perf_event_output;
-
 #define puts(from) \
 	({ const int __len = sizeof(from); \
 	   char __from[__len] = from; \
-- 
2.19.2

