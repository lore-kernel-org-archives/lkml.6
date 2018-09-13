Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E126C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B1A204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B1A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeIMTHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:07:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbeIMTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:07:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16D92D0E;
        Thu, 13 Sep 2018 13:57:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Winnie Chang <winnie.chang@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 102/197] brcmfmac: fix brcmf_wiphy_wowl_params() NULL pointer dereference
Date:   Thu, 13 Sep 2018 15:30:51 +0200
Message-Id: <20180913131845.625470873@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Winnie Chang <winnie.chang@cypress.com>

[ Upstream commit 27a8aea13053700ad2a08189024df7e341d1ee51 ]

The kernel BUG happens when wowl is enabled from firmware. In
brcmf_wiphy_wowl_params(), cfg is a NULL pointer because it is
drvr->config returned from wiphy_to_cfg(), and drvr->config is not set
yet. To fix it, set drvr->config before brcmf_setup_wiphy() which
calls brcmf_wiphy_wowl_params().

Fixes: 856d5a011c86 ("brcmfmac: allocate struct brcmf_pub instance using wiphy_new()")
Signed-off-by: Winnie Chang <winnie.chang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6926,15 +6926,15 @@ struct brcmf_cfg80211_info *brcmf_cfg802
 	cfg->d11inf.io_type = (u8)io_type;
 	brcmu_d11_attach(&cfg->d11inf);
 
-	err = brcmf_setup_wiphy(wiphy, ifp);
-	if (err < 0)
-		goto priv_out;
-
 	/* regulatory notifer below needs access to cfg so
 	 * assign it now.
 	 */
 	drvr->config = cfg;
 
+	err = brcmf_setup_wiphy(wiphy, ifp);
+	if (err < 0)
+		goto priv_out;
+
 	brcmf_dbg(INFO, "Registering custom regulatory\n");
 	wiphy->reg_notifier = brcmf_cfg80211_reg_notifier;
 	wiphy->regulatory_flags |= REGULATORY_CUSTOM_REG;


