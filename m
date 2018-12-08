Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE2C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCC620673
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="nVgJg2Kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCC620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLHR7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:59:21 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49830 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeLHR7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:59:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 118311F988;
        Sat,  8 Dec 2018 18:59:17 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1544291956; x=
        1546883957; bh=R8xWR7f+sW0ZrLT6YNezpsRyeE8HEJPYVU0CAe3BpuE=; b=n
        VgJg2KlnCPk+fH1YJzi0hdePHxKVreQI1ES1ev33FwFBWLgi8JEjzw8Is0O3nrhy
        kJXvdUh9RsFQ1SSuajXYius2vF78acamuzGPzChmnZ61W45I6yUPPloXwaU3Gjvr
        nc3KWGGMOc6GQC9wbI3mXnlqIMOuy2v4NkiCgGl5NWrGPDfM760U6sp3uX1Wq3Ss
        Q6nli0TkO7tFEMmFgWVs5P5YEF8sGQxN3RWb6R1XD/SrLapdiexOsix6w3NCelQm
        rLV5a6XDXYvPh59k+kLyjcILncFclCMhVCtagf0waDhgMWIvgw2RMsQEoCxQ7Ey/
        Nvjj7DSDz2jfi5HV8/FGU9mevl96+XbI80pEvtqlbfQjC4woXLtV6iv4gd/KYbzQ
        7Qj+IqB6po8qnn2OXVHgNZsrNokfoRNGERg/lcorp5QP6YYkfEatOheZSzeH7SKa
        iq7+CSParWaZyzy4JjI0AeugInAKXlgUTa72yDfR8xLpIEefVlHDIDCp9zeXIw8e
        yJ4NJbpKbwJnumjw5SoZoCMOuBG7wohpn51q4GbDCviUSDkkA7Lwj6xugNmoMX17
        bROh2mUqTtJjsRLMZXICvkD/5WmmvRcKlhRL7iUyeUZ3WNZGhAGQ4fXRWIg+yQJ7
        CAOyGKOxWcX2YE5ae4+JUxbOKaAcgWTH47ea6mRvdE=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id a-PxGNTagWRr; Sat,  8 Dec 2018 18:59:16 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id DBF7C1F965;
        Sat,  8 Dec 2018 18:59:15 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org, Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v8 1/2] mfd: axp20x: Re-align mfd cell entries
Date:   Sat,  8 Dec 2018 19:58:46 +0200
Message-Id: <20181208175847.32068-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208175847.32068-1-oskari@lemmela.net>
References: <20181208175847.32068-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

In the axp20x driver, the various mfd_cell lists had varying amounts
of indentation, sometimes even within the same list. For the axp288,
there's no alignment at all.

Re-align the right hand side of the assignments with the least amount
of tabs possible. Also collapse the closing bracket and the opening
bracket of the next entry onto the same line for the axp288, to be
consistent with all the other mfd_cell lists.

This patch is whitespace change only. No functionality is modified.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/mfd/axp20x.c | 107 +++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dfc3cff1d08b..8037b4e01ed6 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -640,9 +640,9 @@ static const struct mfd_cell axp221_cells[] = {
 
 static const struct mfd_cell axp223_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
-		.resources		= axp22x_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
+		.resources	= axp22x_pek_resources,
 	}, {
 		.name		= "axp22x-adc",
 		.of_compatible	= "x-powers,axp221-adc",
@@ -650,7 +650,7 @@ static const struct mfd_cell axp223_cells[] = {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp221-battery-power-supply",
 	}, {
-		.name			= "axp20x-regulator",
+		.name		= "axp20x-regulator",
 	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp221-ac-power-supply",
@@ -666,9 +666,9 @@ static const struct mfd_cell axp223_cells[] = {
 
 static const struct mfd_cell axp152_cells[] = {
 	{
-		.name			= "axp20x-pek",
-		.num_resources		= ARRAY_SIZE(axp152_pek_resources),
-		.resources		= axp152_pek_resources,
+		.name		= "axp20x-pek",
+		.num_resources	= ARRAY_SIZE(axp152_pek_resources),
+		.resources	= axp152_pek_resources,
 	},
 };
 
@@ -697,84 +697,79 @@ static const struct resource axp288_charger_resources[] = {
 
 static const struct mfd_cell axp288_cells[] = {
 	{
-		.name = "axp288_adc",
-		.num_resources = ARRAY_SIZE(axp288_adc_resources),
-		.resources = axp288_adc_resources,
-	},
-	{
-		.name = "axp288_extcon",
-		.num_resources = ARRAY_SIZE(axp288_extcon_resources),
-		.resources = axp288_extcon_resources,
-	},
-	{
-		.name = "axp288_charger",
-		.num_resources = ARRAY_SIZE(axp288_charger_resources),
-		.resources = axp288_charger_resources,
-	},
-	{
-		.name = "axp288_fuel_gauge",
-		.num_resources = ARRAY_SIZE(axp288_fuel_gauge_resources),
-		.resources = axp288_fuel_gauge_resources,
-	},
-	{
-		.name = "axp221-pek",
-		.num_resources = ARRAY_SIZE(axp288_power_button_resources),
-		.resources = axp288_power_button_resources,
-	},
-	{
-		.name = "axp288_pmic_acpi",
+		.name		= "axp288_adc",
+		.num_resources	= ARRAY_SIZE(axp288_adc_resources),
+		.resources	= axp288_adc_resources,
+	}, {
+		.name		= "axp288_extcon",
+		.num_resources	= ARRAY_SIZE(axp288_extcon_resources),
+		.resources	= axp288_extcon_resources,
+	}, {
+		.name		= "axp288_charger",
+		.num_resources	= ARRAY_SIZE(axp288_charger_resources),
+		.resources	= axp288_charger_resources,
+	}, {
+		.name		= "axp288_fuel_gauge",
+		.num_resources	= ARRAY_SIZE(axp288_fuel_gauge_resources),
+		.resources	= axp288_fuel_gauge_resources,
+	}, {
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp288_power_button_resources),
+		.resources	= axp288_power_button_resources,
+	}, {
+		.name		= "axp288_pmic_acpi",
 	},
 };
 
 static const struct mfd_cell axp803_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
-		.resources		= axp803_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
+		.resources	= axp803_pek_resources,
 	},
-	{	.name			= "axp20x-regulator" },
+	{	.name		= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp806_pek_resources),
-		.resources		= axp806_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp806_pek_resources),
+		.resources	= axp806_pek_resources,
 	},
-	{	.name			= "axp20x-regulator" },
+	{	.name		= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_cells[] = {
 	{
-		.id			= 2,
-		.name			= "axp20x-regulator",
+		.id		= 2,
+		.name		= "axp20x-regulator",
 	},
 };
 
 static const struct mfd_cell axp809_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
-		.resources		= axp809_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp809_pek_resources),
+		.resources	= axp809_pek_resources,
 	}, {
-		.id			= 1,
-		.name			= "axp20x-regulator",
+		.id		= 1,
+		.name		= "axp20x-regulator",
 	},
 };
 
 static const struct mfd_cell axp813_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
-		.resources		= axp803_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
+		.resources	= axp803_pek_resources,
 	}, {
-		.name			= "axp20x-regulator",
+		.name		= "axp20x-regulator",
 	}, {
-		.name			= "axp20x-gpio",
-		.of_compatible		= "x-powers,axp813-gpio",
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp813-gpio",
 	}, {
-		.name			= "axp813-adc",
-		.of_compatible		= "x-powers,axp813-adc",
+		.name		= "axp813-adc",
+		.of_compatible	= "x-powers,axp813-adc",
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
-- 
2.17.1

