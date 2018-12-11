Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6422146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543726;
	bh=NpVw8TFo+75Ye6QSzYp35tGYf1GLwYOQ0138JmVeEzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BQiq59lDw2g/7l9Q5nJ4q6bNboygQzsiZfc+lZnXUxSlPZhKNgoDHtAP4KKYxmZgi
	 dBK02YbBDq4oUwE/8pqi/+/KAOeOowIUx5GofndFO/EKltJtdWpIaurtymqsl+DXzG
	 oQQmZ7+5ZA8hFll5tnxF7sakkLKc1mib0BfaqZ68=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6422146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeLKPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbeLKPzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751C82146F;
        Tue, 11 Dec 2018 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543722;
        bh=NpVw8TFo+75Ye6QSzYp35tGYf1GLwYOQ0138JmVeEzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfrrIl+X0D8cBKd/0frQM4XffjRHpUNMB7mD3oDo+U+ks2kgStsx1rllTNgBdrKOT
         KjEtd9oyb8s+DLXvkCjfy4m97brnz1qrHmnq1kKz2KQJn7f00wW7pv/JMhoQ+VhCSr
         +8hLOM/SIb+47YEkA+Va/OiLcxuJfBGsstduiuzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/118] brcmutil: really fix decoding channel info for 160 MHz bandwidth
Date:   Tue, 11 Dec 2018 16:40:25 +0100
Message-Id: <20181211151644.478944899@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



