Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9CEC6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52152088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jl+yxqVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52152088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeJHGsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:48:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52608 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJHGsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:48:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w97NYkjT030745;
        Sun, 7 Oct 2018 23:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=aCmsQNyRgqSu/ASYBs+TVQhB3o0ELTVPJmnIBQcjzy8=;
 b=Jl+yxqVRTAdAs2wpTEMzlbHe/75ha0vw4hbCBzjz4oQu6nm9UWJ7/Z2NKti1bofDdggm
 vjLzK6JM8aobd34YeJy4oLvkA+zSQj/fswxIfT4LAv/eYVrmGQVWJUx4376UwcOXAa15
 4RxTy06LH0Q7kHzlzTY8GOFyK2DCLkFs4jEwUbsNkgG23LeJe+C0kNa9iKOv4LUgtZnW
 2XEsGE+Udofbo0hlLk/9Jbj31EkraevyoyvnL1ysGmpyLyLogHwTNZsHaUkAEilqib4U
 YrRAAN10erNB3LllpPyFO4IcuFFZqfk96QlgFyOmmkXNVuT79L5WVnmQI804E/KM66ls yQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mxn0pkgym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Oct 2018 23:39:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w97Nd1vU018735
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Oct 2018 23:39:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w97Ncwsa032572;
        Sun, 7 Oct 2018 23:38:59 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Oct 2018 23:38:58 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC 0/1] hugetlbfs: fix truncate/fault races
Date:   Sun,  7 Oct 2018 16:38:47 -0700
Message-Id: <20181007233848.13397-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9039 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=295
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810070241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our DB team noticed negative hugetlb reserved page counts during development
testing.  Related meminfo fields were as follows on one system:

HugePages_Total:   47143
HugePages_Free:    45610
HugePages_Rsvd:    18446744073709551613
HugePages_Surp:        0
Hugepagesize:       2048 kB 

Code inspection revealed that the most likely cause were races with truncate
and page faults.  In fact, I could write a not too complicated program to
cause the races and recreate the issue.

Way back in 2006, Hugh Dickins created a patch (ebed4bfc8da8) with this
message:

"[PATCH] hugetlb: fix absurd HugePages_Rsvd
    
 If you truncated an mmap'ed hugetlbfs file, then faulted on the truncated
 area, /proc/meminfo's HugePages_Rsvd wrapped hugely "negative".  Reinstate my
 preliminary i_size check before attempting to allocate the page (though this
 only fixes the most obvious case: more work will be needed here)."

Looks like we need to do more work.

While looking at the code, there were many issues to correctly handle racing
and back out changes partially made.  Instead, why not just introduce a
rw mutex to prevent the races.  Page faults would take the mutex in read mode
to allow multiple faults in parallel as it works today.  Truncate code would
take the mutex in write mode and prevent faults for the duration of truncate
processing.  This seems almost too obvious.  Something must be wrong with this
approach, or others would have employed it earlier.

The following patch describes the current race in detail and adds the mutex
to prevent truncate/fault races.

Mike Kravetz (1):
  hugetlbfs: introduce truncation/fault mutex to avoid races

 fs/hugetlbfs/inode.c    | 24 ++++++++++++++++++++----
 include/linux/hugetlb.h |  1 +
 mm/hugetlb.c            | 25 +++++++++++++++++++------
 mm/userfaultfd.c        |  8 +++++++-
 4 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.17.1

