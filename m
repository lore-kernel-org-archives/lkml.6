Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E6FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E2620861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLsfMKx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E2620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeIFChc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:31 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91AF22073D;
        Wed,  5 Sep 2018 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185119;
        bh=CGjFpsI40/cdUq9brOcMxZyq1NqJDr1yQcZ/TtayN7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLsfMKx0cDTnWP6B212LL2Hy6aX3rIR8VPT/jbNpeZkiTHI+Fg5AAl4iqA4CgKewL
         A5N5Z+iqYq7KYR3f+ZKDR7eyjebwqM8AaFpWtL/2PLxg51nhg/fFlwbXUuGq4wSA2D
         7LWBksmP+wBPsML3CcEjQPtunBjt1+XCedbjRE/E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 10/77] perf trace: Augment 'newstat' (aka 'stat') filename ptr
Date:   Wed,  5 Sep 2018 19:03:33 -0300
Message-Id: <20180905220440.20256-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This one will need some more work, that 'statbuf' pointer requires a
beautifier in 'perf trace'.

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
     0.000 weechat/3596 stat(filename: /etc/localtime, statbuf: 0x7ffd87d11f60)
     0.186 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_stat/format)
     0.279 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_newstat/for)
     0.670 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/form)
    60.805 DNS Res~er #20/21308 stat(filename: /etc/resolv.conf, statbuf: 0x7ffa733fe4a0)
    60.836 DNS Res~er #20/21308 open(filename: /etc/hosts, flags: CLOEXEC)
    60.931 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_open/format)
   607.070 DNS Res~er #21/29812 stat(filename: /etc/resolv.conf, statbuf: 0x7ffa5e1fe3f0)
   607.098 DNS Res~er #21/29812 open(filename: /etc/hosts, flags: CLOEXEC)
   999.336 weechat/3596 stat(filename: /etc/localtime, statbuf: 0x7ffd87d11f60)
^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4lhabe7m4uzo76lnqpyfmnvk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index e8486e8597de..a9695c7f7aab 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -83,4 +83,15 @@ struct syscall_enter_inotify_add_watch_args {
 
 augmented_filename_syscall_enter(inotify_add_watch);
 
+struct statbuf;
+
+struct syscall_enter_newstat_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	char		   *filename_ptr;
+	struct stat	   *statbuf;
+};
+
+augmented_filename_syscall_enter(newstat);
+
 license(GPL);
-- 
2.14.4

