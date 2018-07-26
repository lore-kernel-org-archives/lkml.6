Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C382083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C382083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeGZMLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:11:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729097AbeGZMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:11:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6QAs819140633
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:55:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kfbc544qm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:55:11 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 26 Jul 2018 11:55:09 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 11:55:06 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6QAt5sI23330940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Jul 2018 10:55:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 768E1A4040;
        Thu, 26 Jul 2018 13:55:19 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A38CA4055;
        Thu, 26 Jul 2018 13:55:18 +0100 (BST)
Received: from localhost.localdomain (unknown [9.195.22.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 13:55:18 +0100 (BST)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        jolsa@redhat.com, ravi.bangoria@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH] perf tests: Fix complex event name parsing
Date:   Thu, 26 Jul 2018 16:25:02 +0530
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18072610-0028-0000-0000-000002E083F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072610-0029-0000-0000-000023987512
Message-Id: <20180726105502.31670-1-sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807260116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'umask' event parameter is unsupported on some architectures
like powerpc64.

This can be observed on a powerpc64le system running Fedora 27 as
shown below.

  # perf test "Parse event definition strings" -v
   6: Parse event definition strings                        :
  --- start ---
  test child forked, pid 45915
  ...
  running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'Invalid event/parameter 'umask'
  Invalid event/parameter 'umask'
  failed to parse event 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp', err 1, str 'unknown term'
  event syntax error: '..,event=0x2,umask=0x3/ukp'
                                    \___ unknown term

  valid terms: event,mark,pmc,cache_sel,pmcxsel,unit,thresh_stop,thresh_start,combine,thresh_sel,thresh_cmp,sample_mode,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,no-overwrite,overwrite,driver-config

  mem_access -> cpu/event=0x10401e0/
  running test 0 'config=10,config1,config2=3,umask=1'
  test child finished with 1
  ---- end ----
  Parse event definition strings: FAILED!

Fixes: 055f839c5ef0 ("perf tests: Check that complex event name is parsed correctly")
Suggested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/perf/tests/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a36313daec4e..3b97ac018d5a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1690,7 +1690,7 @@ static struct evlist_test test__events_pmu[] = {
 		.id    = 2,
 	},
 	{
-		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp",
+		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.check = test__checkevent_complex_name,
 		.id    = 3,
 	}
-- 
2.14.4

