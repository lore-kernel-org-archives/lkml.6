Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F87C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50BE214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50BE214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeKNSVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:21:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727595AbeKNSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:21:47 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAE8EthA052255
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:19:36 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nrcqh2d05-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:19:35 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 14 Nov 2018 08:19:33 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Nov 2018 08:19:27 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAE8JQUJ29032602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 08:19:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E0104203F;
        Wed, 14 Nov 2018 08:19:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CF5E42045;
        Wed, 14 Nov 2018 08:19:23 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.35.26])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Nov 2018 08:19:23 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Date:   Wed, 14 Nov 2018 13:49:21 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18111408-0008-0000-0000-000002929051
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111408-0009-0000-0000-000021FCA416
Message-Id: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a kernel crash with delayed_uprobe_remove():
  https://lkml.org/lkml/2018/11/1/1244

Backtrace mentioned in the link points to a race between process
exit and uprobe_unregister(). Fix it by locking delayed_uprobe_lock
before calling delayed_uprobe_remove() from put_uprobe().

Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 96fb51f3994f..e527c4753d4f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
 		 * gets called, we don't get a chance to remove uprobe from
 		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
 		 */
+		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
+		mutex_unlock(&delayed_uprobe_lock);
 		kfree(uprobe);
 	}
 }
-- 
2.19.1

