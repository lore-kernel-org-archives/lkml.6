Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1FDC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638A42146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999303;
	bh=gVai3G6ImL00/4iTH799Kp5aUbGml+sQVwADkbdxaTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGpg94lkdCH1Ld26RVNibqnzL869aJFtKiSJqoMWKWrfP8lgh+3r9MMRnYwPpc6a6
	 MSnCv7FHFqS6+jUj9vKRT1zagKJkRs69VPnECcjufVjhA10iVyR3k2AbekbhbeU/c6
	 nIS1CE4UMi4u06OuHHm3HxifmpRuuIImCObKy8vU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeL1MPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbeL1MPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5492087F;
        Fri, 28 Dec 2018 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999300;
        bh=gVai3G6ImL00/4iTH799Kp5aUbGml+sQVwADkbdxaTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSKnaPinkFvgntK+LnEYhs0+6HtnvD1GikuTnG2K4tOQyKIvtrCPzzv1VRJHL/aDV
         UGqx7kLx1m05YIGsKFW8T3YibkW9Cb+GCi1NN0MZ4DZGNTCxq6jPEW16IZW4ZmQpI1
         7gYzf2FUycSUXXV25Wg81PiMx3+Bng4I2bPkIW2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 05/46] USB: xhci: fix broken_suspend placement in struct xchi_hcd
Date:   Fri, 28 Dec 2018 12:51:59 +0100
Message-Id: <20181228113125.188140278@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

commit 2419f30a4a4fcaa5f35111563b4c61f1b2b26841 upstream.

As commented in the struct's definition there shouldn't be anything
underneath its 'priv[0]' member as it would break some macros.

The patch converts the broken_suspend into a bit-field and relocates it
next to to the rest of bit-fields.

Fixes: a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0 xHC")
Reported-by: Oliver Neukum  <oneukum@suse.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1860,6 +1860,8 @@ struct xhci_hcd {
 	unsigned		sw_lpm_support:1;
 	/* support xHCI 1.0 spec USB2 hardware LPM */
 	unsigned		hw_lpm_support:1;
+	/* Broken Suspend flag for SNPS Suspend resume issue */
+	unsigned		broken_suspend:1;
 	/* cached usb2 extened protocol capabilites */
 	u32                     *ext_caps;
 	unsigned int            num_ext_caps;
@@ -1877,8 +1879,6 @@ struct xhci_hcd {
 	void			*dbc;
 	/* platform-specific data -- must come last */
 	unsigned long		priv[0] __aligned(sizeof(s64));
-	/* Broken Suspend flag for SNPS Suspend resume issue */
-	u8			broken_suspend;
 };
 
 /* Platform specific overrides to generic XHCI hc_driver ops */


