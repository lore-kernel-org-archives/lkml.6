Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C39C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0913D20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0913D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeJWGkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:40:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:26964 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbeJWGkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:40:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 15:20:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="90420334"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Oct 2018 15:20:11 -0700
From:   thor.thayer@linux.intel.com
To:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2 2/2] net: stmmac: Set OWN bit for jumbo frames
Date:   Mon, 22 Oct 2018 17:22:26 -0500
Message-Id: <1540246946-12784-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540246946-12784-1-git-send-email-thor.thayer@linux.intel.com>
References: <1540246946-12784-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Ping with Jumbo packet does not reply and get a watchdog timeout

[   46.059616] ------------[ cut here ]------------
[   46.064268] NETDEV WATCHDOG: eth0 (socfpga-dwmac): transmit queue 0 timed out
[   46.071471] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:461 dev_watchdog+0x2cc/0x2d8
[   46.079708] Modules linked in:
[   46.082761] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.18.0-00115-gc262be665854-dirty #264
[   46.091082] Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
[   46.096377] pstate: 20000005 (nzCv daif -PAN -UAO)
[   46.101152] pc : dev_watchdog+0x2cc/0x2d8
[   46.105149] lr : dev_watchdog+0x2cc/0x2d8
[   46.109144] sp : ffff00000800bd80
[   46.112447] x29: ffff00000800bd80 x28: ffff80007a9b4940
[   46.117744] x27: 00000000ffffffff x26: ffff80007aa183b0
[   46.123040] x25: 0000000000000001 x24: 0000000000000140
[   46.128336] x23: ffff80007aa1839c x22: ffff80007aa17fb0
[   46.133632] x21: ffff80007aa18000 x20: ffff0000091a7000
[   46.138927] x19: 0000000000000000 x18: ffffffffffffffff
[   46.144223] x17: 0000000000000000 x16: 0000000000000000
[   46.149519] x15: ffff0000091a96c8 x14: 07740775076f0720
[   46.154814] x13: 07640765076d0769 x12: 0774072007300720
[   46.160110] x11: 0765077507650775 x10: 0771072007740769
[   46.165406] x9 : 076d0773076e0761 x8 : 077207740720073a
[   46.170702] x7 : 072907630761076d x6 : ffff80007ff9a0c0
[   46.175997] x5 : ffff80007ff9a0c0 x4 : 0000000000000002
[   46.181293] x3 : 0000000000000000 x2 : ffff0000091ac180
[   46.186589] x1 : e6a742ebe628e800 x0 : 0000000000000000
[   46.191885] Call trace:
[   46.194326]  dev_watchdog+0x2cc/0x2d8
[   46.197980]  call_timer_fn+0x20/0x78
[   46.201544]  expire_timers+0xa4/0xb0
[   46.205108]  run_timer_softirq+0xe4/0x198
[   46.209107]  __do_softirq+0x114/0x210
[   46.212760]  irq_exit+0xd0/0xd8
[   46.215895]  __handle_domain_irq+0x60/0xb0
[   46.219977]  gic_handle_irq+0x58/0xa8
[   46.223628]  el1_irq+0xb0/0x128
[   46.226761]  arch_cpu_idle+0x10/0x18
[   46.230326]  do_idle+0x1d4/0x288
[   46.233544]  cpu_startup_entry+0x24/0x28
[   46.237457]  secondary_start_kernel+0x17c/0x1c0
[   46.241971] ---[ end trace 57048cd1372cd828 ]---

Inspection of queue showed Jumbo packets were not sent out.
The ring Jumbo packet function needs to set the OWN bit so
the packet is sent.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  Add fix for jumbo frames > 8K (same OWN bit)
---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index a7ffc73fffe8..abc3f85270cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -59,7 +59,7 @@ static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
 
 		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
-				STMMAC_RING_MODE, 0, false, skb->len);
+				STMMAC_RING_MODE, 1, false, skb->len);
 		tx_q->tx_skbuff[entry] = NULL;
 		entry = STMMAC_GET_ENTRY(entry, DMA_TX_SIZE);
 
@@ -91,7 +91,7 @@ static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
-				STMMAC_RING_MODE, 0, true, skb->len);
+				STMMAC_RING_MODE, 1, true, skb->len);
 	}
 
 	tx_q->cur_tx = entry;
-- 
2.7.4

