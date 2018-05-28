Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034413AbeE1PfF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031783AbeE1KSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:18:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 079/268] usb: gadget: fsl_udc_core: fix ep valid checks
Date: Mon, 28 May 2018 12:00:53 +0200
Message-Id: <20180528100211.017805803@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 20c63f4089cceab803438c383631963e34c4d8e5 ]

Clang reports the following warning:
  drivers/usb/gadget/udc/fsl_udc_core.c:1312:10: warning: address of array
  'ep->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (ep->name)
        ~~  ~~~~^~~~

It seems that the authors intention was to check if the ep has been
configured through struct_ep_setup. Check whether struct usb_ep name
pointer has been set instead.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1310,7 +1310,7 @@ static void udc_reset_ep_queue(struct fs
 {
 	struct fsl_ep *ep = get_ep_by_pipe(udc, pipe);
 
-	if (ep->name)
+	if (ep->ep.name)
 		nuke(ep, -ESHUTDOWN);
 }
 
@@ -1698,7 +1698,7 @@ static void dtd_complete_irq(struct fsl_
 		curr_ep = get_ep_by_pipe(udc, i);
 
 		/* If the ep is configured */
-		if (curr_ep->name == NULL) {
+		if (!curr_ep->ep.name) {
 			WARNING("Invalid EP?");
 			continue;
 		}
