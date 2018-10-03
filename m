Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86140C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3313521470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mMLIAyuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3313521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeJDETF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:19:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbeJDETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:19:05 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93LSeA7009158
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 14:28:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=XRMPap2lyTW7EN6rZerwBT5wzpP6n26wqMhRMT/JvUg=;
 b=mMLIAyuDGD2Ogx1VbqZX+wRKSHhbeFtxmgft0CoLrUFk4i9E1Cx16YX0DQStbYmP/PQd
 3l1QxbT4x/FvL6vUAlnPrgq3Lp3+qURir863dmj1GD8Go+9mr2TrsT8wxWAe2RHeqX4N
 Zt9oPKOpYblRkG1KOpBlB93LUFE5lJcgixc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mw3p3rehf-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 14:28:57 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.23) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 14:28:54 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)    id
 590AF62E13C5; Wed,  3 Oct 2018 14:28:51 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <ravi.bangoria@linux.ibm.com>,
        <naveen.n.rao@linux.vnet.ibm.com>, <maddy@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH/RFC v4 0/2] perf: Sharing PMU counters across compatible events
Date:   Wed, 3 Oct 2018 14:28:46 -0700
Message-ID: <20181003212848.412256-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Song Liu (2):
  perf: Sharing PMU counters across compatible events
  perf tools: monitoring per task counter with per cgroup event

 include/linux/perf_event.h |  61 ++++++++
 kernel/events/core.c       | 294 ++++++++++++++++++++++++++++++++++---
 tools/perf/builtin-stat.c  |  26 ++++
 tools/perf/util/cgroup.c   |  76 ++++++++++
 tools/perf/util/cgroup.h   |   5 +
 tools/perf/util/target.h   |   1 +
 6 files changed, 440 insertions(+), 23 deletions(-)

--
2.17.1
