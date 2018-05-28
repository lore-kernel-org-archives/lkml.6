Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165081AbeE1NAu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164144AbeE1Kxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 273/496] brcmfmac: Fix check for ISO3166 code
Date: Mon, 28 May 2018 12:00:58 +0200
Message-Id: <20180528100331.355200675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 9b9322db5c5a1917a66c71fe47c3848a9a31227e ]

The commit "regulatory: add NUL to request alpha2" increases the length of
alpha2 to 3. This causes a regression on brcmfmac, because
brcmf_cfg80211_reg_notifier() expect valid ISO3166 codes in the complete
array. So fix this accordingly.

Fixes: 657308f73e67 ("regulatory: add NUL to request alpha2")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6916,7 +6916,7 @@ static void brcmf_cfg80211_reg_notifier(
 		return;
 
 	/* ignore non-ISO3166 country codes */
-	for (i = 0; i < sizeof(req->alpha2); i++)
+	for (i = 0; i < 2; i++)
 		if (req->alpha2[i] < 'A' || req->alpha2[i] > 'Z') {
 			brcmf_err("not an ISO3166 code (0x%02x 0x%02x)\n",
 				  req->alpha2[0], req->alpha2[1]);
