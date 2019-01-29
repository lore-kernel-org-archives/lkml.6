Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9869EC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E022147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfA2N1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:27:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727808AbfA2N1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:27:01 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TDQvIn019951
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:26:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qaqcv19wr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:26:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Tue, 29 Jan 2019 13:26:54 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 13:26:52 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TDQoGV53018870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 13:26:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E294BA405C;
        Tue, 29 Jan 2019 13:26:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 483B5A405B;
        Tue, 29 Jan 2019 13:26:49 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jan 2019 13:26:49 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Tue, 29 Jan 2019 15:26:48 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Nider <joeln@il.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: add get_user_pages_remote_longterm function
Date:   Tue, 29 Jan 2019 15:26:22 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012913-0016-0000-0000-0000024D50D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012913-0017-0000-0000-000032A753ED
Message-Id: <1548768386-28289-2-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the RDMA reg_remote_mr function, we must have the
ability to get memory pages for an indeterminate amount of time from
a remote process. In this case, 'remote' simply means a process that is
different from the caller. Functions for getting longterm pages
(get_user_pages_longterm) and remote pages (get_user_pages_remote)
already exist - this new function combines the functionality of both
of them.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm.h | 28 +++++++++++++++++++++++++---
 mm/gup.c           | 15 ++++++++++-----
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80bb640..1f5c72472 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1537,9 +1537,21 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
 #ifdef CONFIG_FS_DAX
-long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
-			    unsigned int gup_flags, struct page **pages,
-			    struct vm_area_struct **vmas);
+long get_user_pages_remote_longterm(struct task_struct *tsk,
+			    struct mm_struct *mm, unsigned long start,
+			    unsigned long nr_pages, unsigned int gup_flags,
+			    struct page **pages, struct vm_area_struct **vmas);
+
+static inline long get_user_pages_longterm(unsigned long start,
+					   unsigned long nr_pages,
+					   unsigned int gup_flags,
+					   struct page **pages,
+					   struct vm_area_struct **vmas)
+{
+	return get_user_pages_remote_longterm(current, current->mm, start,
+					      nr_pages, gup_flags, pages,
+					      vmas);
+}
 #else
 static inline long get_user_pages_longterm(unsigned long start,
 		unsigned long nr_pages, unsigned int gup_flags,
@@ -1547,6 +1559,16 @@ static inline long get_user_pages_longterm(unsigned long start,
 {
 	return get_user_pages(start, nr_pages, gup_flags, pages, vmas);
 }
+
+static inline long get_user_pages_remote_longterm(struct task_struct *tsk,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long nr_pages, unsigned int gup_flags,
+		struct page **pages, struct vm_area_struct **vmas)
+{
+	return get_user_pages_remote(tsk, mm, start, nr_pages,
+		gup_flags, pages, vmas);
+}
+
 #endif /* CONFIG_FS_DAX */
 
 int get_user_pages_fast(unsigned long start, int nr_pages, int write,
diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e..bcfe5a6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1139,9 +1139,11 @@ EXPORT_SYMBOL(get_user_pages);
  * "longterm" == userspace controlled elevated page count lifetime.
  * Contrast this to iov_iter_get_pages() usages which are transient.
  */
-long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
-		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas_arg)
+long get_user_pages_remote_longterm(struct task_struct *tsk,
+			    struct mm_struct *mm, unsigned long start,
+			    unsigned long nr_pages, unsigned int gup_flags,
+			    struct page **pages,
+			    struct vm_area_struct **vmas_arg)
 {
 	struct vm_area_struct **vmas = vmas_arg;
 	struct vm_area_struct *vma_prev = NULL;
@@ -1157,7 +1159,9 @@ long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
 			return -ENOMEM;
 	}
 
-	rc = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+	rc = __get_user_pages_locked(tsk, mm, start, nr_pages,
+				     pages, vmas, NULL,
+				     gup_flags | FOLL_TOUCH | FOLL_REMOTE);
 
 	for (i = 0; i < rc; i++) {
 		struct vm_area_struct *vma = vmas[i];
@@ -1187,7 +1191,8 @@ long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
 		kfree(vmas);
 	return rc;
 }
-EXPORT_SYMBOL(get_user_pages_longterm);
+EXPORT_SYMBOL(get_user_pages_remote_longterm);
+
 #endif /* CONFIG_FS_DAX */
 
 /**
-- 
2.7.4

