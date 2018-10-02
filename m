Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF04C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFCA2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFCA2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbeJBUO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbeJBUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:26 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C73D0C2B;
        Tue,  2 Oct 2018 13:31:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 217/228] nvme-fcloop: Fix dropped LSs to removed target port
Date:   Tue,  2 Oct 2018 06:25:14 -0700
Message-Id: <20181002132512.235321368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit afd299ca996929f4f98ac20da0044c0cdc124879 ]

When a targetport is removed from the config, fcloop will avoid calling
the LS done() routine thinking the targetport is gone. This leaves the
initiator reset/reconnect hanging as it waits for a status on the
Create_Association LS for the reconnect.

Change the filter in the LS callback path. If tport null (set when
failed validation before "sending to remote port"), be sure to call
done. This was the main bug. But, continue the logic that only calls
done if tport was set but there is no remoteport (e.g. case where
remoteport has been removed, thus host doesn't expect a completion).

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/fcloop.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -311,7 +311,7 @@ fcloop_tgt_lsrqst_done_work(struct work_
 	struct fcloop_tport *tport = tls_req->tport;
 	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
 
-	if (tport->remoteport)
+	if (!tport || tport->remoteport)
 		lsreq->done(lsreq, tls_req->status);
 }
 
@@ -329,6 +329,7 @@ fcloop_ls_req(struct nvme_fc_local_port
 
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
+		tls_req->tport = NULL;
 		schedule_work(&tls_req->work);
 		return ret;
 	}


