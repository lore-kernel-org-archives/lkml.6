Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415598-2-1408718382107362770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415598; b=r3Ka7OhaNX+li7cP/YoOt0kOrTaoMn1FRE4xEkWUh2TQ6QL
    iyPwurlx8s2RrEk7wfRz8oBIVsC/OZaHQ26YWUCtZ3E+C59kwrrFelYDYkNfrEXB
    HbWW/8eJeClNi7T0VPZG6lrqOdkFnzRaBwX0T55v8Hr+X/c06vsLvZiHYHJqPMuF
    ZU0ZXJ9krg9XRzFW2Ji39DNUxu4oB7Kwb0qpzieTB3x32SZP7NIpWRjILDkXoW0X
    g9+6sNmzEWcrzIRADvPdmSRPmxHjRdKzKPRfvn2jVVkZ+ZtnA35lEWnwmxtu4WEv
    bkxIItDywwfhdXIzl91YDezPfZJZQ4+kVkNHOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415598; bh=Ea96xClJDIDaGkZza9l5/V0vde
    gf6nvCZHeE9omklKc=; b=RV6IE5j5WT4Vbgw6Lp/WewSTxkUtFxcgdzSCZ0PL3z
    aQOteFyvdS84q9+NZWiMy36PJYRxEs2t+qf986cZW0zIbTApbK45pvWYUX5IUVbW
    RDVOz70lNfJYHCHLp4n9nHhDcRussFG0dpaPN5iSE28nn04o2QCQn3NH0r1rzt8p
    OxCtkhDl6sYk74fNdx6p7oBX/LI13pvjUiNHYTkvni6lCBejAKvz/qJuP526Dbb+
    b78z7csNEzbiDg8pCy4K8hPvwNy9/VzHdNg3ftHEDi44VoAPrvfpbvn3IvKhLwuz
    0mpelHOtnoiu91et+K8nmoPQh0365gVF6fklo6Fp1h1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeBWTw7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:52:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbeBWSpg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 075/145] ASoC: rockchip: disable clock on error
Date: Fri, 23 Feb 2018 19:26:21 +0100
Message-Id: <20180223170734.417523447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>


[ Upstream commit c7b92172a61b91936be985cb9bc499a4ebc6489b ]

Disable the clocks in  rk_spdif_probe when an error occurs after one
of the clocks has been enabled previously.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: f874b80e1571 ASoC: rockchip: Add rockchip SPDIF transceiver driver
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/rockchip/rockchip_spdif.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -318,26 +318,30 @@ static int rk_spdif_probe(struct platfor
 	spdif->mclk = devm_clk_get(&pdev->dev, "mclk");
 	if (IS_ERR(spdif->mclk)) {
 		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
-		return PTR_ERR(spdif->mclk);
+		ret = PTR_ERR(spdif->mclk);
+		goto err_disable_hclk;
 	}
 
 	ret = clk_prepare_enable(spdif->mclk);
 	if (ret) {
 		dev_err(spdif->dev, "clock enable failed %d\n", ret);
-		return ret;
+		goto err_disable_clocks;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err_disable_clocks;
+	}
 
 	spdif->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "hclk", regs,
 						  &rk_spdif_regmap_config);
 	if (IS_ERR(spdif->regmap)) {
 		dev_err(&pdev->dev,
 			"Failed to initialise managed register map\n");
-		return PTR_ERR(spdif->regmap);
+		ret = PTR_ERR(spdif->regmap);
+		goto err_disable_clocks;
 	}
 
 	spdif->playback_dma_data.addr = res->start + SPDIF_SMPDR;
@@ -369,6 +373,10 @@ static int rk_spdif_probe(struct platfor
 
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
+err_disable_clocks:
+	clk_disable_unprepare(spdif->mclk);
+err_disable_hclk:
+	clk_disable_unprepare(spdif->hclk);
 
 	return ret;
 }
