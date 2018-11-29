Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3DAC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D933C213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9l+nbXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D933C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbeK3BdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbeK3BdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215532133F;
        Thu, 29 Nov 2018 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501666;
        bh=iSzZvdE4uB0giy3azf9ynZGXjuGr0TifaNN88t5gp3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9l+nbXW6WEevW6JSB9d2rEkk1pT27RZrbws0f9VQXy8NVEjHdFZw6kAMi1YsmEvk
         E9hPL+tO4l7LBQ/+COEQgdrQtCWItIpNuOmexYFG9wjescb0F/JwQqx6B/w69Mcx6A
         c0BnMCtjXm///uxKqaeubnNnFnRd+uRCrNLx4T9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 084/100] rtc: omap: fix error path when pinctrl_register fails
Date:   Thu, 29 Nov 2018 15:12:54 +0100
Message-Id: <20181129140106.039538463@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

commit 26e480f7bb7840fc0daa9c3af7c4501b2cf5902f upstream.

If pinctrl_register() fails probe will return with an error without locking
the RTC and disabling pm_runtime.
Set ret and jump to err instead.

Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-omap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -823,7 +823,8 @@ static int omap_rtc_probe(struct platfor
 	rtc->pctldev = pinctrl_register(&rtc_pinctrl_desc, &pdev->dev, rtc);
 	if (IS_ERR(rtc->pctldev)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
-		return PTR_ERR(rtc->pctldev);
+		ret = PTR_ERR(rtc->pctldev);
+		goto err;
 	}
 
 	if (rtc->is_pmic_controller) {


