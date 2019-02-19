Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F024C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F8B21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfBSSib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:38:31 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:45091 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbfBSSib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:38:31 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 443qHm52dRz1yR3;
        Tue, 19 Feb 2019 19:38:28 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.0.253
Received: from fau.de (faustud-010-021-000-253.pool.uni-erlangen.de [10.21.0.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19wq74C0ZhIS+6Mq4C7vw+vXlrt+yZ+b6U=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 443qHk4cHGz1yK0;
        Tue, 19 Feb 2019 19:38:26 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf evsel: add support for inlined function in callchains
Date:   Tue, 19 Feb 2019 19:38:08 +0100
Message-Id: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
sample__fprintf_callchain currently did not use the already available
code to get the symbols of an inlined function if such information is
available in a dso. This patchset adds the required logic to add
appropriate lines.

As I am quite new to the code base of perf I am not sure how to test
that changeset in a correct way. At least the codes builds and the tools
that make use of sample__fprintf_callchain (perf-script, perf-trace and
perf-sched as far as I can see) did not fail to run - also I did not get
into the details of perf-trace and perf-sched as I have never used them
before.

Another thing I am not sure how to deal with are some warnings of
checkpatch.pl due to the 80 character line limit. Due to the long
function names in use the current implementation already exceeded that
limit in the same spots by even more characters as I have taken the
inner loop and put it into a separate function.

I hope to expand my work to perf-report but thought it might be usefull
to get already early feedback on those patches.

Thank you,
 Jonas

Jonas Rabenstein (2):
  perf evsel: split sample__fprintf_callchain in output and iteration
  perf evsel: add inline functions to sample callchain output

 tools/perf/util/evsel_fprintf.c | 157 ++++++++++++++++++++++----------
 1 file changed, 109 insertions(+), 48 deletions(-)

-- 
2.19.2

