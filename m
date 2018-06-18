Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2920CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E062520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E062520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935379AbeFRITH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935350AbeFRITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31C59BAD;
        Mon, 18 Jun 2018 08:19:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 089/279] igb: Fix the transmission mode of queue 0 for Qav mode
Date:   Mon, 18 Jun 2018 10:11:14 +0200
Message-Id: <20180618080612.487787478@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 2707df9773cd2cb8b0f35b8592431b301da9d352 ]

When Qav mode is enabled, queue 0 should be kept on Stream Reservation
mode. From the i210 datasheet, section 8.12.19:

"Note: Queue0 QueueMode must be set to 1b when TransmitMode is set to
Qav." ("QueueMode 1b" represents the Stream Reservation mode)

The solution is to give queue 0 the all the credits it might need, so
it has priority over queue 1.

A situation where this can happen is when cbs is "installed" only on
queue 1, leaving queue 0 alone. For example:

$ tc qdisc replace dev enp2s0 handle 100: parent root mqprio num_tc 3 \
     	   map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@1 2@2 hw 0

$ tc qdisc replace dev enp2s0 parent 100:2 cbs locredit -1470 \
     	   hicredit 30 sendslope -980000 idleslope 20000 offload 1

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1698,7 +1698,22 @@ static void igb_configure_cbs(struct igb
 	WARN_ON(hw->mac.type != e1000_i210);
 	WARN_ON(queue < 0 || queue > 1);
 
-	if (enable) {
+	if (enable || queue == 0) {
+		/* i210 does not allow the queue 0 to be in the Strict
+		 * Priority mode while the Qav mode is enabled, so,
+		 * instead of disabling strict priority mode, we give
+		 * queue 0 the maximum of credits possible.
+		 *
+		 * See section 8.12.19 of the i210 datasheet, "Note:
+		 * Queue0 QueueMode must be set to 1b when
+		 * TransmitMode is set to Qav."
+		 */
+		if (queue == 0 && !enable) {
+			/* max "linkspeed" idleslope in kbps */
+			idleslope = 1000000;
+			hicredit = ETH_FRAME_LEN;
+		}
+
 		set_tx_desc_fetch_prio(hw, queue, TX_QUEUE_PRIO_HIGH);
 		set_queue_mode(hw, queue, QUEUE_MODE_STREAM_RESERVATION);
 


