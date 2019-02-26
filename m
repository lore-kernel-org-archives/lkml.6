Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48639C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2A9218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VDDX7TG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfBZXGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:06:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728766AbfBZXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:06:32 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QN3whT020350
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:06:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=/gbpnX9u9rL2YVf5RIPzwy6B4ihQBl5h3dnM5IuO3bk=;
 b=VDDX7TG605qkefz9+X32PHeWsuVPFBoG8Fh5QRwrq/8hsGaCrEJ7pB335J4zKQF25Ogd
 zwEITe+LbcPjO1j1Ik/50R4JKFHKzi0ZkI5fEzhsCdPdnayS3HzEKmxNvwQ4hHwcbWj9
 h3gLh5eYVBnWHvqcC77u9C6wOkZBJfHiKHM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2qwbwp0nxh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:06:30 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 26 Feb 2019 15:06:29 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AE70062E2ADD; Tue, 26 Feb 2019 15:06:26 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <acme@redhat.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf 0/1] perf: Sharing PMU counters across compatible events
Date:   Tue, 26 Feb 2019 15:06:22 -0800
Message-ID: <20190226230623.3910393-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v4 -> v5:
  1. Rebase upon latest tip/perf/core.
  2. Remove prototype from v4 (2/2).

Changes v3 -> v4:
  1. In __perf_install_in_context() always reprogram ctx for cpu and cgroup
     events to make sure event duplications set up properly.
  2. Add a prototype (2/2) to show potential solution of sharing PMU among
     CPU events and task events.

Changes v2 -> v3:
  1. Simplified event_pmu_add() as Jiri Olsa suggested

Changes v1 -> v2:
  1. Fixed a bug reported by 0day kernel testing robot

This is to follow up earlier discussion on sharing hardware PMU counters
across compatible events:

  https://marc.info/?t=151213803600016
  https://marc.info/?t=152547569200001

This version limits PMU sharing to events within same ctx. As a result,
compatible events are not evaluated during task schedule. This vesion also
limits PMU sharing to hardware counting events. From our discussion with
internal users, this is sufficient for most cases.

This version introduces virtual master event. The virtual master event
does require careful handling. But it is makes the logic of event add/del
cleaner.

Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>

Song Liu (1):
  perf: Sharing PMU counters across compatible events

 include/linux/perf_event.h |  61 ++++++++
 kernel/events/core.c       | 294 ++++++++++++++++++++++++++++++++++---
 2 files changed, 332 insertions(+), 23 deletions(-)

--
2.17.1
