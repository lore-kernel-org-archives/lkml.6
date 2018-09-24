Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC44CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7D20877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F7D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbeIXSJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:09:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbeIXSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:09:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90DC61086;
        Mon, 24 Sep 2018 12:07:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Yanhui He <yanhuih@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 107/111] e1000e: Fix queue interrupt re-raising in Other interrupt
Date:   Mon, 24 Sep 2018 13:53:14 +0200
Message-Id: <20180924113115.841220945@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Poirier <bpoirier@suse.com>

commit 361a954e6a7215de11a6179ad9bdc07d7e394b04 upstream.

Restores the ICS write for Rx/Tx queue interrupts which was present before
commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1)
but was not restored in commit 4aea7a5c5e94
("e1000e: Avoid receiver overrun interrupt bursts", v4.15-rc1).

This re-raises the queue interrupts in case the txq or rxq bits were set in
ICR and the Other interrupt handler read and cleared ICR before the queue
interrupt was raised.

Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Yanhui He <yanhuih@vmware.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1916,6 +1916,9 @@ static irqreturn_t e1000_msix_other(int
 	icr = er32(ICR);
 	ew32(ICR, E1000_ICR_OTHER);
 
+	if (icr & adapter->eiac_mask)
+		ew32(ICS, (icr & adapter->eiac_mask));
+
 	if (icr & E1000_ICR_LSC) {
 		ew32(ICR, E1000_ICR_LSC);
 		hw->mac.get_link_status = true;


