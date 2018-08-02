Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C97DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC04420862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC04420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeHBE6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:58:25 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:33090
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbeHBE6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:58:25 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id l3yVff7QyVktnl3yVfqjC6; Wed, 01 Aug 2018 20:08:27 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fl3yV-0002oa-0k; Wed, 01 Aug 2018 20:08:27 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/3] Drivers: hv: vmbus: Cleanup synic memory free path
Date:   Thu,  2 Aug 2018 03:08:25 +0000
Message-Id: <20180802030825.10768-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802030825.10768-1-kys@linuxonhyperv.com>
References: <20180802030718.10708-1-kys@linuxonhyperv.com>
 <20180802030825.10768-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfKalf1Z7/86rwi8RwAbtE3bypUiXrFSQlo27TIjpdmEUjcv0OZlBLEiS5CcIkeqnOmfsLFclXFUHpCi7byhf40IU7D1twRfuY6vVcdaJaX5IExDXRVpd
 SX1p1qsU/ywnr9sOrgNZuZ4F2aJ+2jt5DUHtjc5NnW5f4idkBQ7Y+PXNJcfaGrv+d95NwJZ2FuGzmXnsjForpiT4n4MUjkuwM9zNMn8Hw56HXCntpsmKdOcT
 O+cRv9e6/WHSLG8/y7i6MwpPxF69W/H9FfIf4H8px/VyLCqengb19M5IrbhLG7MuuEgd+PdPLdWA4KxgWk4BKhrFyLxXjrTNLJ5HzhAZ5zUvGhfbztXYgMza
 eE/zrvEJ1f2AIysvLnxt6boTUCap0PVRLeipnX/reMoq5pcl81PbykP3ZQyEUqpMtcnLmeB1T9rCKxnOKV8oy3lutGB4/T13dRXZgdW2LXe3GBXXg2czCDa1
 x3sdAEuuJduLWrZAa7R+NXr/G8feTtt5Es93UGkiVSu2dBIpqyaC/TA4jpwBd09trsPhrKTXNu8FAjBFNZ33VNbl7D9Tr1VZGtwCqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

clk_evt memory is not being freed when the synic is shutdown
or when there is an allocation error.  Add the appropriate
kfree() call, along with a comment to clarify how the memory
gets freed after an allocation error.  Make the free path
consistent by removing checks for NULL since kfree() and
free_page() already do the check.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 312fe5ed7c40..748a1c4172a6 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -242,6 +242,10 @@ int hv_synic_alloc(void)
 
 	return 0;
 err:
+	/*
+	 * Any memory allocations that succeeded will be freed when
+	 * the caller cleans up by calling hv_synic_free()
+	 */
 	return -ENOMEM;
 }
 
@@ -254,12 +258,10 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		if (hv_cpu->synic_event_page)
-			free_page((unsigned long)hv_cpu->synic_event_page);
-		if (hv_cpu->synic_message_page)
-			free_page((unsigned long)hv_cpu->synic_message_page);
-		if (hv_cpu->post_msg_page)
-			free_page((unsigned long)hv_cpu->post_msg_page);
+		kfree(hv_cpu->clk_evt);
+		free_page((unsigned long)hv_cpu->synic_event_page);
+		free_page((unsigned long)hv_cpu->synic_message_page);
+		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
-- 
2.17.1

