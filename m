Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A674206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865843;
	bh=mB1D4nLrLuWydR1SgvPtK3zcUWWwgjlBTmqqiy1y8zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VemhQKeEa7OoPERWFI1e2jGbfBAL10OOmEXTb8AZOVuPChZQsV3QWs8pmRShUTZFY
	 Y6h6naNFUnXypdm0FEu6Gkm+ktjb2EwbKKjMDbXe41f32eYL9J0NDyjCubMg8VZCOT
	 Q385vydR6SJoHTKOfkrpiKqbpGRjIRG7bjVjXW9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfAGM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbfAGM5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FB8206BB;
        Mon,  7 Jan 2019 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865836;
        bh=mB1D4nLrLuWydR1SgvPtK3zcUWWwgjlBTmqqiy1y8zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzJEF7sCuSiwJGfEvGV/A8Ew7fo/suHZbPhnLeCmRUCK+huj/9mpANDKncizN9y6w
         HFLZ8W0X6/vowloikmCIMfZ0ml1R7KXoxl3REvo+TJ8B6f6TnJ9mwFkDhJPCJOZrc8
         vW9/Q4ZWggm26iw6tjXOxs0GGUzrBseIFnEuntSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Stijn Tintel <stijn@linux-ipv6.be>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 132/170] brcmfmac: fix roamoff=1 modparam
Date:   Mon,  7 Jan 2019 13:32:39 +0100
Message-Id: <20190107104508.553438774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Stijn Tintel <stijn@linux-ipv6.be>

commit 8c892df41500469729e0d662816300196e4f463d upstream.

When the update_connect_param callback is set, nl80211 expects the flag
WIPHY_FLAG_SUPPORTS_FW_ROAM to be set as well. However, this flag is
only set when modparam roamoff=0, while the callback is set
unconditionally. Since commit 7f9a3e150ec7 this causes a warning in
wiphy_register, which breaks brcmfmac.

Disable the update_connect_param callback when roamoff=0 to fix this.

Fixes: 7f9a3e150ec7 ("nl80211: Update ERP info using NL80211_CMD_UPDATE_CONNECT_PARAMS")
Cc: Stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |   11 +++++++++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h |    2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     |    2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5188,10 +5188,17 @@ static struct cfg80211_ops brcmf_cfg8021
 	.del_pmk = brcmf_cfg80211_del_pmk,
 };
 
-struct cfg80211_ops *brcmf_cfg80211_get_ops(void)
+struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
 {
-	return kmemdup(&brcmf_cfg80211_ops, sizeof(brcmf_cfg80211_ops),
+	struct cfg80211_ops *ops;
+
+	ops = kmemdup(&brcmf_cfg80211_ops, sizeof(brcmf_cfg80211_ops),
 		       GFP_KERNEL);
+
+	if (ops && settings->roamoff)
+		ops->update_connect_params = NULL;
+
+	return ops;
 }
 
 struct brcmf_cfg80211_vif *brcmf_alloc_vif(struct brcmf_cfg80211_info *cfg,
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -404,7 +404,7 @@ struct brcmf_cfg80211_info *brcmf_cfg802
 void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg);
 s32 brcmf_cfg80211_up(struct net_device *ndev);
 s32 brcmf_cfg80211_down(struct net_device *ndev);
-struct cfg80211_ops *brcmf_cfg80211_get_ops(void);
+struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings);
 enum nl80211_iftype brcmf_cfg80211_get_iftype(struct brcmf_if *ifp);
 
 struct brcmf_cfg80211_vif *brcmf_alloc_vif(struct brcmf_cfg80211_info *cfg,
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1130,7 +1130,7 @@ int brcmf_attach(struct device *dev, str
 
 	brcmf_dbg(TRACE, "Enter\n");
 
-	ops = brcmf_cfg80211_get_ops();
+	ops = brcmf_cfg80211_get_ops(settings);
 	if (!ops)
 		return -ENOMEM;
 


