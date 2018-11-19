Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E968D208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KLQpjX1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E968D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeKTCNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:13:12 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58038 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeKTCNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:13:12 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181119154911euoutp023f4e15263c4a1fd88aaba53e0479c7b3~okTo2T01n0109601096euoutp02F;
        Mon, 19 Nov 2018 15:49:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181119154911euoutp023f4e15263c4a1fd88aaba53e0479c7b3~okTo2T01n0109601096euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542642551;
        bh=U61DFbqU4/j/S6HZQ/0L8qEvnKt6ffKePJTCPev7DvQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KLQpjX1IZLdu3CXJSuO28JsDhR+hRM9UBGEIVL+fKN2rseSK0PvCn+Mp9pPOiBnhs
         EgSMGAbvScVda5eqGhFQzkp5cEvet/c8ky9hdS3mRpTpg/l8ly3HCZXrJ9KIN0rjmG
         5OYClDQkJUZfDtbHg8EBdS99PM0pmnBcOrUj49gw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181119154911eucas1p14c853424f8d7d65b3a6807c759d4d3dd~okToYizm11409314093eucas1p16;
        Mon, 19 Nov 2018 15:49:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0B.57.04441.67BD2FB5; Mon, 19
        Nov 2018 15:49:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181119154910eucas1p2ff5c6609b22365b20ef6e57fe599ec33~okTntEUpD1949019490eucas1p2G;
        Mon, 19 Nov 2018 15:49:10 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-8e-5bf2db76bc25
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.0A.04128.67BD2FB5; Mon, 19
        Nov 2018 15:49:10 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PIG00EAJ6LU8W60@eusync1.samsung.com>;
        Mon, 19 Nov 2018 15:49:10 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] usb: gadget: u_ether: fix unsafe list iteration
Date:   Mon, 19 Nov 2018 16:49:05 +0100
Message-id: <20181119154905.17685-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7djPc7pltz9FG6zo0LfYOGM9q8Wxtifs
        Fs2L17NZXN41h81ixvl9TBaLlrUyW6w9cpfdgd1j06pONo/9c9ewe/RtWcXo8XmTXABLFJdN
        SmpOZllqkb5dAlfGre1PWQoWyFbM7F3J1sB4SKKLkZNDQsBEYt7qNaxdjFwcQgIrGCUe3ZnH
        COF8ZpT4MfMCC0zVt3sL2CASyxglvvSsY4FwGpgkXs1ZxApSxSZgKNH1tosNxBYRSJA4sXc7
        WAezwG5GiVUf1zGCJIQFHCTWffoPZrMIqEp8nfoerIFXwFZi262ZTBDr5CVWbzjADNIsIfCQ
        VeJV80l2iISLxM0zMxkhbGGJV8e3QMVlJC5P7maBaGhmlGifMYsdwulhlNg6ZwcbRJW1xOHj
        F8FuZRbgk5i0bTrQCg6gOK9ER5sQRImHxPKtz8EWCAnESkz5tYp5AqPEAkaGVYziqaXFuemp
        xYZ5qeV6xYm5xaV56XrJ+bmbGIExdvrf8U87GL9eSjrEKMDBqMTDK3H8Y7QQa2JZcWXuIUYJ
        DmYlEd6AZZ+ihXhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBK
        NTCyz9jLzqU7eeGN4IXbT+5ZK9D+rKhhufK002YXeMWCu/OMagoOBfOtFOSxaf31gOVK14r4
        T8bBr2MDlhUIeNYv93p6rS5I5v4U8/UFutvEOjVUT5WIiXybu/+VnMjDHP87rZ3t8SF9yq//
        Xju2X/qdpFp5k3xgrvNl00LV6eWlNhq/Xlo4CCixFGckGmoxFxUnAgDgC/NtrQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJMWRmVeSWpSXmKPExsVy+t/xy7pltz9FG3TuFLbYOGM9q8Wxtifs
        Fs2L17NZXN41h81ixvl9TBaLlrUyW6w9cpfdgd1j06pONo/9c9ewe/RtWcXo8XmTXABLFJdN
        SmpOZllqkb5dAlfGre1PWQoWyFbM7F3J1sB4SKKLkZNDQsBE4tu9BWwgtpDAEkaJ30vSuxi5
        gOwmJonWZ19YQRJsAoYSXW+7wIpEBBIkLm6cyQhSxCywl1Hiw6ROsCJhAQeJdZ/+M4LYLAKq
        El+nvgdr4BWwldh2ayYTxDZ5idUbDjBPYORawMiwilEktbQ4Nz232EivODG3uDQvXS85P3cT
        IzAEth37uWUHY9e74EOMAhyMSjy8B458jBZiTSwrrsw9xCjBwawkwhuw7FO0EG9KYmVValF+
        fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6pBsYJs2fXeZb5vfF4E/KHy0nm
        QvH3/GtHz1zqNDQ4odqzr++W2dcJC17NcM9/0XW4znf2+l+tIWHaYumCvYHf63/7XZt2SSHZ
        pat1rZeETalQsW11/EkfgYlGwvO3djnNS+jVSTDpY8zM8Zki9eDdGZ5Nle9Py/MrGEet+Mdd
        kvvn1ZVPmyL4eJRYijMSDbWYi4oTAWJPOr39AQAA
X-CMS-MailID: 20181119154910eucas1p2ff5c6609b22365b20ef6e57fe599ec33
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181119154910eucas1p2ff5c6609b22365b20ef6e57fe599ec33
References: <CGME20181119154910eucas1p2ff5c6609b22365b20ef6e57fe599ec33@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/usb/gadget/function/u_ether.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 1000d864929c..0f026d445e31 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -401,12 +401,12 @@ static int alloc_requests(struct eth_dev *dev, struct gether *link, unsigned n)
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

