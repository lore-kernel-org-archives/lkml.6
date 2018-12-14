Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AEAC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08E721104
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789498;
	bh=tzmnZHjnAkQPNGKx9ZOHi9DRaihGdiCfE6FfiSeveKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x2TjdGNuAVXFTgApsO6sX4yqkhtQeeUf8O99AB6CNWEEFwRSESWmC9phf2bFaUcdR
	 WmwW0jBlL2QlWiaJqKHOgXfRb7oKY4qdzBtVmxmRf0Gtp9zqDTvQCeG7BYQJBfk3Ly
	 OR4FMG4rq+tStXqi4m8tGcN++AKXwPa+3s3du848=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08E721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbeLNMLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731260AbeLNMLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7ABD21104;
        Fri, 14 Dec 2018 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789490;
        bh=tzmnZHjnAkQPNGKx9ZOHi9DRaihGdiCfE6FfiSeveKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1Qbdh25xsWRsnhhKF9olPQU8DvaoAKUdSdyd6pfpjGzVxA3LsevfGa5za+Fh4jFB
         RYbTwnzzW17cRIb6c0jz7QNIKDnzsxmgh4MV78wHzZBqSLldZ548aRWGalz8OKy7BW
         UGvnIHuQRxOl22KeAdtyMfAPpgD2boPJKtmmtj8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 13/51] ARM: OMAP1: ams-delta: Fix possible use of uninitialized field
Date:   Fri, 14 Dec 2018 13:00:15 +0100
Message-Id: <20181214115714.522010480@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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
index 6613a6ff5dbc..c4b634c54fbd 100644
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



