Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lfrpEloHG1uJPwAAmS7hNA
	; Fri, 08 Jun 2018 22:47:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57F44607E7; Fri,  8 Jun 2018 22:47:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gFWwr/kD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A639C601C3;
	Fri,  8 Jun 2018 22:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A639C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeFHWrK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:47:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36362 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753115AbeFHWrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:47:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58MdJdq005147
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 15:47:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=J2+SnbIirKnMYtBTAtJOqcbjTlwHCmdcvirwR2siEZs=;
 b=gFWwr/kDdhs3I+JtVkOUg7R+iknfTIcCoXB9yaakMnXt0Tyk1Qm301/s7n3KGnfiT1Zr
 MD1lBh/f/9hyTgDdyOPSW7HgYxhAx4DWVY4wV3RETkt8wquL0E/9I9NKnZH/z+NFJvjn
 M1ZBdsJ8L9aFWVhP5I0fs6LvCWWkJstHTYk=
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jg0kt8cq7-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:47:08 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.14) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Jun
 2018 15:47:07 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)    id
 EB6B762E0FD1; Fri,  8 Jun 2018 15:47:04 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf: Sharing PMU counters across compatible events
Date: Fri, 8 Jun 2018 15:46:51 -0700
Message-ID: <20180608224652.2140823-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This version has been stable in my tests.

Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>

Song Liu (1):
  perf: Sharing PMU counters across compatible events

 include/linux/perf_event.h |  61 ++++++++++
 kernel/events/core.c       | 284 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 335 insertions(+), 10 deletions(-)

--
2.9.5
