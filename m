Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22858C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801CE2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801CE2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeJPTFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:05:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726595AbeJPTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:05:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GB4TEc104879
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:15:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n5edhsmdx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:15:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Tue, 16 Oct 2018 12:15:33 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Oct 2018 12:15:30 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9GBFTaU1900946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Oct 2018 11:15:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 971A1A4059;
        Tue, 16 Oct 2018 14:14:59 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70DD7A404D;
        Tue, 16 Oct 2018 14:14:59 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Oct 2018 14:14:59 +0100 (BST)
Date:   Tue, 16 Oct 2018 13:15:28 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: dcache endless loop in d_invalidate
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18101611-0008-0000-0000-000002802043
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101611-0009-0000-0000-000021E97FE2
Message-Id: <20181016131528.6aac4876@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I am currently looking into a customer dump and found what looks like
an issue in the dcache code. And I think the following commit of yours
has something to do with it:

commit fe91522a7ba82ca1a51b07e19954b3825e4aaa22
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat May 3 00:02:25 2014 -0400

    don't remove from shrink list in select_collect()

            If we find something already on a shrink list, just increment
    data->found and do nothing else.  Loops in shrink_dcache_parent() and
    check_submounts_and_drop() will do the right thing - everything we
    did put into our list will be evicted and if there had been nothing,
    but data->found got non-zero, well, we have somebody else shrinking
    those guys; just try again.

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

The dump I got is based on kernel v4.4 but the affected dcache functions
look identical to the upstream version. Here is what I found in the dump:

A lot of "rcu_sched kthread starved for <xxx> jiffies!" messages
Only one CPU, currently running process "run-crons" task 0x65a8008
It just called check_and_drop from d_walk, full backchain:

    PSW.addr   check_and_drop at 30a0e8
    %r14       d_walk at 308202
 #0 [35b87b88] d_invalidate at 3096e8
 #1 [35b87bd8] proc_flush_task at 37190c
 #2 [35b87c58] release_task at 13f202
 #3 [35b87cc8] wait_task_zombie at 13fc36
 #4 [35b87d50] wait_consider_task at 140150
 #5 [35b87dc0] do_wait at 1403de
 #6 [35b87e18] sys_wait4 at 14181e
 #7 [35b87ea8] system_call at 659ec4

Tasks runtime is
  sum_exec_runtime 26813717162347 # nsec = 26813 seconds,
  utime = 3991252 # cputime = 974 seconds,
  stime = 99132516783832 # cputime = 24202 seconds,
Task 0x65a8008 has TIF_NEED_RESCHED set

d_walk() just called check_and_drop via the finish() function pointer,
check_and_drop() will return and d_walk() will return as well.
Look like an endless loop in d_invalidate().

The (struct dentry *) dentry in d_invalidate() is at 0x3cb15858
The struct detach_data data in d_invalidate() is at 0x35b87c28

dentry tree starting @ 0x3cb15858 has two entries in d_subdirs:
0x3cb15858  d_name.name: "11898"
        0xb940d3d8 d_name.name: "cmdline"
        0xb940dd98 d_name.name: "status"

crash> px *(struct dentry *) 0x3cb15858 | grep d_flags
  d_flags = 0x2000cc,

crash> px *(struct dentry *) 0xb940d3d8 | grep d_flags
  d_flags = 0x48048c,  # DCACHE_SHRINK_LIST is set

crash> px *(struct dentry *) 0xb940dd98 | grep d_flags
  d_flags = 0x48048c,  # DCACHE_SHRINK_LIST is set

crash> px *(struct detach_data *) 0x35b87c28
$29 = {
  select = {
    start = 0x3cb15858,
    dispose = {
      next = 0x35b87c30,
      prev = 0x35b87c30
    },
    found = 0x2
  },
  mountpoint = 0x0
}

select_collect() called from detach_and_collect() will increment
data.select.found in the struct detach_data @ 0x35b87c28 but will not
add any dentries to the dispose lists. The shrink_dentry_list() call in
d_invalidate() will do nothing as the dispose list is empty. The two
dentries 0xb940d3d8 and 0xb940dd98 are still there. After d_walk returns
d_invalidate() finds data.mountpoint == NULL and data.select.found == 2,
it will start the loop again without progress.

As this is a single CPU system without kernel preemption there is nobody
else that will do the shrinking of those dcache entries.

In short, this if-statement in select_collect:

        if (dentry->d_flags & DCACHE_SHRINK_LIST) {
                data->found++;
        }

with assumption that "somebody else" will do the shrinking seems broken.

Do you agree?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

