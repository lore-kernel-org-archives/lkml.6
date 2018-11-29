Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2026C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AEB2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLf9SMuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AEB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbeK3BgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbeK3BgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC7E213A2;
        Thu, 29 Nov 2018 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501834;
        bh=Sjtsc8UtpR+CgvobE22SWmw96RIC8pCB57Ul1nFgU00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLf9SMuMJ/GmA78cYh9CieGrtMC28IVuTXOzPA+O9fXFkLDdezr9+nPcGOFrejuLB
         BZu2HxH1DCHQudv7uTP1TksIrAmVzkOXMRt57lK5A3es6pIKou69CZ63nxcXpirIaC
         w9mwcf5KNx10yP+afc7zjSXowiBLmTfoAtqCD5kQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 026/110] brcmfmac: fix reporting support for 160 MHz channels
Date:   Thu, 29 Nov 2018 15:11:57 +0100
Message-Id: <20181129135922.318018858@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

commit d1fe6ad6f6bd61c84788d3a7b11e459a439c6169 upstream.

Driver can report IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ so it's
important to provide valid & complete info about supported bands for
each channel. By default no support for 160 MHz should be assumed unless
firmware reports it for a given channel later.

This fixes info passed to the userspace. Without that change userspace
could try to use invalid channel and fail to start an interface.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Cc: stable@vger.kernel.org
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5997,7 +5997,8 @@ static int brcmf_construct_chaninfo(stru
 			 * for subsequent chanspecs.
 			 */
 			channel->flags = IEEE80211_CHAN_NO_HT40 |
-					 IEEE80211_CHAN_NO_80MHZ;
+					 IEEE80211_CHAN_NO_80MHZ |
+					 IEEE80211_CHAN_NO_160MHZ;
 			ch.bw = BRCMU_CHAN_BW_20;
 			cfg->d11inf.encchspec(&ch);
 			chaninfo = ch.chspec;


