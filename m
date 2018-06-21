Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1BCC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78895217D0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="McW+FVeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78895217D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932964AbeFURWE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:22:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48838 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeFURWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:22:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LHJMnm133247;
        Thu, 21 Jun 2018 17:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=qHVNhNdDe7SWnPYk/YRXR+pxSe0sZmlJA/KiY96EKKM=;
 b=McW+FVeP8tQZzZQXCSCnixdJR7ObhCCC7VV80xF3JaaJH+WLEyo9mcGTXtRFYjb1nufs
 Ft0/6nF6ZCa7inFEcsT0dMS3r/qT8eeXp9l58G6Qkq3Wgvk6cb9YdBATEwWzJwb+JyQX
 CdIq9UlxMy9Krpeb2CvxmWao1jD96gnfPAJc1MGnW6iX/F/yY/hXJmJbtUFjlQfEBShb
 C/S7KIUzj10oKxu/Tql29ewW2I0UK08QCjzGkhVklSD1Ct2G1b2Vs0KA9J37bzMxKkrR
 BOHno+g/T5wvh8atWo1dl6DYQK1al8wEboR5Ai3EPPM7E+VeuEgwliUVMdfwMvBzSThb 5g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jmr2msux9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 17:21:43 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5LHLgCK013299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 17:21:42 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5LHLfWn030213;
        Thu, 21 Jun 2018 17:21:42 GMT
Received: from ovs104.us.oracle.com (/10.149.224.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 10:21:41 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, ben.hutchings@codethink.co.uk,
        roger.pau@citrix.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] xen: Remove unnecessary BUG_ON from __unbind_from_irq()
Date:   Thu, 21 Jun 2018 13:29:44 -0400
Message-Id: <1529602184-2861-1-git-send-email-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 910f8befdf5b ("xen/pirq: fix error path cleanup when binding
MSIs") fixed a couple of errors in error cleanup path of
xen_bind_pirq_msi_to_irq(). This cleanup allowed a call to
__unbind_from_irq() with an unbound irq, which would result in
triggering the BUG_ON there.

Since there is really no reason for the BUG_ON (xen_free_irq() can
operate on unbound irqs) we can remove it.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org
---
 drivers/xen/events/events_base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 762378f..08e4af0 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -628,8 +628,6 @@ static void __unbind_from_irq(unsigned int irq)
 		xen_irq_info_cleanup(info);
 	}
 
-	BUG_ON(info_for_irq(irq)->type == IRQT_UNBOUND);
-
 	xen_free_irq(irq);
 }
 
-- 
1.8.3.1

