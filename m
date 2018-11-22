Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B2EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4520821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4hrLIFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD4520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404241AbeKVOOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404188AbeKVOOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:01 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1FF20878;
        Thu, 22 Nov 2018 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857796;
        bh=GRvsgwFaIcyFT5A5rd21uWypqKPJ626f32NyxmI15s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4hrLIFHELIbw9ZGSAjjZFWizaeW9gsX38b6Jd82FbSHirXBob/FLM/57CtiqAPCl
         +zrJN2CfEGd/M+N0i0SI30PNd57cRioYedobXAsEdFd/JekhUGX7JQbv9VdR46DL83
         CZqLdV9k7ueEGBdBKWbSPY134RjSw5XPG6d6WGgE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 04/28] perf bpf: Add defines for map insertion/lookup
Date:   Thu, 22 Nov 2018 00:35:47 -0300
Message-Id: <20181122033611.15890-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Starting with a helper for a basic pid_map(), a hash using a pid as a
key.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-gdwvq53wltvq6b3g5tdmh0cw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 52b6d87fe822..04ecd425a237 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -18,6 +18,17 @@ struct bpf_map {
         unsigned int numa_node;
 };
 
+#define pid_map(name, value_type)		\
+struct bpf_map SEC("maps") name = {		\
+	.type	     = BPF_MAP_TYPE_HASH,	\
+	.key_size    = sizeof(pid_t),		\
+	.value_size  = sizeof(value_type),	\
+	.max_entries = 512,			\
+}
+
+static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
+static void *(*bpf_map_lookup_elem)(struct bpf_map *map, void *key) = (void *)BPF_FUNC_map_lookup_elem;
+
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
 #define probe(function, vars) \
-- 
2.14.5

