Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162870AbeE1OBZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162701AbeE1Kjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:39:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nguyen Viet Dung <dung.nguyen.aj@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 304/329] dmaengine: rcar-dmac: Check the done lists in rcar_dmac_chan_get_residue()
Date: Mon, 28 May 2018 12:03:53 +0200
Message-Id: <20180528100306.518545576@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 3e081628d510b2ddbe493371d9c574d9275da17e ]

This patch fixes an issue that a race condition happens between a client
driver and the rcar-dmac driver:

- The rcar_dmac_isr_transfer_end() is called.
 - The done list appears, and desc.running is the next active list.
- rcar_dmac_chan_get_residue() is called by a client driver before
  rcar_dmac_isr_channel_thread() is called.
 - The rcar_dmac_chan_get_residue() will not find any descriptors.
 - And, the following WARNING happens:
	WARN(1, "No descriptor for cookie!");

The sh-sci driver with HSCIF (921,600bps) on R-Car H3 can cause this
situation.
So, this patch checks the done lists in rcar_dmac_chan_get_residue()
and returns zero if the done lists has the argument cookie.

Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/sh/rcar-dmac.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1246,8 +1246,17 @@ static unsigned int rcar_dmac_chan_get_r
 	 * If the cookie doesn't correspond to the currently running transfer
 	 * then the descriptor hasn't been processed yet, and the residue is
 	 * equal to the full descriptor size.
+	 * Also, a client driver is possible to call this function before
+	 * rcar_dmac_isr_channel_thread() runs. In this case, the "desc.running"
+	 * will be the next descriptor, and the done list will appear. So, if
+	 * the argument cookie matches the done list's cookie, we can assume
+	 * the residue is zero.
 	 */
 	if (cookie != desc->async_tx.cookie) {
+		list_for_each_entry(desc, &chan->desc.done, node) {
+			if (cookie == desc->async_tx.cookie)
+				return 0;
+		}
 		list_for_each_entry(desc, &chan->desc.pending, node) {
 			if (cookie == desc->async_tx.cookie)
 				return desc->size;
