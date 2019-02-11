Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B862FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781E021B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895874;
	bh=5Wz7R4jYFXzViboDSCx3FTdkCQNdbNhUfM7JYZoTQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8tXL6cu/Xa0DRlc0akGG60EVG/BavSbYLH3J4pNDNyXaSm2rNA5K8ywY+DvZJ0Wh
	 V22S7NGNlV+7kY+gB+4bxJ5EyS+YCwg3nT/khljrBDfa+t+EyppgzWsOcOMaogxAae
	 yvHWxwdzBIm3YuDMRYnMQ2M1i4FZ9GXGfnLBkwgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfBKOhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbfBKOhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA36720844;
        Mon, 11 Feb 2019 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895867;
        bh=5Wz7R4jYFXzViboDSCx3FTdkCQNdbNhUfM7JYZoTQ2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXtD+vYHcOwmQwJqtj/pUSYHtUlm1p1/mcM1XwlWvTd0w+YxaglA38pwH2DjYewlS
         NOkcmXpP5Fu2u4yYwqFoTRwvyZIHm5IoDHu6Ei5c1rpkAjdu5MVQkMyDXsJYqffVdi
         eIyakOrKaiM40cFeXUcbjmDdBKhcc+hy54jkZTaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 4.20 350/352] serial: sh-sci: Do not free irqs that have already been freed
Date:   Mon, 11 Feb 2019 15:19:37 +0100
Message-Id: <20190211141909.445654543@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

From: Chris Brandt <chris.brandt@renesas.com>

commit 4d95987a32db53f3beca76f8c4c8309ef6a5f192 upstream.

Since IRQs might be muxed on some parts, we need to pay attention when we
are freeing them.
Otherwise we get the ugly WARNING "Trying to free already-free IRQ 20".

Fixes: 628c534ae735 ("serial: sh-sci: Improve support for separate TEI and DRI interrupts")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1921,7 +1921,7 @@ out_nomem:
 
 static void sci_free_irq(struct sci_port *port)
 {
-	int i;
+	int i, j;
 
 	/*
 	 * Intentionally in reverse order so we iterate over the muxed
@@ -1937,6 +1937,13 @@ static void sci_free_irq(struct sci_port
 		if (unlikely(irq < 0))
 			continue;
 
+		/* Check if already freed (irq was muxed) */
+		for (j = 0; j < i; j++)
+			if (port->irqs[j] == irq)
+				j = i + 1;
+		if (j > i)
+			continue;
+
 		free_irq(port->irqs[i], port);
 		kfree(port->irqstr[i]);
 


