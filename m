Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86C72082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwClIpS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86C72082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeLEJwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbeLEJwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:52:32 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3EA02082B;
        Wed,  5 Dec 2018 09:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003551;
        bh=Y7nzyWC/pFLAU+NDxbqGx3tHE0CBNamVkyFTK7qY3Ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwClIpS9I0nHfWn/yhCZaQWvrT3LG6cza9zJPcQbnTWSVQaPZxGMMzJbcBjaXjVbb
         dpMGUCtjPiAbDBqbIUo3RJ4UdypYV85En1YzqLpC4vO0oAi2FL2DjdfTz401RcZqlT
         1lwV1Ipq8vmjEF/KUYuH/0227AEI74QnvwXM2rH0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 02/33] ARM: OMAP1: ams-delta: Fix possible use of uninitialized field
Date:   Wed,  5 Dec 2018 04:51:00 -0500
Message-Id: <20181205095131.7685-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

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
index a95499ea8706..fa1d41edce68 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -511,6 +511,9 @@ static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
 {
 	struct modem_private_data *priv = port->private_data;
 
+	if (!priv)
+		return;
+
 	if (IS_ERR(priv->regulator))
 		return;
 
-- 
2.17.1

