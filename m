Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F9EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7C620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbeLQNhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:37:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:43776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbeLQNhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:37:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C29EABD5;
        Mon, 17 Dec 2018 13:37:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, sandeep.singh@amd.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: fix 'broken_suspend' placement in struct xchi_hcd
Date:   Mon, 17 Dec 2018 14:37:40 +0100
Message-Id: <20181217133740.5342-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commented in the struct's definition there shouldn't be anything
underneath it's 'priv[0]' member as it would break some macros.

The patch converts the broken_suspend into a bit-field and relocates it
next to to the rest of bit-fields.

Fixes: a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0 xHC")
Reported-by: Oliver Neukum  <oneukum@suse.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/xhci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index c3515bad5dbb..011dd45f8718 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1863,6 +1863,8 @@ struct xhci_hcd {
 	unsigned		sw_lpm_support:1;
 	/* support xHCI 1.0 spec USB2 hardware LPM */
 	unsigned		hw_lpm_support:1;
+	/* Broken Suspend flag for SNPS Suspend resume issue */
+	unsigned		broken_suspend:1;
 	/* cached usb2 extened protocol capabilites */
 	u32                     *ext_caps;
 	unsigned int            num_ext_caps;
@@ -1880,8 +1882,6 @@ struct xhci_hcd {
 	void			*dbc;
 	/* platform-specific data -- must come last */
 	unsigned long		priv[0] __aligned(sizeof(s64));
-	/* Broken Suspend flag for SNPS Suspend resume issue */
-	u8			broken_suspend;
 };
 
 /* Platform specific overrides to generic XHCI hc_driver ops */
-- 
2.19.2

