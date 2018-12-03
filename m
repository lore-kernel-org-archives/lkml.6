Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01512C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3D8206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="EuDeMG2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3D8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeLCLTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:19:41 -0500
Received: from ni.piap.pl ([195.187.100.4]:44770 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbeLCLTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:19:41 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 06:19:40 EST
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id C2D67442FCC;
        Mon,  3 Dec 2018 12:13:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl C2D67442FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1543835587; bh=IxYOqRjOdwBEKdMZu0fM2Rd2VvA8LkpT0CISSCkxdmI=;
        h=From:To:Subject:Date:From;
        b=EuDeMG2qjaWF+0SDYnr0n2MKW+wnCFkhx3S++hmTAjjtiRPbTtZgJFoDToNlE/KSs
         dRgciWPjoHRU3hSHqQlcuzg5Mryt2Gq9UNhJuFYgp6DsybgZTZhYl9g09aq79bNTBa
         IIiRfnhbj3M/Rf9N4alsX2hRYUvh+k/WQzF29zgU=
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
Date:   Mon, 03 Dec 2018 12:13:06 +0100
Message-ID: <m3o9a2hni5.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 132418 [Dec 03 2018]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 214 214 dd5d82bb00ca93bd3dfb46ca097df6af04819311, {Tracking_DKIM, one}, {Tracking_ sender_matches_from}, Auth:dkim=pass header.d=piap.pl, DmarcAF: none
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/11/29 11:35:34
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, bases: 2018/12/03 03:56:00 #9342701
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
