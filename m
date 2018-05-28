Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165313AbeE1NUS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163516AbeE1KtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 185/496] RDMA/bnxt_re: Fix the ib_reg failure cleanup
Date: Mon, 28 May 2018 11:59:30 +0200
Message-Id: <20180528100327.744743881@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit 497158aa5f520db50452ef928c0f955cb42f2e77 ]

Release the netdev references in the cleanup path.  Invokes the cleanup
routines if bnxt_re_ib_reg fails.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1240,9 +1240,12 @@ static void bnxt_re_task(struct work_str
 	switch (re_work->event) {
 	case NETDEV_REGISTER:
 		rc = bnxt_re_ib_reg(rdev);
-		if (rc)
+		if (rc) {
 			dev_err(rdev_to_dev(rdev),
 				"Failed to register with IB: %#x", rc);
+			bnxt_re_remove_one(rdev);
+			bnxt_re_dev_unreg(rdev);
+		}
 		break;
 	case NETDEV_UP:
 		bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
