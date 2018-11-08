Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2EFECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1482147A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeZaPn/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1482147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeKIHdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbeKIHdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:41 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6F321104;
        Thu,  8 Nov 2018 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714173;
        bh=HRT0bCCN9wABFP7MvpsVPJAKwFcOpA3aeaP4+cqP/p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeZaPn/BITZthm7IPOw94hk9b0sq2VmnFMmNeSIHm3kOEa2FFDl6ePrHerkNyReWK
         kXnw3DwtXi07XjB2Yhkk/9K3vluYmUJHpOtHxL6N1WK8wkF0i3yjEWY0Rumct9dZqn
         l9nAG2BTiOVjtLdH6h6DdHXPipDNe8u3rFVQurF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vinson Lee <vlee@twitter.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 097/144] perf bench numa: Fix to show proper convergence stats
Date:   Thu,  8 Nov 2018 13:51:08 -0800
Message-Id: <20181108215104.660939658@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2b42b09b88c831ba4da2d669581dde371c38c2af ]

With commit: e1e455f4f4d3 (perf tools: Work around lack of sched_getcpu
in glibc < 2.6), perf_bench numa mem with -c or -m option is not able to
correctly calculate convergence.

With the above commit, sched_getcpu always seems to return -1. The
intention of commit e1e455f was to add a sched_getcpu in glibc < 2.6.
Hence keep the sched_getcpu definition under an ifdef.

This regression happened occurred between v4.0 and v4.1

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vinson Lee <vlee@twitter.com>
Fixes:  e1e455f4f4d3 ("perf tools: Work around lack of sched_getcpu in glibc < 2.6")
Link: http://lkml.kernel.org/r/20150624111004.GA5220@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cloexec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 85b523885f9d..2babddaa2481 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,11 +7,15 @@
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
 
+#ifdef __GLIBC_PREREQ
+#if !__GLIBC_PREREQ(2, 6)
 int __weak sched_getcpu(void)
 {
 	errno = ENOSYS;
 	return -1;
 }
+#endif
+#endif
 
 static int perf_flag_probe(void)
 {
-- 
2.17.1



