Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938531AbeE1MCV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423325AbeE1LGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 066/272] ibmvnic: Zero used TX descriptor counter on reset
Date: Mon, 28 May 2018 12:01:39 +0200
Message-Id: <20180528100246.426555643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit 41f714672f93608751dbd2fa2291d476a8ff0150 ]

The counter that tracks used TX descriptors pending completion
needs to be zeroed as part of a device reset. This change fixes
a bug causing transmit queues to be stopped unnecessarily and in
some cases a transmit queue stall and timeout reset. If the counter
is not reset, the remaining descriptors will not be "removed",
effectively reducing queue capacity. If the queue is over half full,
it will cause the queue to stall if stopped.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2266,6 +2266,7 @@ static int reset_one_sub_crq_queue(struc
 	}
 
 	memset(scrq->msgs, 0, 4 * PAGE_SIZE);
+	atomic_set(&scrq->used, 0);
 	scrq->cur = 0;
 
 	rc = h_reg_sub_crq(adapter->vdev->unit_address, scrq->msg_token,
