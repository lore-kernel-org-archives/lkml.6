Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1B6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D1D21508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DunsjbJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D1D21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbeKLITl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387903AbeKLITl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:41 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4EA8223C8;
        Sun, 11 Nov 2018 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975384;
        bh=N2oCScyL6DUr3q6W7sPeQtkLsopN/FURe7iv0DgCi4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DunsjbJqErq4z2iydQ79LQytVb4iBRZ5wDaLIu/2XzEn5RmB7342Qebx0HrpsffAW
         VrqulFnK+vnz0AkDW1qsoPee6II/vx9EpTy4hEAieP7zE6V8RzF6JI9JcDerR4wmwc
         07ku14pvnKeasY0HfAzlGdF4XNSS01ywKNYJAY6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 060/350] r8169: re-enable MSI-X on RTL8168g
Date:   Sun, 11 Nov 2018 14:18:44 -0800
Message-Id: <20181111221709.664572109@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 9675931e6b65d160d16bcc9472c1acef15524def ]

Similar to d49c88d7677b ("r8169: Enable MSI-X on RTL8106e") after
e9d0ba506ea8 ("PCI: Reprogram bridge prefetch registers on resume")
we can safely assume that this also fixes the root cause of
the issue worked around by 7c53a722459c ("r8169: don't use MSI-X on
RTL8168g"). So let's revert it.

Fixes: 7c53a722459c ("r8169: don't use MSI-X on RTL8168g")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7544,11 +7544,6 @@ static int rtl_alloc_irq(struct rtl8169_
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
-		/* This version was reported to have issues with resume
-		 * from suspend when using MSI-X
-		 */
-		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
 	} else {
 		flags = PCI_IRQ_ALL_TYPES;
 	}


