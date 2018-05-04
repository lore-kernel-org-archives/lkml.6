Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeEDXLP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:11:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751621AbeEDXLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:11:14 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        <tj@kernel.org>, <peterz@infradead.org>, <jolsa@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC 0/2] perf: Sharing PMU counters across compatible events
Date: Fri, 4 May 2018 16:11:00 -0700
Message-ID: <20180504231102.2850679-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to follow up earlier discussion on sharing hardware PMU counters
across compatible events: https://marc.info/?t=151213803600016

A lot of this set is based on Tejun's work. I also got a lot of ideas and
insights from Jiri's version.

The major effort in this version is to make perf event scheduling faster.
Specifically, all the operations on the critical paths have O(1) execution
time. Commit message of RFC 2/2 has more information about the data
structure we used for these operations.

RFC 1/2 is a prepare patch. It may become unnecessary if we introduce
virtual master later on.

RFC 2/2 has majority of the new data structure, and operations.

I have test this version on vm with tracepoint events. I also briefly
tested it on real hardware, where it shows sharing of perf events and
doesn't break too badly.

Please share your comments and suggestions. Is this on the right direction
of PMU counter sharing?

Thanks in advance.
Song

Song Liu (2):
  perf: add move_dup() for PMU sharing.
  perf: Sharing PMU counters across compatible events

 arch/x86/events/core.c          |   8 ++
 include/linux/perf_event.h      |  57 +++++++++
 include/linux/trace_events.h    |   3 +
 kernel/events/core.c            | 255 +++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace_event_perf.c |  11 ++
 5 files changed, 316 insertions(+), 18 deletions(-)

--
2.9.5
