Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AC2C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB13C20693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="IcEJ+fje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB13C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754346AbeFQLNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:13:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44500 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeFQLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:13:06 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 03DC95C019E;
        Sun, 17 Jun 2018 13:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529233985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=VPgxNF9QFrrAXHGesHwS3fGFmhoFiJfMl/w6w8MyCYA=;
        b=IcEJ+fjeQ4g72uet7vlC2moveOzJrKua8qZ8EmSaujDpnDZEJsAG/9mDjfz9zv+aJgKaGq
        o7HndCPflLU+TOavRthg8XU7jCj6KMeKfYlc+kTv+8tNQfxfZhL9aZEkC5YlWgqfckEobN
        JnZc/ynKdhKvr+trVnYIbHfnx4oSmxs=
From:   Stefan Agner <stefan@agner.ch>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Agner <stefan@agner.ch>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: tegra: fix runtime PM error handling
Date:   Sun, 17 Jun 2018 13:12:55 +0200
Message-Id: <20180617111258.13447-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address-of operator will always evaluate to true. However,
power should be explicitly disabled if no power domain is used.

Remove the address-of operator.

Fixes: 58c38116c6cc ("usb: xhci: tegra: Add support for managing powergates")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/usb/host/xhci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index a8c1d073cba0..33daac4136e8 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1223,10 +1223,10 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	usb_put_hcd(tegra->hcd);
 disable_xusbc:
-	if (!&pdev->dev.pm_domain)
+	if (!pdev->dev.pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
 disable_xusba:
-	if (!&pdev->dev.pm_domain)
+	if (!pdev->dev.pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
-- 
2.17.1

