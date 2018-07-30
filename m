Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D43FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00DF20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00DF20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeG3H7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:59:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbeG3H7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:59:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6U6JXb3103827
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 02:26:27 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2khv5ejk24-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 02:26:27 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 30 Jul 2018 07:26:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 07:26:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6U6QJd936372526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 06:26:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54A4611C058;
        Mon, 30 Jul 2018 09:26:31 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EDDF11C066;
        Mon, 30 Jul 2018 09:26:29 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.125])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jul 2018 09:26:28 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 30 Jul 2018 09:26:16 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+121be635a7a35ddb7dcb@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH RESEND] userfaultfd: remove uffd flags from vma->vm_flags if UFFD_EVENT_FORK fails
Date:   Mon, 30 Jul 2018 09:26:15 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18073006-0028-0000-0000-000002E23C77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073006-0029-0000-0000-0000239A3BD6
Message-Id: <1532931975-25473-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix in commit 0cbb4b4f4c44 ("userfaultfd: clear the
vma->vm_userfaultfd_ctx if UFFD_EVENT_FORK fails") cleared the
vma->vm_userfaultfd_ctx but kept userfaultfd flags in vma->vm_flags that
were copied from the parent process VMA.

As the result, there is an inconsistency between the values of
vma->vm_userfaultfd_ctx.ctx and vma->vm_flags which triggers BUG_ON in
userfaultfd_release().

Clearing the uffd flags from vma->vm_flags in case of UFFD_EVENT_FORK
failure resolves the issue.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reported-by: syzbot+121be635a7a35ddb7dcb@syzkaller.appspotmail.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/userfaultfd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 594d192b2331..bad9cea37f12 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -633,8 +633,10 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		down_write(&mm->mmap_sem);
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
-			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx)
+			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+			}
 		up_write(&mm->mmap_sem);
 
 		userfaultfd_ctx_put(release_new_ctx);
-- 
2.7.4

