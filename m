Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222CD218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458449;
	bh=BnU3fhRFbCgSgGMbJju/vH9RmyIoZycrmRyzw4h5vbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SeN9L9V/5HmgNDVeP2EUh6/FKPGZBqF/vw24MAY04ujbfkl6yofFUYmijvbWnFcaa
	 dxhSBbw4bvPoG8zM5xLUBL351ZCXc/cHIpZwrwU8TUnO8e5CLI1kICHYLEUgVKQNpy
	 5L4VB6xcWombDODSBH/eW22wo8oybdC2LHM+J3YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfAYXTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfAYXTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:44 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D61B21903;
        Fri, 25 Jan 2019 23:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458383;
        bh=BnU3fhRFbCgSgGMbJju/vH9RmyIoZycrmRyzw4h5vbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqvaLDYtfKBPMreGqQlmrunBBHpzJ+PDRwtzqBWmRb6X9kPk9a1Agc75ttE6ri/AW
         Hljo07wEaQ2s3CeZKx01bn4A+lEBEiPYVCMjccH5QTKsXHtSPonYecHoZGSmrqeXA3
         vCzcca8Tigmo1DbABrPLvLq5ybA1dxg4Lo1dYQRY=
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
Subject: [PATCH 24/29] perf bpf: Add bpf_map() helper
Date:   Sat, 26 Jan 2019 00:18:38 +0100
Message-Id: <20190125231843.2895-25-acme@kernel.org>
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

To make the declaration of maps more compact, the following patches will
make use of it.

Standardizing on it will allow to add the BTF details, i.e.
BPF_ANNOTATE_KV_PAIR() (tools/testing/selftests/bpf/bpf_helpers.h)
transparently.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-h3q9rxxkbzetgnbro5rclqft@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index e667577207dc..0482028c1d11 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -18,6 +18,14 @@ struct bpf_map {
         unsigned int numa_node;
 };
 
+#define bpf_map(name, _type, type_key, type_val, _max_entries)	\
+struct bpf_map SEC("maps") name = {				\
+	.type	     = BPF_MAP_TYPE_##_type,			\
+	.key_size    = sizeof(type_key),			\
+	.value_size  = sizeof(type_val),			\
+	.max_entries = _max_entries,				\
+}
+
 /*
  * FIXME: this should receive .max_entries as a parameter, as careful
  *	  tuning of these limits is needed to avoid hitting limits that
-- 
2.20.1

