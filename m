Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8513AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425AA214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789341;
	bh=C9gKq6ZWM31LoCsGWBRUGGfvgjTjB1ZaxSd3YrxNws0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKVzY5dW+NOrrFdjYAANNDwLYTjAxnCCrvyEkZ4VweamrzSJyXVuXP4Xn4ZyHBOD6
	 KcIoJ3xIPk/yT8wQ53R2alP/SnxTyCHgGpDEOr0YgPwVsE1glUasUifvGGSPR9AHaI
	 9tdQrCLOW5HGF9qByhQuQ0WSdaA0GrHx0r3UyykQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425AA214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbeLNMJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbeLNMIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52736214AE;
        Fri, 14 Dec 2018 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789333;
        bh=C9gKq6ZWM31LoCsGWBRUGGfvgjTjB1ZaxSd3YrxNws0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIA0nyXOzCaCmockgL9qvdh+kv3Rk3fWoEXG1dZpT7iP4zV1TnNTYDcXWcAgTgyoy
         izVSTkWJVDOR14nnSbbSiT2cjDOpYXLwdkH1owoYq4CGRQLtS8MkLvvaP5jKC/IUQr
         dEbDvSOwvxbDhIzuZpxAdC/sFeN2optYWINHSNns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/89] ARM: OMAP1: ams-delta: Fix possible use of uninitialized field
Date:   Fri, 14 Dec 2018 12:59:33 +0100
Message-Id: <20181214115730.672599793@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cec83ff1241ec98113a19385ea9e9cfa9aa4125b ]

While playing with initialization order of modem device, it has been
discovered that under some circumstances (early console init, I
believe) its .pm() callback may be called before the
uart_port->private_data pointer is initialized from
plat_serial8250_port->private_data, resulting in NULL pointer
dereference.  Fix it by checking for uninitialized pointer before using
it in modem_pm().

Fixes: aabf31737a6a ("ARM: OMAP1: ams-delta: update the modem to use regulator API")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 6cbc69c92913..4174fa86bfb1 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -512,6 +512,9 @@ static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
 	struct modem_private_data *priv = port->private_data;
 	int ret;
 
+	if (!priv)
+		return;
+
 	if (IS_ERR(priv->regulator))
 		return;
 
-- 
2.19.1



