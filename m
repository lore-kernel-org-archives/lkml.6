Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034319AbeE1PX4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033226AbeE1KUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:20:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 110/268] nvme-pci: Fix nvme queue cleanup if IRQ setup fails
Date: Mon, 28 May 2018 12:01:24 +0200
Message-Id: <20180528100214.621806271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit f25a2dfc20e3a3ed8fe6618c331799dd7bd01190 ]

This patch fixes nvme queue cleanup if requesting an IRQ handler for
the queue's vector fails. It does this by resetting the cq_vector to
the uninitialized value of -1 so it is ignored for a controller reset.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
[changelog updates, removed misc whitespace changes]
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1583,7 +1583,7 @@ static int nvme_create_queue(struct nvme
 	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
-		return result;
+		goto release_vector;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
@@ -1597,9 +1597,12 @@ static int nvme_create_queue(struct nvme
 	return result;
 
  release_sq:
+	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
  release_cq:
 	adapter_delete_cq(dev, qid);
+ release_vector:
+	nvmeq->cq_vector = -1;
 	return result;
 }
 
