Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243EBC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD132146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543718;
	bh=J0xN7xqJMiGQH8sTWFHBfS/NLWRb52eMQK4sEHX66ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c19Dcjn/02FEZnQ9uRalIHDIl5fSx40A2gqmiDiqXCjdTstEU64ZDG4/32kKq+GI6
	 pA0p8WNLtsWHsQBa55/o+bNnoLT+/EdyiAckBHx/hhz5AWB+wHYyrzGV6FexV5SMp8
	 ctVsepnGzJ46IeSsSlFfjfjbGPBlJ0NtB1JOIflg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD132146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeLKPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbeLKPzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2949E20855;
        Tue, 11 Dec 2018 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543711;
        bh=J0xN7xqJMiGQH8sTWFHBfS/NLWRb52eMQK4sEHX66ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyRK90Q3AbcJfuPXt29pAlMlRv+71HhxJHFwXQbFyTjksLLn0n1oMq3N5+cys44hE
         Kr9l8lCWBUEYzs0n/M5JCL6dgBnueJa7GAaTfL4EBlPhhay40ZcSwZ0bCj7Cr4Yna+
         Jw/M51ug66dCgzXxAh57LHf8kle88DTZr4rcM7pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg <greguu@null.net>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/118] gpio: pxa: fix legacy non pinctrl aware builds again
Date:   Tue, 11 Dec 2018 16:40:52 +0100
Message-Id: <20181211151645.576897156@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



