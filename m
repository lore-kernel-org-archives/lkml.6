Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD28C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663E820818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iX4Jfbx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfBUWVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:21:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38054 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUWVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:21:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LMJ0R4018055;
        Thu, 21 Feb 2019 22:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=nVKe44f2CLyy8KwCGeAW+5vhPvxVUYCV7yyDYL/xjV8=;
 b=iX4Jfbx4mvEtjGSFBt0o018sKkwjWE2E9ISK1CPIL2JPIMYJ5YDLvhdEBjlJ+YiXxqwb
 0gUwpKYVGv/q1SXUxYKDjWmsXn7FhDgdJ3/ACkoMDMEZ3NvZYUb2ltyDrd3R5RlfhHdt
 +SZrJwzAhaz0W/fT9Wb3RQrSzTKl8Pm9sxTUi1BKBVozHGZyKMD57dO3FwBwXWS7Yvqu
 tsTPj2CAO0HELevCKd/4gEM49QC9qyssQ6q1sPQcUqP4WxBc/7o+9488rLlgwrr2JQ5S
 aUlI2ul4eU3dqyZm+IjXsYQGKZa6rmmjN0ubUXIlwqUQe9KEgRI37iM0bhyL9ioCJA7k Ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81ekbn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 22:21:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LMLPwQ018408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 22:21:25 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1LMLPCf010939;
        Thu, 21 Feb 2019 22:21:25 GMT
Received: from localhost (/10.145.178.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 14:21:25 -0800
Date:   Thu, 21 Feb 2019 14:21:24 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] tmpfs: fix uninitialized return value in shmem_link
Message-ID: <20190221222123.GC6474@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

When we made the shmem_reserve_inode call in shmem_link conditional, we
forgot to update the declaration for ret so that it always has a known
value.  Dan Carpenter pointed out this deficiency in the original patch.

Fixes: "tmpfs: fix link accounting when a tmpfile is linked in"
Reported-by: dan.carpenter@oracle.com
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0905215fb016..2c012eee133d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2848,7 +2848,7 @@ static int shmem_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	int ret;
+	int ret = 0;
 
 	/*
 	 * No ordinary (disk based) filesystem counts links as inodes;
