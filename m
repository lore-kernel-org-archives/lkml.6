Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29CBC65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7441B20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fKDyTISD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJHDO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 23:14:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41256 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJHDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 23:14:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w97K6TBo083366;
        Sun, 7 Oct 2018 20:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=7pw3/7kwCmkhEsuBc97OJ7wZGfIYv641kGtb5eDPPjk=;
 b=fKDyTISDvRoN8NCIukfNJg/HBL0QPEOicXFZO113EM9lKXTw6Y99qQ6Xkr/0738Om+cb
 LSF5Tv76/bOb+UGYZki5PJnjsRR2UztOcDTd5cDXvh/ZULboasdLT8KP1ndsgVUruo0b
 gSMICnm0+WkgmtmbWog+kHhsKal9gJYuwta6DPXMvyqq28+hJCjUCcUvw6wu4ibZVSag
 Ti4OeSeiRYmrDJ0YiyQuJVkFJhWtEnWowF3DU73ckIHXN9pjEN/fFFrArw1gow4N8+WJ
 HdwWXeRPo04ggl85LpkQg+rM6mJk2EkP+0rRmnOTmFFZ6qf9kSXf1QP0uhpbFSlFrSaK aQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mxmftbaxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Oct 2018 20:06:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w97K6SIj021501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Oct 2018 20:06:29 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w97K6S0w023819;
        Sun, 7 Oct 2018 20:06:28 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Oct 2018 20:06:28 +0000
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] xen/balloon: Support xend-based toolstack
Date:   Sun,  7 Oct 2018 16:05:38 -0400
Message-Id: <20181007200538.19320-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9039 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=964
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810070205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xend-based toolstacks don't have static-max entry in xenstore. The
equivalent node for those toolstacks is memory_static_max.

Fixes: 5266b8e4445c (xen: fix booting ballooned down hvm guest)
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: <stable@vger.kernel.org> # 4.13
---
 drivers/xen/xen-balloon.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index 63c1494a8d73..2acbfe104e46 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -76,12 +76,15 @@ static void watch_target(struct xenbus_watch *watch,
 
 	if (!watch_fired) {
 		watch_fired = true;
-		err = xenbus_scanf(XBT_NIL, "memory", "static-max", "%llu",
-				   &static_max);
-		if (err != 1)
-			static_max = new_target;
-		else
+
+		if ((xenbus_scanf(XBT_NIL, "memory", "static-max",
+				  "%llu", &static_max) == 1) ||
+		    (xenbus_scanf(XBT_NIL, "memory", "memory_static_max",
+				  "%llu", &static_max) == 1))
 			static_max >>= PAGE_SHIFT - 10;
+		else
+			static_max = new_target;
+
 		target_diff = (xen_pv_domain() || xen_initial_domain()) ? 0
 				: static_max - balloon_stats.target_pages;
 	}
-- 
2.17.1

