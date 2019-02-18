Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C83621916
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498852;
	bh=JqVaiQmCJHckK6CZZA8T/91+fk2kBhw8rEHV6HXnBn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7OvBrunG+UEIgOEj4QNav5ROkOG/tWXmD6Q9Sug46hdHOZQIAjfmF2UfD5M4rPDA
	 9nHaLOZFRsYAswDAFG9Cfp/vG+nDmdz+asAw4WkM+VcPf8x2/SYdDTKSbr/5Q4ifoJ
	 RPQ5Ly8HG+oUyubuhs6eGAjLarisP8D4aoGjB/as=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390696AbfBROHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390598AbfBROHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2073D21902;
        Mon, 18 Feb 2019 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498842;
        bh=JqVaiQmCJHckK6CZZA8T/91+fk2kBhw8rEHV6HXnBn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIiNzVQGOwJdkdCarKRHuABbRvQ01y9Fa609c8bk3WjkI/1D6Grz353XdJKTC1ZNg
         MyocPf5cI6+l1SoMGGsqnlcgvnQwej8BKeVlULROXpghk80jHeG+pVkS1U8sDlr9Gi
         oLE3F8hhk6lYqPM9rM/SoAdIGLi0lkHa4KWxtFqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Eric Dumazet <edumazet@google.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 139/143] smsc95xx: Use skb_cow_head to deal with cloned skbs
Date:   Mon, 18 Feb 2019 14:44:27 +0100
Message-Id: <20190218133534.051944906@linuxfoundation.org>
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

From: James Hughes <james.hughes@raspberrypi.org>

commit e9156cd26a495a18706e796f02a81fee41ec14f4 upstream.

The driver was failing to check that the SKB wasn't cloned
before adding checksum data.
Replace existing handling to extend/copy the header buffer
with skb_cow_head.

Signed-off-by: James Hughes <james.hughes@raspberrypi.org>
Acked-by: Eric Dumazet <edumazet@google.com>
Acked-by: Woojung Huh <Woojung.Huh@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/smsc95xx.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1838,13 +1838,13 @@ static struct sk_buff *smsc95xx_tx_fixup
 	/* We do not advertise SG, so skbs should be already linearized */
 	BUG_ON(skb_shinfo(skb)->nr_frags);
 
-	if (skb_headroom(skb) < overhead) {
-		struct sk_buff *skb2 = skb_copy_expand(skb,
-			overhead, 0, flags);
+	/* Make writable and expand header space by overhead if required */
+	if (skb_cow_head(skb, overhead)) {
+		/* Must deallocate here as returning NULL to indicate error
+		 * means the skb won't be deallocated in the caller.
+		 */
 		dev_kfree_skb_any(skb);
-		skb = skb2;
-		if (!skb)
-			return NULL;
+		return NULL;
 	}
 
 	if (csum) {


