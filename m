Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424503AbeE1LPF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424202AbeE1LO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:14:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 232/272] ixgbe: prevent ptp_rx_hang from running when in FILTER_ALL mode
Date: Mon, 28 May 2018 12:04:25 +0200
Message-Id: <20180528100259.873543750@linuxfoundation.org>
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

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 6704a3abf4cf4181a1ee64f5db4969347b88ca1d ]

On hardware which supports timestamping all packets, the timestamps are
recorded in the packet buffer, and the driver no longer uses or reads
the registers. This makes the logic for checking and clearing Rx
timestamp hangs meaningless.

If we run the ixgbe_ptp_rx_hang() function in this case, then the driver
will continuously spam the log output with "Clearing Rx timestamp hang".
These messages are spurious, and confusing to end users.

The original code in commit a9763f3cb54c ("ixgbe: Update PTP to support
X550EM_x devices", 2015-12-03) did have a flag PTP_RX_TIMESTAMP_IN_REGISTER
which was intended to be used to avoid the Rx timestamp hang check,
however it did not actually check the flag before calling the function.

Do so now in order to stop the checks and prevent the spurious log
messages.

Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices", 2015-12-03)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7711,7 +7711,8 @@ static void ixgbe_service_task(struct wo
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state)) {
 		ixgbe_ptp_overflow_check(adapter);
-		ixgbe_ptp_rx_hang(adapter);
+		if (adapter->flags & IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER)
+			ixgbe_ptp_rx_hang(adapter);
 		ixgbe_ptp_tx_hang(adapter);
 	}
 
