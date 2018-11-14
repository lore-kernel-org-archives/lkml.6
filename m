Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C59DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9964F2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9964F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeKNLsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 06:48:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbeKNLso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 06:48:44 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48F2F8C709B87;
        Wed, 14 Nov 2018 09:47:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Nov 2018 09:47:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <jroedel@suse.de>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] misc: mic/scif: fix copy-paste error in scif_create_remote_lookup
Date:   Wed, 14 Nov 2018 01:57:03 +0000
Message-ID: <1542160623-29011-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc '-Wunused-but-set-variable' warning:

drivers/misc/mic/scif/scif_rma.c: In function 'scif_create_remote_lookup':
drivers/misc/mic/scif/scif_rma.c:373:25: warning:
 variable 'vmalloc_num_pages' set but not used [-Wunused-but-set-variable]

'vmalloc_num_pages' should be used to determine if the address is 
within the vmalloc range.

Fixes: ba612aa8b487 ("misc: mic: SCIF memory registration and unregistration")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/mic/scif/scif_rma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
index b441f6b..749321e 100644
--- a/drivers/misc/mic/scif/scif_rma.c
+++ b/drivers/misc/mic/scif/scif_rma.c
@@ -416,7 +416,7 @@ static int scif_create_remote_lookup(struct scif_dev *remote_dev,
 		if (err)
 			goto error_window;
 		err = scif_map_page(&window->num_pages_lookup.lookup[j],
-				    vmalloc_dma_phys ?
+				    vmalloc_num_pages ?
 				    vmalloc_to_page(&window->num_pages[i]) :
 				    virt_to_page(&window->num_pages[i]),
 				    remote_dev);



