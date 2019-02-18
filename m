Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE59C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D733217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498390;
	bh=KnlB6fXS18sErm5wdb046CK/z9LrfWhvylX+1O2emaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ApKvSlNF69YWs/YBTW1pRByLoms8qcD8YJnLvz3BTm4qwQtbn8ZR18HLurB0Z3Stq
	 wRPGRO78MTLkybgZC0w62M58mrzGqmndul3ldoyPM77WgcteGN4W69sM1zSnN9y4g8
	 4r2VXiZmFwPi1y44VDfbfykY1a2YkjaVOOANfyrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbfBRN7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388636AbfBRN7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E865520842;
        Mon, 18 Feb 2019 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498385;
        bh=KnlB6fXS18sErm5wdb046CK/z9LrfWhvylX+1O2emaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTG7cowCKtkYowl9UZrNxsKybc2BQx/F0lEsdL8Otj5grhc5SsmBKAJ9/2agnqWdR
         uZyajdW4znvBGf+ucWQsJ6iAYAOcnVI3LRIKIz31Mvn/JxXE7m+NXh4p4enlk4WL3G
         MA/YsOGmNM0KMgFWQ2QHW30WATnsA+bSxp3EDbfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Eric Dumazet <edumazet@google.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 52/58] smsc95xx: Use skb_cow_head to deal with cloned skbs
Date:   Mon, 18 Feb 2019 14:44:13 +0100
Message-Id: <20190218133512.479473907@linuxfoundation.org>
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
@@ -2011,13 +2011,13 @@ static struct sk_buff *smsc95xx_tx_fixup
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


