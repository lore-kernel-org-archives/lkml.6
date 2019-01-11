Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBBBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD322183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216103;
	bh=vGgYQhPF1YxlepAPJrgQ564x2GsAUr73OJqZPnT7iiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j/B4Y1111TUIC1Cg6JBkZ2mq7QsIVSS1SJKIRP6vIuf9n4lCOzOadGit7DyEPZPL8
	 T1XPmDG8P7LUI+dvMMN3xxlQli2NtNB9sfgTAXy0GgnKNlrLdjjW5+iC6w0n26vIa5
	 MyNJ8DVzySM9cFmd2ehvm3MivhKLDMj86J4BPJRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbfAKOPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbfAKOO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F74F2183F;
        Fri, 11 Jan 2019 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216097;
        bh=vGgYQhPF1YxlepAPJrgQ564x2GsAUr73OJqZPnT7iiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoWyqvT8oqzFCWENMLIOVePqtbVcdHePa4ywx761NNUhcf9yedc2NDDFN9pGxGznL
         1hbrPRB1ZSmm9I0AZERlGR++vfFFkQ8T9ndAsChKGHWNuaJT0BfuEI9H/twRrootYK
         6su1koNvRrmuFYaowgMGoTEa5OF1vpQ2UNoUK1M0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3.18 21/47] usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()
Date:   Fri, 11 Jan 2019 15:08:06 +0100
Message-Id: <20190111130958.840855386@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


