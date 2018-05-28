Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163172AbeE1Kqp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163137AbeE1Kqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Devesh Sharma <devesh.sharma@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 105/496] RDMA/bnxt_re: Unpin SQ and RQ memory if QP create fails
Date: Mon, 28 May 2018 11:58:10 +0200
Message-Id: <20180528100324.277317709@linuxfoundation.org>
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

From: Devesh Sharma <devesh.sharma@broadcom.com>

[ Upstream commit 6b4521f5174c26020ae0deb3ef7f2c28557cf445 ]

Driver leaves the QP memory pinned if QP create command
fails from the FW. Avoids this scenario by adding a proper
exit path if the FW command fails.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1180,7 +1180,7 @@ struct ib_qp *bnxt_re_create_qp(struct i
 		rc = bnxt_qplib_create_qp(&rdev->qplib_res, &qp->qplib_qp);
 		if (rc) {
 			dev_err(rdev_to_dev(rdev), "Failed to create HW QP");
-			goto fail;
+			goto free_umem;
 		}
 	}
 
@@ -1208,6 +1208,13 @@ struct ib_qp *bnxt_re_create_qp(struct i
 	return &qp->ib_qp;
 qp_destroy:
 	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
+free_umem:
+	if (udata) {
+		if (qp->rumem)
+			ib_umem_release(qp->rumem);
+		if (qp->sumem)
+			ib_umem_release(qp->sumem);
+	}
 fail:
 	kfree(qp);
 	return ERR_PTR(rc);
