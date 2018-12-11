Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA746C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5DD2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544590;
	bh=eIERhGfJsswgvS4s5qiIFpY+fcK/sJgD3J+Bb9PLy3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WnNcRgILB4nqrdb2I271lWix9jeJ0QyeRjRK9NJfg0HisU1hMmQ7YBVC0s7TS+h16
	 Kb2o4K3qeE6/RKc6Dqhvdaubo0ji5ZzhMQyTq5VfW1UPNrYrqC1m7GUTpimbPPmsS6
	 AtAb8WIogEdfgo6AcdruOwUykxut3NqGJoioCJrM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5DD2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeLKQJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeLKPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0A520855;
        Tue, 11 Dec 2018 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543523;
        bh=eIERhGfJsswgvS4s5qiIFpY+fcK/sJgD3J+Bb9PLy3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIB/zYuUbe1PEZbQj+8T1jGYFUG0dzO2de0q7yq7sEXX8PyS45+0kd73CVdlGGqzb
         t9hnCp60lRnsvZAPu6bCycf6SUxDLS+NfNXxsU7mwZZtdDq3zVp0aEPdrIAfXeqL61
         o+33d1FzMU1KYdul30+VM7oxi3gO1H3Z9Rvz6ZfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/67] brcmutil: really fix decoding channel info for 160 MHz bandwidth
Date:   Tue, 11 Dec 2018 16:41:03 +0100
Message-Id: <20181211151630.539205550@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

[ Upstream commit 3401d42c7ea2d064d15c66698ff8eb96553179ce ]

Previous commit /adding/ support for 160 MHz chanspecs was incomplete.
It didn't set bandwidth info and didn't extract control channel info. As
the result it was also using uninitialized "sb" var.

This change has been tested for two chanspecs found to be reported by
some devices/firmwares:
1) 60/160 (0xee32)
   Before: chnum:50 control_ch_num:36
    After: chnum:50 control_ch_num:60
2) 120/160 (0xed72)
   Before: chnum:114 control_ch_num:100
    After: chnum:114 control_ch_num:120

Fixes: 330994e8e8ec ("brcmfmac: fix for proper support of 160MHz bandwidth")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c b/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
index e7584b842dce..eb5db94f5745 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
@@ -193,6 +193,9 @@ static void brcmu_d11ac_decchspec(struct brcmu_chan *ch)
 		}
 		break;
 	case BRCMU_CHSPEC_D11AC_BW_160:
+		ch->bw = BRCMU_CHAN_BW_160;
+		ch->sb = brcmu_maskget16(ch->chspec, BRCMU_CHSPEC_D11AC_SB_MASK,
+					 BRCMU_CHSPEC_D11AC_SB_SHIFT);
 		switch (ch->sb) {
 		case BRCMU_CHAN_SB_LLL:
 			ch->control_ch_num -= CH_70MHZ_APART;
-- 
2.19.1



