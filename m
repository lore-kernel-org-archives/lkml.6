Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61288ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA4B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZH4XMlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA4B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeKIHd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeKIHd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:26 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 496C120892;
        Thu,  8 Nov 2018 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714159;
        bh=Fj0xoSowgJC1syHO4wMKt/hSaQPK/bXK06M2klkqJnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZH4XMlKgGd9jn2k5fOC/m97GJH9Bb0K6hrv7uQPVQMra194rWHoK3OyVJS71INpB
         maLa1TsSgGDW30jmQIwYG+tbMYkwvdKAaD4TvbLb2JNL0KhRljgyswrPcWTdBxbe+y
         zY9hN5qNgfFlCnm1JHLpVaiucTZNIG6vdJ9rA5NU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vince Hsu <vinceh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 062/144] usb: host: ehci-tegra: request deferred probe when failing to get phy
Date:   Thu,  8 Nov 2018 13:50:33 -0800
Message-Id: <20181108215059.360135270@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f56e67f0a880a5b795cdb5f62614aafe264c5304 ]

The commit 1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error on
failure") changed the condition to return -EPROBE_DEFER to host driver.
Originally the Tegra host driver depended on the returned -EPROBE_DEFER to
get the phy device later when booting. Now we have to do that explicitly.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index aad253559bcd..b4cc4c90b8e3 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -451,7 +451,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 
 	u_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
 	if (IS_ERR(u_phy)) {
-		err = PTR_ERR(u_phy);
+		err = -EPROBE_DEFER;
 		goto cleanup_clk_en;
 	}
 	hcd->usb_phy = u_phy;
-- 
2.17.1



