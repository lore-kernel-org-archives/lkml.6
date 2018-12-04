Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E339720834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oEFgOgPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E339720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeLDXHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:07:13 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47282 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:07:13 -0500
X-Greylist: delayed 2698 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 18:07:12 EST
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB4MIdkX143931;
        Tue, 4 Dec 2018 22:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=DAcXMg5FCgSfK6akLVgZURROrTpZFq44VKr6jiMn+SE=;
 b=oEFgOgPs3Gsxb5txO2o2x5INortFcn2AvFYp7fRhDG2R84OEzPuBIm7tiyA3Ng6dFNj5
 grHwDLFG5gamtsROL8h2fIsUDY4QBYNPM01OpWF9rm1ARuA2FRbSy9jKOBC2UCZX9YKy
 q1R320A9dzT3H7799ZxOuQTOJEYZNBuS243Av7aGG77ZlPhGIZV6vQDFiHLVaboF4Lv+
 hJJFkV3DzXmyBnlDFG/4ky4xI22Rt9nDhsE21Qzn2DaGrp7SXJhols8pvRG4q+bYqFkb
 kp1/1gKHBI0/c6M2eob9vJo30FvdHNXq9CWYdUy4lJ/DFoa+82yhG1VlzpVUkQQFIgSX Ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2p3ftf350u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 22:21:41 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB4MLeHm000655
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 22:21:40 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB4MLduo004401;
        Tue, 4 Dec 2018 22:21:39 GMT
Received: from ayz-linux.us.oracle.com (/10.39.194.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 22:21:38 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, chansen3@cisco.com,
        n-horiguchi@ah.jp.nec.com, vbabka@suse.cz, willy@infradead.org,
        rientjes@google.com
Subject: [PATCH] tools/vm/page-types.c: fix "kpagecount returned fewer pages than expected" failures
Date:   Tue,  4 Dec 2018 14:24:29 -0800
Message-Id: <1543962269-26116-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=696
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because kpagecount_read() fakes success if map counts are not being
collected, clamp the page count passed to it by walk_pfn() to the pages
value returned by the preceding call to kpageflags_read().

Fixes: 7f1d23e60718 ("tools/vm/page-types.c: include shared map counts")
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 tools/vm/page-types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index 37908a83ddc2..1ff3a6c0367b 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -701,7 +701,7 @@ static void walk_pfn(unsigned long voffset,
 		if (kpagecgroup_read(cgi, index, pages) != pages)
 			fatal("kpagecgroup returned fewer pages than expected");
 
-		if (kpagecount_read(cnt, index, batch) != pages)
+		if (kpagecount_read(cnt, index, pages) != pages)
 			fatal("kpagecount returned fewer pages than expected");
 
 		for (i = 0; i < pages; i++)
-- 
1.8.3.1

