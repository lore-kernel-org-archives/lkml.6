Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067DC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244202150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="13RaEpHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244202150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIWCA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:00:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeIWCA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:00:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8MK4DxC069907;
        Sat, 22 Sep 2018 20:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=HjQEFozZzOKtU/pxThogFkZbHtcpTMfSXFOAXXJokok=;
 b=13RaEpHl6Tzt2w9R0yvd2l4LUYzBk+hAErxIXWGflgV7DOBxRufkSLA1kfIGa/qGo9jh
 PViGvaRBlJXwsj+ymrgfcTUAhSulY8x1/msKQsf3Yam3Ahw8mWr1fRZufVQlI2goqzV7
 oC4RY8Y6KmuaCatVhDoyDJz6yeuFPMQPVI7ZLy10Y3noBx3NQH8Vu6eG5EfBiRDHVicG
 g2PKIgdvO1FNNXQW+ENOVsispNCs1OCV1BMP3hDqvZ1HFjd+cWRR57F3FgxrkgqWzRns
 WiGTNc4sYFD5I6ASRdfb9CE7mGhjamKMW6mUWsx/ft9V9vysJYlQWWDX8DkrP0U8mOkr 7Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mnd5t19vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Sep 2018 20:05:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8MK5SVt005739
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Sep 2018 20:05:28 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8MK5QO9028384;
        Sat, 22 Sep 2018 20:05:26 GMT
Received: from dhcp-10-152-34-93.usdhcp.oraclecorp.com.com (/10.152.34.93)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 22 Sep 2018 13:05:26 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     jgross@suse.com, konrad.wilk@oracle.com, roger.pau@citrix.com,
        axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] xen/blkfront: When purging persistent grants, keep them in the buffer
Date:   Sat, 22 Sep 2018 15:55:49 -0400
Message-Id: <20180922195549.27953-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9024 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=634
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809220212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
added support for purging persistent grants when they are not in use. As
part of the purge, the grants were removed from the grant buffer, This
eventually causes the buffer to become empty, with BUG_ON triggered in
get_free_grant(). This can be observed even on an idle system, within
20-30 minutes.

We should keep the grants in the buffer when purging, and only free the
grant ref.

Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/block/xen-blkfront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a71d817e900d..3b441fe69c0d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2667,11 +2667,9 @@ static void purge_persistent_grants(struct blkfront_info *info)
 			    gnttab_query_foreign_access(gnt_list_entry->gref))
 				continue;
 
-			list_del(&gnt_list_entry->node);
 			gnttab_end_foreign_access(gnt_list_entry->gref, 0, 0UL);
+			gnt_list_entry->gref = GRANT_INVALID_REF;
 			rinfo->persistent_gnts_c--;
-			__free_page(gnt_list_entry->page);
-			kfree(gnt_list_entry);
 		}
 
 		spin_unlock_irqrestore(&rinfo->ring_lock, flags);
-- 
2.17.0

