Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C866218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YYo8l7fA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfBRGDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:03:20 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:23763 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfBRGDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:03:20 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1I617hQ006910;
        Mon, 18 Feb 2019 15:01:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1I617hQ006910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550469670;
        bh=qOxNgKzvwDnjG50PQePnvnPUqjWVkaPbhPq17iGF30M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYo8l7fAwJT/nx0ArY/No5xP16LoQ3HbWUe2PSY3OXR7minn3wmrACWbJVQP46EUb
         ZswDcrb30TOQbhhfqbbx39fmJqILnNiRlBjFFFthNsUROoQWh4+5NUjxxWz5dQp8iQ
         l9688rRodF0N+Lq0e3BwZWksHw4xCOHZgSmkr5XIpqrzUlPYuTLBNhcbfgYGes8aLK
         W3cpwF7az8tkzQR+R+c1Voco6bX3GzYy/SDYEBPyU4+uh82DDlhL0B305UuXV7B5M8
         ePYFGl65I1Ti0kcbqewERUBfr/MYJWpmLu96A7NbMyHSnE/Czm/M22YmBHwAl9H2Sk
         MTI3qGDusKrlw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/2] wireless: mt76: call hweight8() instead of __sw_hweight8()
Date:   Mon, 18 Feb 2019 14:59:30 +0900
Message-Id: <1550469571-25933-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550469571-25933-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__sw_hweight8() is just internal implementation.

Drivers should use the common API, hweight8().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This patch should go to x86 tree along with 2/2.

Otherwise, all{yes,mod}config of x86 would be broken.

This patch is trivial enough.
I want ACK from the net/wireless maintainer
so that this can go in via x86 tree.


 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7b926df..c42e0d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -124,7 +124,7 @@ static void mt76_init_stream_cap(struct mt76_dev *dev,
 				 bool vht)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
-	int i, nstream = __sw_hweight8(dev->antenna_mask);
+	int i, nstream = hweight8(dev->antenna_mask);
 	struct ieee80211_sta_vht_cap *vht_cap;
 	u16 mcs_map = 0;
 
-- 
2.7.4

