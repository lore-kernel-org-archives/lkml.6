Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8CCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAA520827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977450;
	bh=cOYgWFAVkKy0Tm5xkckzFCNnbsUu/726dQAXQF7jnd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JIRFlODxcXvzqA3m4gxnFJufxt+khmtDndOC7KLg0KhYN53rULaFp5fhyQwdLVDRM
	 t4SdPzUCff/C7mAVfhBh9ubi/eDDU1Y/Ms3GJ/HLRiVrMgbqmJs592VSbaKcVkGaE5
	 kWDqmGeIjQ/EM/+DEMdp9D6k/SQDeRJvSE0EdeCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfAHT5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbfAHT36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5639E20665;
        Tue,  8 Jan 2019 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975798;
        bh=cOYgWFAVkKy0Tm5xkckzFCNnbsUu/726dQAXQF7jnd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u23gvFhiDjws8VuS1FhUxOyOLMGMtvVm6tNSmyn6G+0JWXsOhPeadv2y98tOmEkCM
         adl0AaxCz804bIqPZhEzX3HMg4hsbDy3pE+LQSAVkrX5YUBZz5hEkQi5yfhe6nJmKd
         Y6gkZ75hB3KbtO0O0ABo9aRAPZYeLLmW+x3nPJlU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shannon Nelson <shannon.nelson@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/97] ixgbe: allow IPsec Tx offload in VEPA mode
Date:   Tue,  8 Jan 2019 14:28:14 -0500
Message-Id: <20190108192949.122407-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>

[ Upstream commit 7fa57ca443cffe81ce8416b57966bfb0370678a1 ]

When it's possible that the PF might end up trying to send a
packet to one of its own VFs, we have to forbid IPsec offload
because the device drops the packets into a black hole.
See commit 47b6f50077e6 ("ixgbe: disallow IPsec Tx offload
when in SR-IOV mode") for more info.

This really is only necessary when the device is in the default
VEB mode.  If instead the device is running in VEPA mode,
the packets will go through the encryption engine and out the
MAC/PHY as normal, and get "hairpinned" as needed by the switch.

So let's not block IPsec offload when in VEPA mode.  To get
there with the ixgbe device, use the handy 'bridge' command:
	bridge link set dev eth1 hwmode vepa

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index add124e0381d..b27f7a968820 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -4,6 +4,7 @@
 #include "ixgbe.h"
 #include <net/xfrm.h>
 #include <crypto/aead.h>
+#include <linux/if_bridge.h>
 
 /**
  * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
@@ -676,7 +677,8 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 	} else {
 		struct tx_sa tsa;
 
-		if (adapter->num_vfs)
+		if (adapter->num_vfs &&
+		    adapter->bridge_mode != BRIDGE_MODE_VEPA)
 			return -EOPNOTSUPP;
 
 		/* find the first unused index */
-- 
2.19.1

