Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF07BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D91420700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901425;
	bh=KDH9ysj78g3a2OJr1MilKo0lpoH5ONg5rbfm5JSGo9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ej+ztdSjGP5odOfb4GFEP6kjoUWVcwY8KyD+oyZWRx9D0iLsMr+BTLfkd2R+RtHdc
	 VfMoLlp4TdNIz46AqCXb/FwI/vOelq4ni3jIC8mAhCoqgMf7/Nhauwxos1xDs8TLnI
	 DSNICd0ujwQdK9kZRwAmxExm5PnynfCjXGlCOqIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfBKOYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbfBKOYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1E021855;
        Mon, 11 Feb 2019 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895075;
        bh=KDH9ysj78g3a2OJr1MilKo0lpoH5ONg5rbfm5JSGo9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbmzW50+V+GNTc00DylPQFNYzgkAvBxQ8d6bihvEYD63/whMVpepRtAibLUWZWWf6
         vCkGgfdqSthBGsC1XuGHheCmhS1pATjOj8mo82AWVruqnlqHiCNKx4o2dp+Bl6U0f/
         r91mQ3e1HFAw6EJRGyP7ahG2z9Ebkq4Jm474+9vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Brady <alan.brady@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 043/352] i40e: prevent overlapping tx_timeout recover
Date:   Mon, 11 Feb 2019 15:14:30 +0100
Message-Id: <20190211141849.050937911@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d5585b7b6846a6d0f9517afe57be3843150719da ]

If a TX hang occurs, we attempt to recover by incrementally resetting.
If we're starved for CPU time, it's possible the reset doesn't actually
complete (or even fire) before another tx_timeout fires causing us to
fly through the different resets without actually doing them.

This adds a bit to set and check if a timeout recovery is already
pending and, if so, bail out of tx_timeout.  The bit will get cleared at
the end of i40e_rebuild when reset is complete.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 876cac317e79..8245ff12fd64 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -122,6 +122,7 @@ enum i40e_state_t {
 	__I40E_MDD_EVENT_PENDING,
 	__I40E_VFLR_EVENT_PENDING,
 	__I40E_RESET_RECOVERY_PENDING,
+	__I40E_TIMEOUT_RECOVERY_PENDING,
 	__I40E_MISC_IRQ_REQUESTED,
 	__I40E_RESET_INTR_RECEIVED,
 	__I40E_REINIT_REQUESTED,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0e5dc74b4ef2..419cf3faada6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -338,6 +338,10 @@ static void i40e_tx_timeout(struct net_device *netdev)
 		      (pf->tx_timeout_last_recovery + netdev->watchdog_timeo)))
 		return;   /* don't do any new action before the next timeout */
 
+	/* don't kick off another recovery if one is already pending */
+	if (test_and_set_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state))
+		return;
+
 	if (tx_ring) {
 		head = i40e_get_head(tx_ring);
 		/* Read interrupt register */
@@ -9632,6 +9636,7 @@ end_core_reset:
 	clear_bit(__I40E_RESET_FAILED, pf->state);
 clear_recovery:
 	clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+	clear_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state);
 }
 
 /**
-- 
2.19.1



