Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69FCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC4D2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xw74aCLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC4D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeKIQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:33:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeKIQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:33:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA96oUTI019476;
        Fri, 9 Nov 2018 06:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=YaUMgYVEE8rGGmtrAJZKLM0JQVY9Xo9K5T9WoSnTHdA=;
 b=Xw74aCLEifecwEJTOScNQPf/CP6EEa47l52riKUmdMCzG2wlk5hfw6W34KiLo1pO1oXF
 SSecrEAE2SNo0/x/TZIKKiGw4bMNDukMqkq6k1U1s/44dGo1+q+jSypAHTPGq8zs2u+n
 1ojwo56AFcCb0Sx9VwqpSDmiW0KcoSqPCFJWr1sspbZ3pHA+m9ObNeBSucFIjVEq4Jvi
 1E/u8PPWhI+2XTe5Wi86j9eUyELrhbdZJEDLiy3dD2Qx+kOOIVCpXS/84GRjTAnV3FB/
 Nr5aVGVNyTXMd40dWo0Cj0NdKwqyPuLtHDQLAfQdL9h+kdGX05uvAoSlrXFLyl5jRSbN qQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nh33udegq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 06:54:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA96sbNP027440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 06:54:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA96sa3x004578;
        Fri, 9 Nov 2018 06:54:36 GMT
Received: from jw-M900.cn.oracle.com (/10.182.70.161)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Nov 2018 22:54:36 -0800
From:   Jacob Wen <jian.w.wen@oracle.com>
To:     netdev@vger.kernel.org
Cc:     jgross@suse.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen/netfront: remove unnecessary wmb
Date:   Fri,  9 Nov 2018 14:53:59 +0800
Message-Id: <20181109065359.14900-1-jian.w.wen@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=760
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RING_PUSH_REQUESTS_AND_CHECK_NOTIFY is already able to make sure backend sees
requests before req_prod is updated.

Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
---
 drivers/net/xen-netfront.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index f17f602e6171..a8303afa15f1 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -337,8 +337,6 @@ static void xennet_alloc_rx_buffers(struct netfront_queue *queue)
 		return;
 	}
 
-	wmb();		/* barrier so backend seens requests */
-
 	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(&queue->rx, notify);
 	if (notify)
 		notify_remote_via_irq(queue->rx_irq);
-- 
2.17.1

