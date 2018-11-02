Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE746C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF552081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wgh7N/gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF552081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeKBXLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:11:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBXLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:11:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA2E4Gn4194258;
        Fri, 2 Nov 2018 14:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=rx7d9c1Ho99ZKGyLo4XTWcEaingY1r1FAfUD1FRI/m8=;
 b=wgh7N/gCVOVxYjtaZ6f7ZU3A8T6djDmc9y7UuAGfiYoi5w4rUs7mdnG82e0UqdAwIo94
 SJjSRpQ6qTQrIsf8+rALIoumwjLmEmuRbVXddQk9ZRks3n7DZIVy8ohmufnltrbJ9l9l
 L7tRl0jYoZvLP9lq2AA9fxdqRlAG4bhveOgoNNdEmrS5+Xgvsx1yCKD7MsBwNs45rDE6
 E9Z+slAjxVVrVecButMzffTrhYHo9FvHZLP5NvJK4qOfFSLBc5YUPSKgh/3t6tbD1YsI
 a16v6Kun+pLsfMFuU6dwz7xyIg3USc+YChUMcpgIONfZefFoOpea9/NP6G0kju1w7jPP Ng== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ncfyqen7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 14:04:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA2E4AUk004562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 14:04:10 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA2E4AGQ025024;
        Fri, 2 Nov 2018 14:04:10 GMT
Received: from ol7.nl.oracle.com (/10.175.37.135)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Nov 2018 07:04:09 -0700
From:   Liam Merwick <Liam.Merwick@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        liam.merwick@oracle.com
Subject: [PATCH] xen/grant-table: Fix incorrect gnttab_dma_free_pages() pr_debug message
Date:   Fri,  2 Nov 2018 14:04:23 +0000
Message-Id: <1541167463-32024-1-git-send-email-Liam.Merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a call to xenmem_reservation_increase() in gnttab_dma_free_pages()
fails it triggers a message "Failed to decrease reservation..." which
should be "Failed to increase reservation..."

Fixes: 9bdc7304f536 ('xen/grant-table: Allow allocating buffers suitable for DMA')
Reported-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
---
 drivers/xen/grant-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 84575baceebc..97341fa75458 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -914,7 +914,7 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
 
 	ret = xenmem_reservation_increase(args->nr_pages, args->frames);
 	if (ret != args->nr_pages) {
-		pr_debug("Failed to decrease reservation for DMA buffer\n");
+		pr_debug("Failed to increase reservation for DMA buffer\n");
 		ret = -EFAULT;
 	} else {
 		ret = 0;
-- 
1.8.3.1

