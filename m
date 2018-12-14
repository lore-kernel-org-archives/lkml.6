Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7420C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A32145D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788931;
	bh=iYQ3IuS7oJkwenEmgmcEei/Af/KQVQjptK3XaKfep+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4VliuDfvUvHZiO8Rej81b9aLT+qclz9MFJ5x/pGNSJkHfORAzPIqigoNQW3X7tEN
	 Gg5jBIVNPKzoKQalYumxH1ZdW5epbxH1ed20j/uLZ3eZ9eoqrVsFM4oLDXIzng7KE1
	 eb3HUDSWLgC38fWvNY1AvyXtgciAGVhNZ46GfF3I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1A32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeLNMCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbeLNMCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64AD12146F;
        Fri, 14 Dec 2018 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788924;
        bh=iYQ3IuS7oJkwenEmgmcEei/Af/KQVQjptK3XaKfep+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEGMVwEYhL3m4W+5srmeq8qDAvbYo/w17SRnHaCqVd60twiF5SrsZiF/9YVyzsS6J
         pcJXaN24Rav9EHB0kN241eGEBI8JNcc591QcvHj1/vm2CuXwea1nNVPN5XQRIdYCsI
         50xm//sQpH39XGrKQhPoZ1zFW0mGRuuPV7qUUcb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 018/142] net: phy: sfp: correct store of detected link modes
Date:   Fri, 14 Dec 2018 12:58:23 +0100
Message-Id: <20181214115747.776236898@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit d7f7e0018b96fd1a30a968faa9464eb57372c1ec ]

The link modes that sfp_parse_support() detects are stored in the
'modes' bitmap. There is no reason to make an exception for 1000Base-PX
or 1000Base-BX10.

Fixes: 03145864bd0f ("sfp: support 1G BiDi (eg, FiberStore SFP-GE-BX) modules")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp-bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -162,7 +162,7 @@ void sfp_parse_support(struct sfp_bus *b
 	/* 1000Base-PX or 1000Base-BX10 */
 	if ((id->base.e_base_px || id->base.e_base_bx10) &&
 	    br_min <= 1300 && br_max >= 1200)
-		phylink_set(support, 1000baseX_Full);
+		phylink_set(modes, 1000baseX_Full);
 
 	/* For active or passive cables, select the link modes
 	 * based on the bit rates and the cable compliance bytes.


