Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774EE217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499217;
	bh=iGSty/t/LG9JCeF29kNW5Xz6I/iqQZAfyOnaxwJCZpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rds3KWya/0h4Mx+2qcS7AFpfmkzO0E7NMsMiTojfgx/GwA+90fv3kHX5vnuaizOYY
	 5pWcm4bE1FiPH+bClcwLSWLYAPX95hne9Hz07/0mki57h0B+lUZLf9SKfGPDk3SgPb
	 ZJE6FU01LiyDsCAIZFHoccNG6Pa2o9+xjqyQrvNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392377AbfBRONg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:13:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390865AbfBRONe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:13:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F53121916;
        Mon, 18 Feb 2019 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499213;
        bh=iGSty/t/LG9JCeF29kNW5Xz6I/iqQZAfyOnaxwJCZpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVnsNKnq1IPiqnljsb1SpPpXcp8F9+q8rWE/kBtejv7zu+P/wEt9SeglYC6TisRiY
         L3vTH9cI/TT4v42HC+znuWFiSKBl9Mk2VQN2ehXZNk7d0OwKC6pkTh80/QlBdA26j6
         7ueC2IPONTWfNzLn5vPqsJRWxehfjdzXr7Umrxko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Eric Dumazet <edumazet@google.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3.18 105/108] smsc95xx: Use skb_cow_head to deal with cloned skbs
Date:   Mon, 18 Feb 2019 14:44:41 +0100
Message-Id: <20190218133524.538568786@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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
@@ -1841,13 +1841,13 @@ static struct sk_buff *smsc95xx_tx_fixup
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


