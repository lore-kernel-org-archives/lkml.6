Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22695C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77DD20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865647;
	bh=VcGRO69DTcXTXeDpgRygJi87rFm2r1YlP4RemevTHp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jRJXrhP2eyKjFyB9bSq5ew2YVAASkzQ4L3X9n9OENVnMYItUgSJ18QoZmWWe75usT
	 /tq6ILcfZN9ErnSX8CRbJOeXoHoJXEoN9kdbiCiebpz7Wa6b3NWZUx+c2GvfiS/UPF
	 te16PWQwK5qO7bLGiSxb4A1l3JeAl6r7jH909DQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfAGMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfAGMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:54:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791B420665;
        Mon,  7 Jan 2019 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865643;
        bh=VcGRO69DTcXTXeDpgRygJi87rFm2r1YlP4RemevTHp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zbIBcmoFpQ9ZKf4FLc51o7K2+MMnP62BI2D6W8OqQP88ntSvwbYoErXD3zHdyd6n7
         Cflv/MoJ9emBXpoHP1nx9y+cg2hqGUFc/+PRn1nofV6yJECqA3u0im0WWFt4mgSsTL
         Tp1t007DfHQGtGFN+7a0SIiBBQ2UHpasVjn1jHaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 101/170] perf tools: Use fallback for sample_addr_correlates_sym() cases
Date:   Mon,  7 Jan 2019 13:32:08 +0100
Message-Id: <20190107104504.931906677@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 225f99e0c811e23836c4911a2ff147e167dd1fe8 upstream.

thread__resolve() is used in the sample_addr_correlates_sym() cases
where 'addr' is a destination of a branch which does not necessarily
have the same cpumode as the 'ip'. Use the fallback function in that
case.

This patch depends on patch "perf tools: Add fallback functions for
cases where cpumode is insufficient".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/20181106210712.12098-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1705,7 +1705,7 @@ bool sample_addr_correlates_sym(struct p
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_map(thread, sample->cpumode, sample->addr, al);
+	thread__find_map_fb(thread, sample->cpumode, sample->addr, al);
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;


