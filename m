Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D58C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4A20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey4KmOr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC4A20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbeKCD7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbeKCD7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:19 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6513F2082D;
        Fri,  2 Nov 2018 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184665;
        bh=3JlnOaZ7iTs+3EVS7/d3F1jFfG4TkW9FMDliUFyaGrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ey4KmOr1jGd8Tuz9/R36fznt0leowO3d1KRYNf286xH13kmNEs40n23ANj2DVHozv
         z1jM0Ky70WME9Gn1XBnMKcwVg9nm8r7yyKtR7i6AJfzcHNzf2LkDe4VhW4op1L+qr1
         tMD+N6WuWbgkeIYjBrzmE4zMgiLzszAYylJ4ovxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/143] net: phy: realtek: Use the dummy stubs for MMD register access for rtl8211b
Date:   Fri,  2 Nov 2018 19:34:08 +0100
Message-Id: <20181102182902.186313539@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit 0231b1a074c672f8c00da00a57144072890d816b ]

The Ethernet on mpc8315erdb is broken since commit b6b5e8a69118
("gianfar: Disable EEE autoneg by default"). The reason is that
even though the rtl8211b doesn't support the MMD extended registers
access, it does return some random values if we trying to access
the MMD register via indirect method. This makes it seem that the
EEE is supported by this phy device. And the subsequent writing to
the MMD registers does cause the phy malfunction. So use the dummy
stubs for the MMD register access to fix this issue.

Fixes: b6b5e8a69118 ("gianfar: Disable EEE autoneg by default")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 9cbe645e3d89..7d38af5ed4b5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -138,6 +138,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= &genphy_read_status,
 		.ack_interrupt	= &rtl821x_ack_interrupt,
 		.config_intr	= &rtl8211b_config_intr,
+		.read_mmd	= &genphy_read_mmd_unsupported,
+		.write_mmd	= &genphy_write_mmd_unsupported,
 	}, {
 		.phy_id		= 0x001cc914,
 		.name		= "RTL8211DN Gigabit Ethernet",
-- 
2.17.1



