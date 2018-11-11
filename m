Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0ECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFF820872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yWymgsET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFF820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbeKLIwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389296AbeKLIW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:27 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 530572241E;
        Sun, 11 Nov 2018 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975550;
        bh=zjIrBj/BbzjJ/+SFVar90zpyb7dm8PUPNNh6w2qA5rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yWymgsETXV7nhE6cSKgXcvXYyVcSExh5MPFlvQPolO3/Sdn133Ppv4wtnyDhD6KUV
         uSfUmAzz3k2xQEL0wKA20yVvqzU/HOW7Qyqu2/860elkUlCjpK+GzMob95x9k1iMR/
         lBrOhIbV2Su92RD4/WQf1PtauHtb9d+3vjuXJfWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 090/222] usb: gadget: udc: atmel: handle at91sam9rl PMC
Date:   Sun, 11 Nov 2018 14:23:07 -0800
Message-Id: <20181111221656.027857729@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit bb80e4fa57eb75ebd64ae9be4155da6d12c1a997 ]

The at91sam9rl PMC is not quite the same as the at91sam9g45 one and now has
its own compatible string. Add support for that.

Fixes: 217bace8e548 ("ARM: dts: fix PMC compatible")
Acked-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2072,6 +2072,8 @@ static struct usba_ep * atmel_udc_of_ini
 	udc->errata = match->data;
 	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
 	if (IS_ERR(udc->pmc))
+		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9rl-pmc");
+	if (IS_ERR(udc->pmc))
 		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9x5-pmc");
 	if (udc->errata && IS_ERR(udc->pmc))
 		return ERR_CAST(udc->pmc);


