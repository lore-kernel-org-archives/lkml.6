Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937764AbeE1Kpz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162158AbeE1Kpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 073/496] ibmvnic: Free RX socket buffer in case of adapter error
Date: Mon, 28 May 2018 11:57:38 +0200
Message-Id: <20180528100322.856725660@linuxfoundation.org>
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

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit 4b9b0f01350500173f17e2b2e65beb4df4ef99c7 ]

If a RX buffer is returned to the client driver with an error, free the
corresponding socket buffer before continuing.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1636,6 +1636,7 @@ restart_poll:
 				   be16_to_cpu(next->rx_comp.rc));
 			/* free the entry */
 			next->rx_comp.first = 0;
+			dev_kfree_skb_any(rx_buff->skb);
 			remove_buff_from_pool(adapter, rx_buff);
 			continue;
 		}
