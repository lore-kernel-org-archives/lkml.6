Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C559021104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+MbMBpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C559021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeK2RC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeK2RC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:58 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3AC21019;
        Thu, 29 Nov 2018 05:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471128;
        bh=fFKpfbevERKuJ0HR+RidacUbSRP0hhr6IonocRrMfqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+MbMBpj9TwF1U4X53S4doytDonPnM1F0SeIby+UuGD8Ktcx5qY7hIbipRybUuyK+
         GSqM0FVKmW4+9j81OnQNX9k7qvMKPL+l5SUVUMxvpehP/4F7tonvX8bk690V49I2PW
         mMl3jn0nY36vNpOp+aAzcyWuS8PV1tqDozfWXIYo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 33/68] gpio: pxa: fix legacy non pinctrl aware builds again
Date:   Thu, 29 Nov 2018 00:55:24 -0500
Message-Id: <20181129055559.159228-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit 70cdb6ad6dc342d9643a00c9092e88f0075f2b9a ]

As pointed out by Gregor, spitz keyboard matrix is broken, with or
without CONFIG_PINCTRL set, quoting :
"The gpio matrix keypard on the Zaurus C3x00 (see spitz.c) does not work
properly. Noticeable are that rshift+c does nothing where as lshift+c
creates C.  Opposite it is for rshift+a vs lshift+a, here only rshift
works. This affects a few other combinations using the rshift or lshift
buttons."

As a matter of fact, as for platform_data based builds CONFIG_PINCTRL=n
is required for now (as opposed for devicetree builds where it should be
set), this means gpio driver should change the direction, which is what
was attempted by commit c4e5ffb6f224 ("gpio: pxa: fix legacy non pinctrl
aware builds").

Unfortunately, the input case was inverted, and the direction change was
never done. This wasn't seen up until now because the initial platform
setup (MFP) was setting this direction. Yet in Gregory's case, the
matrix-keypad driver changes back and forth the direction dynamically,
and this is why he's the first to report it.

Fixes: c4e5ffb6f224 ("gpio: pxa: fix legacy non pinctrl aware builds")
Tested-by: Greg <greguu@null.net>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index c18712dabf93..9f3f166f1760 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -268,8 +268,8 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	if (pxa_gpio_has_pinctrl()) {
 		ret = pinctrl_gpio_direction_input(chip->base + offset);
-		if (!ret)
-			return 0;
+		if (ret)
+			return ret;
 	}
 
 	spin_lock_irqsave(&gpio_lock, flags);
-- 
2.17.1

