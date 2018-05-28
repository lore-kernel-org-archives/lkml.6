Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165396AbeE1N17 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163235AbeE1KrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 107/496] ibmvnic: Check for NULL skbs in NAPI poll routine
Date: Mon, 28 May 2018 11:58:12 +0200
Message-Id: <20180528100324.412139231@linuxfoundation.org>
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

[ Upstream commit abe27a885d9e6575e663a16176dabc58ce9d7188 ]

After introduction of commit d0869c0071e4, there were some instances of
RX queue entries from a previous session (before the device was closed
and reopened) returned to the NAPI polling routine. Since the corresponding
socket buffers were freed, this resulted in a panic on reopen. Include
a check for a NULL skb here to avoid this.

Fixes: d0869c0071e4 ("ibmvnic: Clean RX pool buffers during device close")
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1668,6 +1668,11 @@ restart_poll:
 			dev_kfree_skb_any(rx_buff->skb);
 			remove_buff_from_pool(adapter, rx_buff);
 			continue;
+		} else if (!rx_buff->skb) {
+			/* free the entry */
+			next->rx_comp.first = 0;
+			remove_buff_from_pool(adapter, rx_buff);
+			continue;
 		}
 
 		length = be32_to_cpu(next->rx_comp.len);
