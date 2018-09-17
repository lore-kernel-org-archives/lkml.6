Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24BFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18BB2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18BB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbeIREbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:31:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeIREbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:31:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EECADC03;
        Mon, 17 Sep 2018 23:01:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 041/126] Drivers: hv: vmbus: Cleanup synic memory free path
Date:   Tue, 18 Sep 2018 00:41:29 +0200
Message-Id: <20180917211707.398629040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 572086325ce9a9e348b8748e830653f3959e88b6 ]

clk_evt memory is not being freed when the synic is shutdown
or when there is an allocation error.  Add the appropriate
kfree() call, along with a comment to clarify how the memory
gets freed after an allocation error.  Make the free path
consistent by removing checks for NULL since kfree() and
free_page() already do the check.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/hv.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -196,6 +196,10 @@ int hv_synic_alloc(void)
 
 	return 0;
 err:
+	/*
+	 * Any memory allocations that succeeded will be freed when
+	 * the caller cleans up by calling hv_synic_free()
+	 */
 	return -ENOMEM;
 }
 
@@ -208,12 +212,10 @@ void hv_synic_free(void)
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


