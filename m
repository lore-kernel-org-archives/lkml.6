Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ddNiMNRPGVt9AwAAmS7hNA
	; Thu, 07 Jun 2018 15:31:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C08D9607E7; Thu,  7 Jun 2018 15:31:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 42A84601B4;
	Thu,  7 Jun 2018 15:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42A84601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbeFGPbw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:31:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40955 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934889AbeFGOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:53:35 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbS-0005hL-A8; Thu, 07 Jun 2018 15:09:26 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003CI-0x; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>,
        syzbot+0df1ab766f8924b1edba@syzkaller.appspotmail.com
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.889776692@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 332/410] RDMA/ucma: Check that user doesn't overflow
 QP state
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit a5880b84430316e3e1c1f5d23aa32ec6000cc717 upstream.

The QP state is limited and declared in enum ib_qp_state,
but ucma user was able to supply any possible (u32) value.

Reported-by: syzbot+0df1ab766f8924b1edba@syzkaller.appspotmail.com
Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1050,6 +1050,9 @@ static ssize_t ucma_init_qp_attr(struct
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (cmd.qp_state > IB_QPS_ERR)
+		return -EINVAL;
+
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
