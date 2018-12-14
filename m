Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656A5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D22A214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789381;
	bh=u66rdf+K7G++OZ6vVdlTbt0is7kfY3iDjyYCAEn5Zbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZV24e/GJUcXOY+bw+AFEWmDXy4DLrzMQ9Ofn2vq4GwQZRb8nOBlYkD60k4scsPmH
	 iMZCh5FaikAl9AlX3chmJVBkIamEFtdLGALCqRkz9CrSCYYlc4ErSbhqbHS1TCwBEh
	 rr/ETTDAzN8r560X3OhCI1ju+eFWonyHecMI37nM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D22A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbeLNMJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbeLNMJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5152147D;
        Fri, 14 Dec 2018 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789374;
        bh=u66rdf+K7G++OZ6vVdlTbt0is7kfY3iDjyYCAEn5Zbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/Xqlqu1HE2ezJYI2txG6CrXQgaHKCmUVbSN1o9GyKwU1c24AIkitq7nRTqM8H2AC
         RTG+vNnlAD4Ebe/uDB1Qfe04xMGqtU/UV5vftxgobwlxgaLXXAsY1aN1EYAYwF59kz
         KE2xOHn8mF0bEWkf63i6NTIks5fzepqFU0epzCkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 58/89] usb: gadget: u_ether: fix unsafe list iteration
Date:   Fri, 14 Dec 2018 13:00:11 +0100
Message-Id: <20181214115732.534019910@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c9287fa657b3328b4549c0ab39ea7f197a3d6a50 ]

list_for_each_entry_safe() is not safe for deleting entries from the
list if the spin lock, which protects it, is released and reacquired during
the list iteration. Fix this issue by replacing this construction with
a simple check if list is empty and removing the first entry in each
iteration. This is almost equivalent to a revert of the commit mentioned in
the Fixes: tag.

This patch fixes following issue:
--->8---
Unable to handle kernel NULL pointer dereference at virtual address 00000104
pgd = (ptrval)
[00000104] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 84 Comm: kworker/1:1 Not tainted 4.20.0-rc2-next-20181114-00009-g8266b35ec404 #1061
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
Workqueue: events eth_work
PC is at rx_fill+0x60/0xac
LR is at _raw_spin_lock_irqsave+0x50/0x5c
pc : [<c065fee0>]    lr : [<c0a056b8>]    psr: 80000093
sp : ee7fbee8  ip : 00000100  fp : 00000000
r10: 006000c0  r9 : c10b0ab0  r8 : ee7eb5c0
r7 : ee7eb614  r6 : ee7eb5ec  r5 : 000000dc  r4 : ee12ac00
r3 : ee12ac24  r2 : 00000200  r1 : 60000013  r0 : ee7eb5ec
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6d5dc04a  DAC: 00000051
Process kworker/1:1 (pid: 84, stack limit = 0x(ptrval))
Stack: (0xee7fbee8 to 0xee7fc000)
...
[<c065fee0>] (rx_fill) from [<c0143b7c>] (process_one_work+0x200/0x738)
[<c0143b7c>] (process_one_work) from [<c0144118>] (worker_thread+0x2c/0x4c8)
[<c0144118>] (worker_thread) from [<c014a8a4>] (kthread+0x128/0x164)
[<c014a8a4>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xee7fbfb0 to 0xee7fbff8)
...
---[ end trace 64480bc835eba7d6 ]---

Fixes: fea14e68ff5e ("usb: gadget: u_ether: use better list accessors")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_ether.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index bdbc3fdc7c4f..3a0e4f5d7b83 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -405,12 +405,12 @@ static int alloc_requests(struct eth_dev *dev, struct gether *link, unsigned n)
 static void rx_fill(struct eth_dev *dev, gfp_t gfp_flags)
 {
 	struct usb_request	*req;
-	struct usb_request	*tmp;
 	unsigned long		flags;
 
 	/* fill unused rxq slots with some skb */
 	spin_lock_irqsave(&dev->req_lock, flags);
-	list_for_each_entry_safe(req, tmp, &dev->rx_reqs, list) {
+	while (!list_empty(&dev->rx_reqs)) {
+		req = list_first_entry(&dev->rx_reqs, struct usb_request, list);
 		list_del_init(&req->list);
 		spin_unlock_irqrestore(&dev->req_lock, flags);
 
@@ -1125,7 +1125,6 @@ void gether_disconnect(struct gether *link)
 {
 	struct eth_dev		*dev = link->ioport;
 	struct usb_request	*req;
-	struct usb_request	*tmp;
 
 	WARN_ON(!dev);
 	if (!dev)
@@ -1142,7 +1141,8 @@ void gether_disconnect(struct gether *link)
 	 */
 	usb_ep_disable(link->in_ep);
 	spin_lock(&dev->req_lock);
-	list_for_each_entry_safe(req, tmp, &dev->tx_reqs, list) {
+	while (!list_empty(&dev->tx_reqs)) {
+		req = list_first_entry(&dev->tx_reqs, struct usb_request, list);
 		list_del(&req->list);
 
 		spin_unlock(&dev->req_lock);
@@ -1154,7 +1154,8 @@ void gether_disconnect(struct gether *link)
 
 	usb_ep_disable(link->out_ep);
 	spin_lock(&dev->req_lock);
-	list_for_each_entry_safe(req, tmp, &dev->rx_reqs, list) {
+	while (!list_empty(&dev->rx_reqs)) {
+		req = list_first_entry(&dev->rx_reqs, struct usb_request, list);
 		list_del(&req->list);
 
 		spin_unlock(&dev->req_lock);
-- 
2.19.1



