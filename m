Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D06AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B67214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895094;
	bh=u3MOgmOtwIW87rkuKCih30XLb8uFK6dtM+VyM69JsGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z1FzeOVgacv2oBHyZGpOHnvwa+lQjIqP+Lpa1XKV4+o6Flg7q9SUOW4eImfvTPh65
	 M6tNFT/K7tdyrScuQTWFYFfBGGArHZSaiu4VtNSbjjfYpT0Gltc/ZOotBmYG7Glt0Y
	 L+CrBMHr7FFT+u8F1S80Hh1GKpSuLMJ7ZQ8qjRVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfBKOYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbfBKOYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE2920821;
        Mon, 11 Feb 2019 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895087;
        bh=u3MOgmOtwIW87rkuKCih30XLb8uFK6dtM+VyM69JsGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2nVj2sxQSvpNzKN9+QNuGepP+9eChHt9c0wpmZ46RXysuOKZg99cs2Kh0YkLKkpq
         +5cuOvYAvPVnc8W2+vIhCC6pI8bmFrYONGvvd2kywk2WqhgL3BgESapoyc3d6hEXO1
         VF2aE2vOOcW/phKcyHbJtir1oWtVIEwduO9ZYBT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 088/352] soc: bcm: brcmstb: Dont leak device tree node reference
Date:   Mon, 11 Feb 2019 15:15:15 +0100
Message-Id: <20190211141851.525310475@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 1861a7f07e02292830a1ca256328d370deefea30 ]

of_find_node_by_path() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. soc_is_brcmstb()
doesn't do that, so fix it.

[treding: slightly rewrite to avoid inline comparison]

Fixes: d52fad262041 ("soc: add stubs for brcmstb SoC's")
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/brcmstb/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 14185451901d..bf9123f727e8 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -31,13 +31,17 @@ static const struct of_device_id brcmstb_machine_match[] = {
 
 bool soc_is_brcmstb(void)
 {
+	const struct of_device_id *match;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(brcmstb_machine_match, root) != NULL;
+	match = of_match_node(brcmstb_machine_match, root);
+	of_node_put(root);
+
+	return match != NULL;
 }
 
 u32 brcmstb_get_family_id(void)
-- 
2.19.1



