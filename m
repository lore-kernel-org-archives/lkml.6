Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3323CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D6020663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358776;
	bh=HClIW6MAWfcqv6atvCfVU6578NuHhDuSYGB3JZ2LEeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ksEqyn9GNTqeevIVPKoG9xtcnmvtnooDkrqnAraw2ks/8oXT5JHVxrv018WV27/gm
	 db0oWow691QI8FWKOTgmqst99WM8fA9k/fnn/aEjWTZwxlykgth1JSusCcIst36iTU
	 cILlXcf9vEOFmsde3s7/CIALXOFEBSk8qnb+ONOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbfAXTje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbfAXTjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D841820663;
        Thu, 24 Jan 2019 19:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358771;
        bh=HClIW6MAWfcqv6atvCfVU6578NuHhDuSYGB3JZ2LEeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEpt51yXk1sOXoiBYfO3z0Kg2PvptSoHIqyoxAcUCSLV0DzCHSkW7QwGB0EEbew2C
         TLNHaU2HeKP6GJYLQ7V8E/WYklMUOqarO/9MBfy8u4QlW/5XSJg6rUu/mlrNybh0ku
         cVTXmd0pv6mCPIJXIlDNfhuRMkd8h0MbdXr/yAM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 020/127] ixgbe: allow IPsec Tx offload in VEPA mode
Date:   Thu, 24 Jan 2019 20:19:26 +0100
Message-Id: <20190124190213.081281188@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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
index fd1b0546fd67..4d77f42e035c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -4,6 +4,7 @@
 #include "ixgbe.h"
 #include <net/xfrm.h>
 #include <crypto/aead.h>
+#include <linux/if_bridge.h>
 
 #define IXGBE_IPSEC_KEY_BITS  160
 static const char aes_gcm_name[] = "rfc4106(gcm(aes))";
@@ -693,7 +694,8 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 	} else {
 		struct tx_sa tsa;
 
-		if (adapter->num_vfs)
+		if (adapter->num_vfs &&
+		    adapter->bridge_mode != BRIDGE_MODE_VEPA)
 			return -EOPNOTSUPP;
 
 		/* find the first unused index */
-- 
2.19.1



