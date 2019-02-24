Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFEFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BC1206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0L1P3kT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfBXPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:37:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43366 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id j1so5017262lfb.10;
        Sun, 24 Feb 2019 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1XvdviBJbc6vSgkc2chDhC1JD6NzFTJEiFh3CALAxo=;
        b=i0L1P3kTVKSGDoDsSMcFJNc8F16CIfGNmCYOWsEI4DtoA0+/2O6ttilq2en1h07Yac
         l2SRsHKDJtI6DYjbE28jU36rF8Jrmjawt4dghGodv3xnTdiHpgy5K/fllDmXpAB9ruRH
         8fFLvdIId8IIYVtbGnGJ8aPuEK2nigykAMFLJk70Gxx31ofW+tz5SjS1bmX0RFKY2GAz
         g2VKjfntWACPfKSFeT+r4s5So3lj23a5zb7MpssS0OpZ5JA2hzzzH4r65fBlqcQOp5Fi
         JFtIh2FHKrHBg8tGu/o2L1QRMIx7Fyey+dg5MKs/QC3rIgX/zuCXn5+6CMVHjIBsgOpZ
         jN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1XvdviBJbc6vSgkc2chDhC1JD6NzFTJEiFh3CALAxo=;
        b=ZpmvOZowC1ykRr3Wb5xx7WfjdlOsGGEEhgTsb5PCyEhEVoeZGuAuH5XQlvYpMrNgkp
         2wy+QJa344ylPGNIdjpXzhDprniBUFngBB5dc+VsdwrErvR+uuAZVtHAnSjgNcTgZk7U
         qv7YbZA4+/Laa/J6tDNV1ivgnsNV4f1tagEnOKhz6UQvDI2PM6LpN+lCValChvQZnBf3
         FwYm8yUaom22v5ee94nEJ1B5e31i6Zpj8+gJL60WumJJsZbv+jGXjEwNk+IhBw/JOfHy
         lmGApdt/o8aiYfWtPsOE/N7Q7ySLwfMwhQTsNGbbrPNy1k/X2MFlVtDmlkFULy8vrEPk
         j+Sw==
X-Gm-Message-State: AHQUAuYkdg/6iU5a7FyeRxS6DjzBVm3NJvogHhpT7jm/SAmaw+kAT6uO
        cTB6J5V7ijcwgOb02PiiXB0=
X-Google-Smtp-Source: AHgI3IajcnIHNmsiyooG75qWqnFRpCnFPea0+zyzEC5rpnWmwpOOATEr61FY75ecKsGS9LX5FtD7bA==
X-Received: by 2002:a19:3f44:: with SMTP id m65mr3870352lfa.136.1551022631798;
        Sun, 24 Feb 2019 07:37:11 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id a5sm126359lfk.12.2019.02.24.07.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:37:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] usb: chipidea: tegra: Fix missed ci_hdrc_remove_device()
Date:   Sun, 24 Feb 2019 18:36:22 +0300
Message-Id: <20190224153622.8877-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ChipIdea's platform device need to be unregistered on Tegra's driver
module removal.

Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for Tegra20/30/114/124")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 772851bee99b..12025358bb3c 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -130,6 +130,7 @@ static int tegra_udc_remove(struct platform_device *pdev)
 {
 	struct tegra_udc *udc = platform_get_drvdata(pdev);
 
+	ci_hdrc_remove_device(udc->dev);
 	usb_phy_set_suspend(udc->phy, 1);
 	clk_disable_unprepare(udc->clk);
 
-- 
2.20.1

