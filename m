Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B65FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E739B2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E739B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbeIXSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:47:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbeIXSq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:46:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33BB91099;
        Mon, 24 Sep 2018 12:45:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaoyun Liu <Shaoyun.Liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 208/235] drm/amdkfd: Fix kernel queue 64 bit doorbell offset calculation
Date:   Mon, 24 Sep 2018 13:53:14 +0200
Message-Id: <20180924113124.691249701@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaoyun Liu <Shaoyun.Liu@amd.com>

[ Upstream commit 951df6d9cfd07f205f1905bf3b27d994612e0614 ]

The bitmap index calculation should reverse the logic used on allocation
so it will clear the same bit used on allocation

Signed-off-by: Shaoyun Liu <Shaoyun.Liu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -188,9 +188,9 @@ void __iomem *kfd_get_kernel_doorbell(st
 	*doorbell_off = kfd->doorbell_id_offset + inx;
 
 	pr_debug("Get kernel queue doorbell\n"
-			 "     doorbell offset   == 0x%08X\n"
-			 "     kernel address    == %p\n",
-		*doorbell_off, (kfd->doorbell_kernel_ptr + inx));
+			"     doorbell offset   == 0x%08X\n"
+			"     doorbell index    == 0x%x\n",
+		*doorbell_off, inx);
 
 	return kfd->doorbell_kernel_ptr + inx;
 }
@@ -199,7 +199,8 @@ void kfd_release_kernel_doorbell(struct
 {
 	unsigned int inx;
 
-	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
+	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
+		* sizeof(u32) / kfd->device_info->doorbell_size;
 
 	mutex_lock(&kfd->doorbell_mutex);
 	__clear_bit(inx, kfd->doorbell_available_index);


