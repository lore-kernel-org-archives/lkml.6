Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C39C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA68218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458460;
	bh=xIKmE95sPyJsbm+Cdu+0o/a4QD8l9AfUblu1D9XFEHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wl++aGTTv5Uw4oKSWVjJVoLetvy4dA65zK0Th9w2PBtNH0D5wwG4KVCNlQJwnWDyo
	 GHitTH0C5DIrtt6QGqASRG4934tT5EUqffNRW4Tp5EAMeYKiMdA+KAtftZ2bE1Uec1
	 qhe1laEbmSiFdrUD1AnKoL1krdmEKqJj3S4NeRZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfAYXU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfAYXTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:47 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F01721906;
        Fri, 25 Jan 2019 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458386;
        bh=xIKmE95sPyJsbm+Cdu+0o/a4QD8l9AfUblu1D9XFEHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9fgHio6BG6t9cVzzYHKxCfZ8q6m4WK9dmrSOZaOsonadcVXF05rZztOVtiHEuS3i
         VQvU/a9t6Cc9VmW0I6yQUZXeQrzs4ZNHVcLUGbi+PAg004OzYFbPvj0cc+gBTCYlp7
         Om8Tjv+S1Ff70LkMP6Yjhyeyp32YBmJopMF/3/KQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 25/29] perf bpf: Convert pid_map() to bpf_map()
Date:   Sat, 26 Jan 2019 00:18:39 +0100
Message-Id: <20190125231843.2895-26-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

First user, pid_t as the type, lets see how this goes with the BTF
routines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-56eplvf86r69wt3p35nh805z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 0482028c1d11..5df7ed9d9020 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -34,13 +34,7 @@ struct bpf_map SEC("maps") name = {				\
  *	  For the current need, 'perf trace --filter-pids', 64 should
  *	  be good enough, but this surely needs to be revisited.
  */
-#define pid_map(name, value_type)		\
-struct bpf_map SEC("maps") name = {		\
-	.type	     = BPF_MAP_TYPE_HASH,	\
-	.key_size    = sizeof(pid_t),		\
-	.value_size  = sizeof(value_type),	\
-	.max_entries = 64,			\
-}
+#define pid_map(name, value_type) bpf_map(name, HASH, pid_t, value_type, 64)
 
 static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
 static void *(*bpf_map_lookup_elem)(struct bpf_map *map, void *key) = (void *)BPF_FUNC_map_lookup_elem;
-- 
2.20.1

