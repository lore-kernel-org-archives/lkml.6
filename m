Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424061AbeE1LL2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424050AbeE1LLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Allen <jallen@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 163/272] ibmvnic: Fix reset return from closed state
Date: Mon, 28 May 2018 12:03:16 +0200
Message-Id: <20180528100254.523860670@linuxfoundation.org>
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

From: John Allen <jallen@linux.vnet.ibm.com>

[ Upstream commit e676d81c8990f511d60698a1a8abaa438b3f9d3d ]

The case in which we handle a reset from the state where the device is
closed seems to be bugged for all types of reset. For most types of reset
we currently exit the reset routine correctly, but don't set the state to
indicate that we are back in the "closed" state. For some specific cases,
we don't exit the reset routine at all and resetting will cause a closed
device to be opened.

This patch fixes the problem by unconditionally checking the reset_state
and correctly setting the adapter state before returning.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1699,12 +1699,14 @@ static int do_reset(struct ibmvnic_adapt
 			rc = reset_rx_pools(adapter);
 			if (rc)
 				return rc;
-
-			if (reset_state == VNIC_CLOSED)
-				return 0;
 		}
 	}
 
+	adapter->state = VNIC_CLOSED;
+
+	if (reset_state == VNIC_CLOSED)
+		return 0;
+
 	rc = __ibmvnic_open(netdev);
 	if (rc) {
 		if (list_empty(&adapter->rwi_list))
