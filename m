Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7297C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DEA2188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DEA2188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeHROqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:46:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:46:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBdDC61287565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:39:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBdD441287562;
        Sat, 18 Aug 2018 04:39:13 -0700
Date:   Sat, 18 Aug 2018 04:39:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ajlkpz4cd688ulx1u30htkj3@git.kernel.org>
Cc:     dsahern@gmail.com, adrian.hunter@intel.com, tglx@linutronix.de,
        jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, acme@redhat.com,
        hpa@zytor.com
Reply-To: acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org,
          mingo@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Add wrappers to
 BPF_FUNC_probe_read(_str) functions
Git-Commit-ID: 8fa25f303adfed6eab921db8e242e59dd0b3b004
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

Commit-ID:  8fa25f303adfed6eab921db8e242e59dd0b3b004
Gitweb:     https://git.kernel.org/tip/8fa25f303adfed6eab921db8e242e59dd0b3b004
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 7 Aug 2018 15:10:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:57 -0300

perf bpf: Add wrappers to BPF_FUNC_probe_read(_str) functions

Will be used shortly in the augmented syscalls work together with a
PERF_COUNT_SW_BPF_OUTPUT software event to insert syscalls + pointer
contents in the perf ring buffer, to be consumed by 'perf trace'
beautifiers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ajlkpz4cd688ulx1u30htkj3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 1f632b56bb34..47897d65e799 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -30,4 +30,7 @@ struct bpf_map {
 char _license[] SEC("license") = #name; \
 int _version SEC("version") = LINUX_VERSION_CODE;
 
+static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
+static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
+
 #endif /* _PERF_BPF_H */
