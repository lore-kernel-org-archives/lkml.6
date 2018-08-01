Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C7CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD282083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD282083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407045AbeHATNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:13:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405304AbeHATNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:13:07 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26DD7CC3;
        Wed,  1 Aug 2018 17:26:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaul Triebitz <shaul.triebitz@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 040/144] iwlwifi: pcie: fix race in Rx buffer allocator
Date:   Wed,  1 Aug 2018 18:51:07 +0200
Message-Id: <20180801164951.988309828@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaul Triebitz <shaul.triebitz@intel.com>

[ Upstream commit 0f22e40053bd5378ad1e3250e65c574fd61c0cd6 ]

Make sure the rx_allocator worker is canceled before running the
rx_init routine.  rx_init frees and re-allocates all rxb's pages.  The
rx_allocator worker also allocates pages for the used rxb's.  Running
rx_init and rx_allocator simultaniously causes a kernel panic.  Fix
that by canceling the work in rx_init.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -898,6 +898,8 @@ int iwl_pcie_rx_init(struct iwl_trans *t
 						WQ_HIGHPRI | WQ_UNBOUND, 1);
 	INIT_WORK(&rba->rx_alloc, iwl_pcie_rx_allocator_work);
 
+	cancel_work_sync(&rba->rx_alloc);
+
 	spin_lock(&rba->lock);
 	atomic_set(&rba->req_pending, 0);
 	atomic_set(&rba->req_ready, 0);


