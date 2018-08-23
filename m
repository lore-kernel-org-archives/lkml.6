Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1FEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008712077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008712077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbeHWMSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:18:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbeHWMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:18:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 470FBC93;
        Thu, 23 Aug 2018 08:49:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 119/324] perf script: Fix crash because of missing evsel->priv
Date:   Thu, 23 Aug 2018 09:53:05 +0200
Message-Id: <20180823075001.870821352@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

[ Upstream commit a3af66f51bd0bca72881ead4bf2bd19cb366582b ]

'perf script' in piped mode is crashing because evsel->priv is not set
properly. Fix it.

Before:

  # perf record -o - -- ls | perf script
  <SNIP 'ls' output>
    Segmentation fault (core dumped)
  #

After:

  # perf record -o - -- ls | perf script
  <SNIP 'ls' output>
  ls 2282 1031.731974:  250000 cpu-clock:uhH:  7effe4b3d29e
  ls 2282 1031.732222:  250000 cpu-clock:uhH:  7effe4b3a650
  #

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: a14390fde64e ("perf script: Allow creating per-event dump files")
Link: http://lkml.kernel.org/r/20180625124220.6434-3-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-script.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1832,6 +1832,7 @@ static int process_attr(struct perf_tool
 	struct perf_evlist *evlist;
 	struct perf_evsel *evsel, *pos;
 	int err;
+	static struct perf_evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -1840,6 +1841,19 @@ static int process_attr(struct perf_tool
 	evlist = *pevlist;
 	evsel = perf_evlist__last(*pevlist);
 
+	if (!evsel->priv) {
+		if (scr->per_event_dump) {
+			evsel->priv = perf_evsel_script__new(evsel,
+						scr->session->data);
+		} else {
+			es = zalloc(sizeof(*es));
+			if (!es)
+				return -ENOMEM;
+			es->fp = stdout;
+			evsel->priv = es;
+		}
+	}
+
 	if (evsel->attr.type >= PERF_TYPE_MAX &&
 	    evsel->attr.type != PERF_TYPE_SYNTH)
 		return 0;


