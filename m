Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DEDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF32C20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF32C20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404825AbeKVRkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:40:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbeKVRkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:40:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM72aOn3689053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:02:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM72alx3689050;
        Wed, 21 Nov 2018 23:02:36 -0800
Date:   Wed, 21 Nov 2018 23:02:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-gdwvq53wltvq6b3g5tdmh0cw@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        adrian.hunter@intel.com, jolsa@kernel.org, dsahern@gmail.com,
        namhyung@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          mingo@kernel.org, dsahern@gmail.com, namhyung@kernel.org,
          jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          hpa@zytor.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add defines for map insertion/lookup
Git-Commit-ID: 382b55dbef6b68e3fef2fd8a438fbaff57695308
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

Commit-ID:  382b55dbef6b68e3fef2fd8a438fbaff57695308
Gitweb:     https://git.kernel.org/tip/382b55dbef6b68e3fef2fd8a438fbaff57695308
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Nov 2018 15:46:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf bpf: Add defines for map insertion/lookup

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
