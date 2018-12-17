Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F63FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362AE217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="InK8bBXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeLQJMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:12:20 -0500
Received: from ni.piap.pl ([195.187.100.4]:43180 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQJMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:12:20 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 6F371441E45;
        Mon, 17 Dec 2018 10:12:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 6F371441E45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1545037935; bh=9REB8f30WGRuS0Tcl1g6Pqrfjh6KRQ6kdeVVt5jKBBU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=InK8bBXtAyGN0is62NNooyS8c9LvJvK/7yj/t7jVlxBLDLad1ivUaLjcLI6hnEwyl
         icA38aJ5QjRIp3NP7aUOByxV0vIznyP2Uiacca0riUd/O3Ak/YNoFXE/vmIc2jgGt3
         1ozK/4OXm7DEzkAiKawsEL4qdcGV7gsl0o06Whbc=
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
References: <m3o9a2hni5.fsf@t19.piap.pl>
        <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
Date:   Mon, 17 Dec 2018 10:12:14 +0100
In-Reply-To: <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
        (Fabio Estevam's message of "Mon, 3 Dec 2018 09:21:32 -0200")
Message-ID: <m3va3sh5zl.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 132976 [Dec 17 2018]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 227 227 6e72a1529a7b33ae962e5643d747d57d679cf0c7, {Tracking_DKIM, one}, {Tracking_ sender_matches_from}, {Tracking_text_let_digits}, Auth:dkim=pass header.d=piap.pl, DmarcAF: none
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/12/11 14:32:57
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, bases: 2018/12/17 00:28:00 #9249116
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

90ad2cbe88c22d0215225ab9594eeead0eb24fde changed the i.MX I2C bus driver
to use a notifier whenever the base clock ("ipg" - 66 MHz peripheral
clock) rate changes.

Unfortunately one can't use the container_of() macro this way - the
first argument has to point to a member of the bigger struct (last
argument). Merely pointing to the same value isn't enough (the clk
variable which has its address passed to the macro is the clk in
notifier_block, not the one in imx_i2c_struct, even though both pointers
point to the same clk struct).

This bug causes kernel panic when the IPG clock rate changes (e.g. if
any clock derived from IPG changes).

Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -510,9 +510,9 @@ static int i2c_imx_clk_notifier_call(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
 	struct clk_notifier_data *ndata = data;
-	struct imx_i2c_struct *i2c_imx = container_of(&ndata->clk,
+	struct imx_i2c_struct *i2c_imx = container_of(nb,
 						      struct imx_i2c_struct,
-						      clk);
+						      clk_change_nb);
 
 	if (action & POST_RATE_CHANGE)
 		i2c_imx_set_clk(i2c_imx, ndata->new_rate);
