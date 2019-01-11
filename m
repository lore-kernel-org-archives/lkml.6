Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF340C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B757A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218870;
	bh=BCW1uAKkWF+5lq8cD7sp69W5/q6TYpgRQOKJ6z6k0ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/4YLepuGuMUak8+45fbErcUEQv4xrD1Y436ULD2EaDZbldQOaGh3Rmb1ebKcr9ja
	 AdzyZF3j+ak6Iz+FfW7UVn90Ggiv0igq1smNB049/joIBLrUzRtW7Wo3YGE0q0yMz8
	 6Vx2ZEHGwHgQeyob/8j7Vm/dqZVe4kDBgmJ6gsts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbfAKOcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389395AbfAKOcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3722063F;
        Fri, 11 Jan 2019 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217141;
        bh=BCW1uAKkWF+5lq8cD7sp69W5/q6TYpgRQOKJ6z6k0ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4q4mYjHlDmftHwDcUuF23jGEOQpaEH4YCq1zTJ9AvUWDTLROjwXW9YYh2JbLyS0p
         4vOzTHK+znnXxe9PKhsIqVl5Uu+n0ocJ/12RvKP1U2Ztc2yJPHo1FDDDJmoarFyytt
         W9sIjj4uTWspJ3q6V1WI0Hvp8xcXeQ3GUU8K5MrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 056/105] scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcnt is invalid
Date:   Fri, 11 Jan 2019 15:14:27 +0100
Message-Id: <20190111131107.703166915@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ewan D. Milne <emilne@redhat.com>

commit 4e87eb2f46ea547d12a276b2e696ab934d16cfb6 upstream.

Certain older adapters such as the OneConnect OCe10100 may not have a valid
wqpcnt value.  In this case, do not set queue->page_count to 0 in
lpfc_sli4_queue_alloc() as this will prevent the driver from initializing.

Fixes: 895427bd01 ("scsi: lpfc: NVME Initiator: Base modifications")
Cc: stable@vger.kernel.org # 4.11+
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by:   Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/lpfc/lpfc_sli.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13941,7 +13941,8 @@ lpfc_sli4_queue_alloc(struct lpfc_hba *p
 			hw_page_size))/hw_page_size;
 
 	/* If needed, Adjust page count to match the max the adapter supports */
-	if (queue->page_count > phba->sli4_hba.pc_sli4_params.wqpcnt)
+	if (phba->sli4_hba.pc_sli4_params.wqpcnt &&
+	    (queue->page_count > phba->sli4_hba.pc_sli4_params.wqpcnt))
 		queue->page_count = phba->sli4_hba.pc_sli4_params.wqpcnt;
 
 	INIT_LIST_HEAD(&queue->list);


