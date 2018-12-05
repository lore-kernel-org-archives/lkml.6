Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A5420989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1/V4mhlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A5420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeLEJpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbeLEJpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:45:51 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD43920878;
        Wed,  5 Dec 2018 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003150;
        bh=3vGwVMEMlLYDWVhD1VGjQU1Nm5BnbDVeD+MI+GhG7QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/V4mhlLN9Kk3Ib4UlVFYmycCDuy129nedM8RZiK9t6aOMp7Wha1ozYflHWZPmWTs
         d7LjU26Vl7oD2okFAXNwRMDI/rs+6EciIjZs9bacBKb1YAsXzibrPwuAzY8sBvaWZi
         9suVQz1SxhoiduSThx1OBm4NDqkkI6CNWQDTTM8I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 45/69] usb: gadget: u_ether: fix unsafe list iteration
Date:   Wed,  5 Dec 2018 04:42:23 -0500
Message-Id: <20181205094247.6556-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

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
2.17.1

