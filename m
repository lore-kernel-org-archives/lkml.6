Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02045217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498399;
	bh=kR216GrfSalPzPX82UrnXjeTki067F74faW46FXbyTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpoy/Bo1fHSw3qXaLhX5+3rWPOyDF/6EXCYlagSVofDM99Qajq7rSWkPKAh7cWP1U
	 yGwhwOktMNPbHPBB81Za3mUYOyfnVvkZCdk18duqtXBNqLFOEqsz/mVwd1JpJw4beB
	 dOF3JDqAAcvuK2viW0JCvvLlYHuu+w3N9oxitw2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbfBRN7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388673AbfBRN7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175F62173C;
        Mon, 18 Feb 2019 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498388;
        bh=kR216GrfSalPzPX82UrnXjeTki067F74faW46FXbyTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybID3I6uBMTdo1Ra7F00vKA6EFffge8HMCNRs7dEBFHvfGToLnoSJ5/EmDLpi8RXO
         WIv7B96RL2AhtJ17Phji5IFQdI49D/bnMRuP+zOnHQRSOUmow9UcNehB2aldaE/Urd
         ihrDaVd9HtLedYZVNwEQJGAjN0jiYGasn+eWmiEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        James Hughes <james.hughes@raspberrypi.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 53/58] ch9200: use skb_cow_head() to deal with cloned skbs
Date:   Mon, 18 Feb 2019 14:44:14 +0100
Message-Id: <20190218133512.532827950@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -254,14 +254,9 @@ static struct sk_buff *ch9200_tx_fixup(s
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


