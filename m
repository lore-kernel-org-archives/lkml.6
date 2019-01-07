Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B7DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE9E2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866927;
	bh=kcbm2e3zG4QX4f/0lzDQ++0TcMfFjcs5xj917arg+ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxLbFSr6OaBq0a4I2r7x7GrXU1pbhLiCVOM/+S4j+XdzxGAJ6BrN1v4Hxs8QIsX6N
	 uSWqYTgeVSOHuXh1s86EEo8vj8PifZpyEzzNXhbfmNs/klXPEsMMcpx+CRI8CTPD7B
	 3tXKJdIz2uGNkqCJ8zVUBZZ8bTZJ4HdbXY3Hu0hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfAGNP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbfAGNBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9A2217D4;
        Mon,  7 Jan 2019 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866114;
        bh=kcbm2e3zG4QX4f/0lzDQ++0TcMfFjcs5xj917arg+ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sK59p67ROBm5yCnon5UnEVYY+XwAcr7bW6s/ty2FRtNwBfxnLU/kvZ7Q9xeUSXXff
         tZCIJ4BFzbmhiXYPZhkdPxoHvkhPar8MWH7GxVmjpPX0SMiqCDA8VLJ1U5udUGD9Qe
         jMcawgvKYFsFkn04JuNL/fQDk10Y+k562BsvJPhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 4.14 051/101] usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()
Date:   Mon,  7 Jan 2019 13:32:39 +0100
Message-Id: <20190107105335.721781205@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

From: Jia-Ju Bai <baijiaju1990@gmail.com>

commit c85400f886e3d41e69966470879f635a2b50084c upstream.

The function r8a66597_endpoint_disable() and r8a66597_urb_enqueue() may
be concurrently executed.
The two functions both access a possible shared variable "hep->hcpriv".

This shared variable is freed by r8a66597_endpoint_disable() via the
call path:
r8a66597_endpoint_disable
  kfree(hep->hcpriv) (line 1995 in Linux-4.19)

This variable is read by r8a66597_urb_enqueue() via the call path:
r8a66597_urb_enqueue
  spin_lock_irqsave(&r8a66597->lock)
  init_pipe_info
    enable_r8a66597_pipe
      pipe = hep->hcpriv (line 802 in Linux-4.19)

The read operation is protected by a spinlock, but the free operation
is not protected by this spinlock, thus a concurrency use-after-free bug
may occur.

To fix this bug, the spin-lock and spin-unlock function calls in
r8a66597_endpoint_disable() are moved to protect the free operation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/r8a66597-hcd.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -1990,6 +1990,8 @@ static int r8a66597_urb_dequeue(struct u
 
 static void r8a66597_endpoint_disable(struct usb_hcd *hcd,
 				      struct usb_host_endpoint *hep)
+__acquires(r8a66597->lock)
+__releases(r8a66597->lock)
 {
 	struct r8a66597 *r8a66597 = hcd_to_r8a66597(hcd);
 	struct r8a66597_pipe *pipe = (struct r8a66597_pipe *)hep->hcpriv;
@@ -2002,13 +2004,14 @@ static void r8a66597_endpoint_disable(st
 		return;
 	pipenum = pipe->info.pipenum;
 
+	spin_lock_irqsave(&r8a66597->lock, flags);
 	if (pipenum == 0) {
 		kfree(hep->hcpriv);
 		hep->hcpriv = NULL;
+		spin_unlock_irqrestore(&r8a66597->lock, flags);
 		return;
 	}
 
-	spin_lock_irqsave(&r8a66597->lock, flags);
 	pipe_stop(r8a66597, pipe);
 	pipe_irq_disable(r8a66597, pipenum);
 	disable_irq_empty(r8a66597, pipenum);


