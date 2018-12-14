Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBC2214F0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789681;
	bh=ysLGjNstYE1yTf0QwlRrwaXEeJ/CTKZ6VvXcNSOEAoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZS4ech2OUgwK2LoEuqg5mCYC6K8nUQ2fKF0dMlnZwvVIo7i3r+qJZHIcZEWRLe5XS
	 ECdgPPaXAYyzag5YwLEcx8oZwg2K5gwDnz5ctbL1FsYHfVNCfRSvkFp1Sdcp0OzwTK
	 LFwphhFwU+O7tUr+d+/JsnJ5VaFussew2dlpF/8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBC2214F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbeLNMOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbeLNMOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF842133F;
        Fri, 14 Dec 2018 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789677;
        bh=ysLGjNstYE1yTf0QwlRrwaXEeJ/CTKZ6VvXcNSOEAoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ftHR//hDwH0OMZl5BzQaIk3JNaApjWT94Z1lGiKUvRazL8IDNVQGW4920WeH3Ca1
         MeHoTSSekuHY9gyNlpCLTG7aJgjgG0z1D8POg1XNy6WcVtQ8T78V4UBGbn77XK9wNC
         lDRKx3ZaUfiRZJRxaXgCvhCPVK2ry0Z1n6HZgJIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 11/88] ARM: OMAP1: ams-delta: Fix possible use of uninitialized field
Date:   Fri, 14 Dec 2018 12:59:45 +0100
Message-Id: <20181214115703.090857218@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
2.19.1



