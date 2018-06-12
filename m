Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DBDC5C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E26620891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ouVSw+kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E26620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeFLSAD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:00:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbeFLSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:00:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CHvTgl080387;
        Tue, 12 Jun 2018 17:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=KSdKs3acEk+SOxMTWUF+oVzQ/Ni6BVNs7oqme0eMarE=;
 b=ouVSw+kNnoYuKePEVGZjfydu2Y3YJv6hIlem8lurbVGGFe6ufLRAREWe2shEHhZ/X5uZ
 AmeOfYnbz+7NNIKPz30/BMNcc2sBr2gwsp60jEVo6Y7v5+hibdJqY0SWcHnMLWzR7zFd
 gxQGe4NsAWoD5X6ujiIx3BqJqzLwu6bytXcfisVBtSFNXf5Js1XmDiORt31NWWC/FE5z
 a3QQeYNR7zMs4SwoY673ThTkNHrkUU2wJi3GHqv8v9180zvypDFrkmkh+pMJbWxWiOOn
 EDcpCrOZD0/FLVU1GlPhUNRaZ5wnjdaU1Cb2wPxQLbToCo5ze7wRCrEE/WbaE3Dt0I5x Lw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jg6b1k68p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:59:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CHxuTj027082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:59:56 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CHxu4i029558;
        Tue, 12 Jun 2018 17:59:56 GMT
Received: from zissou.us.oracle.com (/10.152.34.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 10:59:55 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     akpm@linux-foundation.org
Cc:     ying.huang@intel.com, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com
Subject: [PATCH] mm, swap: fix swap_count comment about nonexistent SWAP_HAS_CONT
Date:   Tue, 12 Jun 2018 13:59:19 -0400
Message-Id: <20180612175919.30413-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

570a335b8e22 ("swap_info: swap count continuations") introduces
COUNT_CONTINUED but refers to it incorrectly as SWAP_HAS_CONT in a
comment in swap_count.  Fix it.

Fixes: 570a335b8e22 ("swap_info: swap count continuations")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 744d66666f82..808349ee6f6f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -101,7 +101,7 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
 static inline unsigned char swap_count(unsigned char ent)
 {
-	return ent & ~SWAP_HAS_CACHE;	/* may include SWAP_HAS_CONT flag */
+	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
 }
 
 /* returns 1 if swap entry is freed */
-- 
2.17.0

