Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A3C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA4A2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEDgHjJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA4A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJIBsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbeJIBsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:48:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296612087D;
        Mon,  8 Oct 2018 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023712;
        bh=gmVFu7cxNkqdv+Bc8ejmSWHcKVsMW7jRLycEoavwNR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEDgHjJl4jquxbkIM2Vivj3ZgjCD1d/OuRKowXjSuaGH7XAoqOwpwUHjXiWR6TgPp
         aFVLYLO9BPn/HUtDlo4txrlhbXFPf4g2EPp4g/7l53IOFvH83cHivlI6u3WnwDmEI7
         UDUMQEyFqQAReM9PqR14WXZD6TGQm39RGfCMPGao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 059/113] IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop
Date:   Mon,  8 Oct 2018 20:31:00 +0200
Message-Id: <20181008175534.247231978@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit ee92efe41cf358f4b99e73509f2bfd4733609f26 upstream.

Use different loop variables for the inner and outer loop. This avoids
that an infinite loop occurs if there are more RDMA channels than
target->req_ring_size.

Fixes: d92c0da71a35 ("IB/srp: Add multichannel support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2594,7 +2594,7 @@ static int srp_reset_device(struct scsi_
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
 	struct srp_rdma_ch *ch;
-	int i;
+	int i, j;
 	u8 status;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP reset_device called\n");
@@ -2608,8 +2608,8 @@ static int srp_reset_device(struct scsi_
 
 	for (i = 0; i < target->ch_count; i++) {
 		ch = &target->ch[i];
-		for (i = 0; i < target->req_ring_size; ++i) {
-			struct srp_request *req = &ch->req_ring[i];
+		for (j = 0; j < target->req_ring_size; ++j) {
+			struct srp_request *req = &ch->req_ring[j];
 
 			srp_finish_req(ch, req, scmnd->device, DID_RESET << 16);
 		}


