Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBA5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F622152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Xj2INVLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F622152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeHOT5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:57:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729381AbeHOT5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:57:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w7FGx0s8009716
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=CWnq+KatPzLeFpt0o44za0A0VDy0DW9TRis+GHGHmGI=;
 b=Xj2INVLhx68kgdIPCxTUVau7i0g5Vtpw1ZVV4QtpwCKmak8psaKGIZqR14b3c1pFWHs3
 kL++myySewwYoh0naKMksd770iMBrAeNVkkI4EJVQGXmyAhpR8mtqHlsF3m5YwkZeVlI
 /Hqexu1pVuLOz6nfZ3PlqpoZ5rHdsKa5xOM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2kvcrd1h9s-14
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:04:01 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.19) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 15 Aug
 2018 10:03:42 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)    id
 5570A62E0F73; Wed, 15 Aug 2018 10:03:40 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <lkp@intel.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 0/1] perf: Sharing PMU counters across compatible events
Date:   Wed, 15 Aug 2018 10:03:12 -0700
Message-ID: <20180815170313.455943-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>

Song Liu (1):
  perf: Sharing PMU counters across compatible events

 include/linux/perf_event.h |  61 ++++++++
 kernel/events/core.c       | 289 +++++++++++++++++++++++++++++++++++--
 2 files changed, 340 insertions(+), 10 deletions(-)

--
2.17.1
