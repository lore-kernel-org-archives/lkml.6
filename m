Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF8EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5522064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5522064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbeJBU3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:29:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbeJBUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:45 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A38B5C2B;
        Tue,  2 Oct 2018 13:35:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 104/137] IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop
Date:   Tue,  2 Oct 2018 06:25:05 -0700
Message-Id: <20181002132505.764331834@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
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
@@ -2669,7 +2669,7 @@ static int srp_reset_device(struct scsi_
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
 	struct srp_rdma_ch *ch;
-	int i;
+	int i, j;
 	u8 status;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP reset_device called\n");
@@ -2683,8 +2683,8 @@ static int srp_reset_device(struct scsi_
 
 	for (i = 0; i < target->ch_count; i++) {
 		ch = &target->ch[i];
-		for (i = 0; i < target->req_ring_size; ++i) {
-			struct srp_request *req = &ch->req_ring[i];
+		for (j = 0; j < target->req_ring_size; ++j) {
+			struct srp_request *req = &ch->req_ring[j];
 
 			srp_finish_req(ch, req, scmnd->device, DID_RESET << 16);
 		}


