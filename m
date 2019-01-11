Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FAA2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218056;
	bh=2XNpW+HpyJRdvEXVFhp1MNDTYtnk4CSy4Bf1h4/krQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L8+qrKLt0//U6BxJRGsmOy9BJk3OC6Hywi6ilZpuPIPAlXbYI65Loc4VVkJ65FLtU
	 uVXPsOaKDBGz0f/vAQGNx/bEzyzZesEviftbbmqHTLO67F3ECrffSBBGZ//vwg4KAU
	 AMgkE5n/HEe1oQ9XQGnV15dqOxYaIiJWO8SdJ7nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391367AbfAKOmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391351AbfAKOmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACAC22063F;
        Fri, 11 Jan 2019 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217728;
        bh=2XNpW+HpyJRdvEXVFhp1MNDTYtnk4CSy4Bf1h4/krQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=12AczPZ9k1s5vouzOxdONUDkQRqbCLtUcJdG2Hv/75K3Uloc26rpwglwf7O9D2FAk
         oVX/Z7vzlx9gHXI48+AuG/ynFcOGQgdtvQes/HJzOO5J6h3xrUjEF7a2pcnZDt1tJU
         sJLmOJZOx5zKiV+j6wPga97jXYfE/OJgPQDA6+6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 02/65] scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcnt is invalid
Date:   Fri, 11 Jan 2019 15:14:48 +0100
Message-Id: <20190111131056.286850843@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -14501,7 +14501,8 @@ lpfc_sli4_queue_alloc(struct lpfc_hba *p
 			hw_page_size))/hw_page_size;
 
 	/* If needed, Adjust page count to match the max the adapter supports */
-	if (queue->page_count > phba->sli4_hba.pc_sli4_params.wqpcnt)
+	if (phba->sli4_hba.pc_sli4_params.wqpcnt &&
+	    (queue->page_count > phba->sli4_hba.pc_sli4_params.wqpcnt))
 		queue->page_count = phba->sli4_hba.pc_sli4_params.wqpcnt;
 
 	INIT_LIST_HEAD(&queue->list);


