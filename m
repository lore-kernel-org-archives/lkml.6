Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB2C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5512146F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788971;
	bh=FzFZP16ho17kgrSDolqrJ7unx6SjpmR8KxC/Nlmdn64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0PzvXlaiaEZ0i/XNeyv7F3BqDiJAx4ebRuF6OTb/Fgdwzbov4gHQNZa6fyFECH/QE
	 bP983i+6HporvGrW3QuAbRc02jmSDaFwo2nuuXiAiBIUlw6TeaUu0PfHKmjbhGOq58
	 LocX/MUcXZ2O3Bhsyq9huWVXBtzNGCMGwgZj25aI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5512146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbeLNMCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbeLNMCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC32E2145D;
        Fri, 14 Dec 2018 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788966;
        bh=FzFZP16ho17kgrSDolqrJ7unx6SjpmR8KxC/Nlmdn64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDKwEPfYBZJx32d6lGT8MB6XFcVObslGCh9uJ80IXAF4yhGcgEg5BnVeiia11IatE
         qWzN3TCM22iv403L6mA9JY9y9XBFHqMLd1TKdYBoxwudp8O00T/epe6iEWB51kQvZi
         GQGDPd2Ipp+/n4+n+xWojtbThg8qX7vS6hujGOio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yongxin Liu <yongxin.liu@outlook.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adam Lee <leeadamrobert@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/142] perf tools: Fix crash on synthesizing the unit
Date:   Fri, 14 Dec 2018 12:58:46 +0100
Message-Id: <20181214115748.694920023@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit fb50c09e923870a358d68b0d58891bd145b8d7c7 ]

Adam reported a record command crash for simple session like:

  $ perf record -e cpu-clock ls

with following backtrace:

  Program received signal SIGSEGV, Segmentation fault.
  3543            ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
  (gdb) bt
  #0  perf_event__synthesize_event_update_unit
  #1  0x000000000051e469 in perf_event__synthesize_extra_attr
  #2  0x00000000004445cb in record__synthesize
  #3  0x0000000000444bc5 in __cmd_record
  ...

We synthesize an update event that needs to touch the evsel id array,
which is not defined at that time. Fix this by forcing the id allocation
for events with their unit defined.

Reflecting possible read_format ID bit in the attr tests.

Reported-by: Yongxin Liu <yongxin.liu@outlook.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adam Lee <leeadamrobert@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201477
Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")
Link: http://lkml.kernel.org/r/20181112130012.5424-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/attr/base-record | 2 +-
 tools/perf/util/evsel.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 37940665f736..efd0157b9d22 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -9,7 +9,7 @@ size=112
 config=0
 sample_period=*
 sample_type=263
-read_format=0
+read_format=0|4
 disabled=1
 inherit=1
 pinned=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 03a72310315f..e7dbdcc8d465 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1088,7 +1088,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->own_cpus)
+	if (evsel->own_cpus || evsel->unit)
 		evsel->attr.read_format |= PERF_FORMAT_ID;
 
 	/*
-- 
2.19.1



