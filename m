Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164535AbeE1NAK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164191AbeE1Kxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 277/496] RDMA/qedr: Fix rc initialization on CNQ allocation failure
Date: Mon, 28 May 2018 12:01:02 +0200
Message-Id: <20180528100331.518556677@linuxfoundation.org>
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

From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>

[ Upstream commit b15606f47b89b0b09936d7f45b59ba6275527041 ]

Return code wasn't set properly when CNQ allocation failed.
This only affect error message logging, currently user will
receive an error message that says the qedr driver load failed
with rc '0', instead of ENOMEM

Fixes: ec72fce4 ("qedr: Add support for RoCE HW init")
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/qedr/main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -782,7 +782,8 @@ static struct qedr_dev *qedr_add(struct
 
 	dev->num_cnq = dev->ops->rdma_get_min_cnq_msix(cdev);
 	if (!dev->num_cnq) {
-		DP_ERR(dev, "not enough CNQ resources.\n");
+		DP_ERR(dev, "Failed. At least one CNQ is required.\n");
+		rc = -ENOMEM;
 		goto init_err;
 	}
 
