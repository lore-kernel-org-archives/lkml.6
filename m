Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233012183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762107;
	bh=SjLGWloHvwVs3FzcOl9pV6Sr4U6vsAN4HU5d1+ukNXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x5hGfHVeXYUUUz8mDGSSpsYM6K7o5+z9O2JJ2JqncFAiLlTy/2j8rGPjbqTG8e4Vu
	 hm03yp0Hslnm4VrLsviOc7kKTYF7IVwMIIHGvEmuj6FnMUGcpicSGNuUQwapPADQ+v
	 JzhX28ByEQNAXSBMXwV8TRaBm4ixenPDEBGRH5dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfA2Llp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbfA2Llm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EAA4214DA;
        Tue, 29 Jan 2019 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762101;
        bh=SjLGWloHvwVs3FzcOl9pV6Sr4U6vsAN4HU5d1+ukNXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEmLMsT4KfQ/TcEjlD+j4EUEW0unEcEJSPIFfd3B1dYwyIoX6YwxyAEIptvM6cXF3
         mzLPge0QFLkuIzhDct5UYTe/OCVekWQeYdEdjFWW1+NPeScuQMmGibj2p7jqBojwG1
         zc/Cw+7Pu6styzvZuWGYmCh2Nx0oU9cceB4ofSyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 4.20 110/117] mt76x0: do not overwrite other MT_BBP(AGC, 8) fields
Date:   Tue, 29 Jan 2019 12:36:01 +0100
Message-Id: <20190129113212.860583260@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit b983a5b900627faa49cf37e101d65b56e941c740 upstream.

MT_BBP(AGC, 8) register has values depend on band in
mt76x0_bbp_switch_tab, so we should not overwrite other fields
than MT_BBP_AGC_GAIN when setting gain.

This can fix performance issues when connecting to 2.4GHz AP.

Fixes: 4636a2544c3b ("mt76x0: phy: align channel gain logic to mt76x2 one")
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -817,10 +817,8 @@ done:
 static void mt76x0_phy_set_gain_val(struct mt76x02_dev *dev)
 {
 	u8 gain = dev->cal.agc_gain_cur[0] - dev->cal.agc_gain_adjust;
-	u32 val = 0x122c << 16 | 0xf2;
 
-	mt76_wr(dev, MT_BBP(AGC, 8),
-		val | FIELD_PREP(MT_BBP_AGC_GAIN, gain));
+	mt76_rmw_field(dev, MT_BBP(AGC, 8), MT_BBP_AGC_GAIN, gain);
 }
 
 static void


