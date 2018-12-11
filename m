Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93501C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5252B2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542986;
	bh=QwvKISSW75lWfzS5WAFF/krtLkDpLPUcfoiuj+kGEwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1iB3XO8k2b8C/emxalFA9SjAS926kXKQ6Tr9BveoHrCDJq5i6qAqlpTgq23Hzafsk
	 MPONV8yWIa935ePMj4kFCtgvAEqJZ4cINb+day+GeF29I2TU6Y73W3n63K5ESwAYkB
	 /NMADDL7ocoHP7ZC4WF3I+4f3wiAD36iet3rdEs8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5252B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeLKPnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeLKPnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22CA20855;
        Tue, 11 Dec 2018 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542982;
        bh=QwvKISSW75lWfzS5WAFF/krtLkDpLPUcfoiuj+kGEwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xKsttWIGx9eY8EW4i1R1sga05aZYDviVHjK6ICMo+qr2aeMRL1nexzBA0iwNAyFJu
         KdrHVMRpG/iiJeGg/R0UXvygBaiAf65tvQSZ4DxfGuWLsGE3XZtHGEko21bscfaDIM
         k0yPunEB2H4dcaEshRzf4n435ie9NAJY8YRVlS+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 3.18 22/54] iser: set sector for ambiguous mr status errors
Date:   Tue, 11 Dec 2018 16:41:10 +0100
Message-Id: <20181211151547.212553425@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit 24c3456c8d5ee6fc1933ca40f7b4406130682668 upstream.

If for some reason we failed to query the mr status, we need to make sure
to provide sufficient information for an ambiguous error (guard error on
sector 0).

Fixes: 0a7a08ad6f5f ("IB/iser: Implement check_protection")
Cc: <stable@vger.kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/iser/iser_verbs.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -1280,7 +1280,9 @@ u8 iser_check_task_pi_status(struct iscs
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
 			pr_err("ib_check_mr_status failed, ret %d\n", ret);
-			goto err;
+			/* Not a lot we can do, return ambiguous guard error */
+			*sector = 0;
+			return 0x1;
 		}
 
 		if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
@@ -1308,7 +1310,4 @@ u8 iser_check_task_pi_status(struct iscs
 	}
 
 	return 0;
-err:
-	/* Not alot we can do here, return ambiguous guard error */
-	return 0x1;
 }


