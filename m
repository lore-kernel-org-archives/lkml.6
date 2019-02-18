Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C77C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDC821902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499631;
	bh=GOIvIRpU0chVvV+RmTJzOfG37+kJrxH5TWmeDV7iBIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SD/beBKz1MnTVBNYh5q+nrGmojPwvx9BeZdwq5V3Ls/ebcPcztIshb4mg3dvMALNn
	 1DJZhiIVSGl/W9vT9QR3mPFy5eHjcqeNa4jn2FportnyI5aFqEKMAONW8HJzMILuXj
	 FnK0KcxMaIivlMm/I7g2Dq7vTkWfOE9GOGjMkTqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbfBROH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389177AbfBROHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B4A204FD;
        Mon, 18 Feb 2019 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498845;
        bh=GOIvIRpU0chVvV+RmTJzOfG37+kJrxH5TWmeDV7iBIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz5wR2cMfsn46Gz9FFmXhFdUVvfjJsqv7WRAroFUzvRoV9ClEGEqxQnJ4D0SML827
         CYOLdfX5f0iUtXTdJpzVCsVt3EmYTNqOK0RfcQfjxaS6CBjbnlZlc6VVybJL9PCVvm
         3A5lkzgIoOqQzNOg67CYV/8zNTIRctXC4bqXgpaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        James Hughes <james.hughes@raspberrypi.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 140/143] ch9200: use skb_cow_head() to deal with cloned skbs
Date:   Mon, 18 Feb 2019 14:44:28 +0100
Message-Id: <20190218133534.087242246@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 6bc6895bdd6744e0136eaa4a11fbdb20a7db4e40 upstream.

We need to ensure there is enough headroom to push extra header,
but we also need to check if we are allowed to change headers.

skb_cow_head() is the proper helper to deal with this.

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Hughes <james.hughes@raspberrypi.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/ch9200.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -255,14 +255,9 @@ static struct sk_buff *ch9200_tx_fixup(s
 	tx_overhead = 0x40;
 
 	len = skb->len;
-	if (skb_headroom(skb) < tx_overhead) {
-		struct sk_buff *skb2;
-
-		skb2 = skb_copy_expand(skb, tx_overhead, 0, flags);
+	if (skb_cow_head(skb, tx_overhead)) {
 		dev_kfree_skb_any(skb);
-		skb = skb2;
-		if (!skb)
-			return NULL;
+		return NULL;
 	}
 
 	__skb_push(skb, tx_overhead);


