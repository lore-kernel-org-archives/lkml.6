Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04669C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D622146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129199;
	bh=rC+SgekFYvRHiGA2gOvvoCUuDA3N5VsrjNVBCdgTIZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kX6f9issD3G3aQe7YNIm9uGlCXMIdV94CIYm1SWbrfsw5tKj4+D/oVCrSoFt2AJrH
	 Pfo5Lz5xZczxc4DoyIiGLrgyAm3MO19ZovcSTGDzA673G4xCuQqEdlCE+ruFnjmvxM
	 1raTSs6ilp0eOyt9R1jO4+89PdMedVfCxQVHaQM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfBYVNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbfBYVNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:13:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9590320C01;
        Mon, 25 Feb 2019 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129196;
        bh=rC+SgekFYvRHiGA2gOvvoCUuDA3N5VsrjNVBCdgTIZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Asy84AUVCV/8ZEF5j2zu0MnVzkPZJUKnFRAfcHqUa7QL6sy1zygeNYOPoiJHo1KEd
         lNRPRdhZX7/y2i9t9eQInaS702VHWOzE7rLlMpNijq/QEFTvywZ3W1zas+6XEKw18i
         N711xeIwUQxgsg9WMYilH2FqGTdo50TAG1kOVqw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 10/63] mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported
Date:   Mon, 25 Feb 2019 22:11:10 +0100
Message-Id: <20190225195036.509533066@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a177276aa098aa47a100d51a13eaaef029604b6d ]

If the PMIC ID is unknown, the current code would call
irq_domain_remove and panic, as pmic->irq_domain is only
initialized by mt6397_irq_init.

Return immediately with an error, if the chip ID is unsupported.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mt6397-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index e14d8b058f0c2..5d4c10f05450a 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -306,8 +306,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	default:
 		dev_err(&pdev->dev, "unsupported chip: %d\n", id);
-		ret = -ENODEV;
-		break;
+		return -ENODEV;
 	}
 
 	if (ret) {
-- 
2.19.1



