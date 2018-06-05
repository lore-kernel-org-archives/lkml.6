Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeFERDj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeFERDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vinod.koul@intel.com>, Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 4.4 24/37] dmaengine: usb-dmac: fix endless loop in usb_dmac_chan_terminate_all()
Date: Tue,  5 Jun 2018 19:01:29 +0200
Message-Id: <20180605170110.301507773@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit d9f5efade2cfd729138a7cafb46d01044da40f5e upstream.

This patch fixes an issue that list_for_each_entry() in
usb_dmac_chan_terminate_all() is possible to cause endless loop because
this will move own desc to the desc_freed. So, this driver should use
list_for_each_entry_safe() instead of list_for_each_entry().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/sh/usb-dmac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -448,7 +448,7 @@ usb_dmac_prep_slave_sg(struct dma_chan *
 static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
 {
 	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
-	struct usb_dmac_desc *desc;
+	struct usb_dmac_desc *desc, *_desc;
 	unsigned long flags;
 	LIST_HEAD(head);
 	LIST_HEAD(list);
@@ -459,7 +459,7 @@ static int usb_dmac_chan_terminate_all(s
 	if (uchan->desc)
 		uchan->desc = NULL;
 	list_splice_init(&uchan->desc_got, &list);
-	list_for_each_entry(desc, &list, node)
+	list_for_each_entry_safe(desc, _desc, &list, node)
 		list_move_tail(&desc->node, &uchan->desc_freed);
 	spin_unlock_irqrestore(&uchan->vc.lock, flags);
 	vchan_dma_desc_free_list(&uchan->vc, &head);
