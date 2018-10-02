Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A5B206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A5B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeJBURb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732152AbeJBURa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:30 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 736D5BF0;
        Tue,  2 Oct 2018 13:34:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 061/137] ath10k: transmit queued frames after processing rx packets
Date:   Tue,  2 Oct 2018 06:24:22 -0700
Message-Id: <20181002132502.809024666@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 3f04950f32d5d592ab4fcaecac2178558a6f7437 ]

When running iperf on ath10k SDIO, TX can stop working:

iperf -c 192.168.1.1 -i 1 -t 20 -w 10K
[  3]  0.0- 1.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3]  1.0- 2.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3]  2.0- 3.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3]  3.0- 4.0 sec   655 KBytes  5.36 Mbits/sec
[  3]  4.0- 5.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  5.0- 6.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  6.0- 7.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  7.0- 8.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  8.0- 9.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  9.0-10.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  0.0-10.3 sec  9.01 MBytes  7.32 Mbits/sec

There are frames in the ieee80211_txq and there are frames that have
been removed from from this queue, but haven't yet been sent on the wire
(num_pending_tx).

When num_pending_tx reaches max_num_pending_tx, we will stop the queues
by calling ieee80211_stop_queues().

As frames that have previously been sent for transmission
(num_pending_tx) are completed, we will decrease num_pending_tx and wake
the queues by calling ieee80211_wake_queue(). ieee80211_wake_queue()
does not call wake_tx_queue, so we might still have frames in the
queue at this point.

While the queues were stopped, the socket buffer might have filled up,
and in order for user space to write more, we need to free the frames
in the queue, since they are accounted to the socket. In order to free
them, we first need to transmit them.

This problem cannot be reproduced on low-latency devices, e.g. pci,
since they call ath10k_mac_tx_push_pending() from
ath10k_htt_txrx_compl_task(). ath10k_htt_txrx_compl_task() is not called
on high-latency devices.
Fix the problem by calling ath10k_mac_tx_push_pending(), after
processing rx packets, just like for low-latency devices, also in the
SDIO case. Since we are calling ath10k_mac_tx_push_pending() directly,
we also need to export it.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c  |    1 +
 drivers/net/wireless/ath/ath10k/sdio.c |    3 +++
 2 files changed, 4 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4015,6 +4015,7 @@ void ath10k_mac_tx_push_pending(struct a
 	rcu_read_unlock();
 	spin_unlock_bh(&ar->txqs_lock);
 }
+EXPORT_SYMBOL(ath10k_mac_tx_push_pending);
 
 /************/
 /* Scanning */
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -30,6 +30,7 @@
 #include "debug.h"
 #include "hif.h"
 #include "htc.h"
+#include "mac.h"
 #include "targaddrs.h"
 #include "trace.h"
 #include "sdio.h"
@@ -1346,6 +1347,8 @@ static void ath10k_sdio_irq_handler(stru
 			break;
 	} while (time_before(jiffies, timeout) && !done);
 
+	ath10k_mac_tx_push_pending(ar);
+
 	sdio_claim_host(ar_sdio->func);
 
 	if (ret && ret != -ECANCELED)


