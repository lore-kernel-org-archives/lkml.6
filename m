Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C902151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz9l/5O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C902151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbeKVFnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FC6D206BB;
        Wed, 21 Nov 2018 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827268;
        bh=W1iJbVk3JcOyTPn0BpMy5GxE4vlAWcY6PbcDI8JL9WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nz9l/5O4g/6YXkr/0iWQt3zTLMjsVIDIE81zr1C/tc3Lwkj6NfzQ3eL8kOTWEY9rx
         l0FRl1pj3i9Z9pyBmcdRJbuL/fYrCSd1L852pfjR1MtM5rC53wuAWIvoYgBAOorKWv
         qMsdwAQPCSKtQq1xaz88Zj5AQcx2wB1CAm/xm7DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 36/42] net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs
Date:   Wed, 21 Nov 2018 20:06:12 +0100
Message-Id: <20181121183149.522711819@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit df5a8ec64eed7fe45b556cfff503acd6429ab817 ]

Up until commit 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod
functions where possible"), the _cansleep variants of the gpio_ API was
used. After that commit and the change to gpiod_ API, the _cansleep()
was dropped. This then results in WARN_ON() when used with GPIO
devices which do sleep. Add back the _cansleep() to avoid this.

Fixes: 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod functions where possible")
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-gpio.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/phy/mdio-gpio.c
+++ b/drivers/net/phy/mdio-gpio.c
@@ -63,7 +63,7 @@ static void mdio_dir(struct mdiobb_ctrl
 		 * assume the pin serves as pull-up. If direction is
 		 * output, the default value is high.
 		 */
-		gpiod_set_value(bitbang->mdo, 1);
+		gpiod_set_value_cansleep(bitbang->mdo, 1);
 		return;
 	}
 
@@ -78,7 +78,7 @@ static int mdio_get(struct mdiobb_ctrl *
 	struct mdio_gpio_info *bitbang =
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
-	return gpiod_get_value(bitbang->mdio);
+	return gpiod_get_value_cansleep(bitbang->mdio);
 }
 
 static void mdio_set(struct mdiobb_ctrl *ctrl, int what)
@@ -87,9 +87,9 @@ static void mdio_set(struct mdiobb_ctrl
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
 	if (bitbang->mdo)
-		gpiod_set_value(bitbang->mdo, what);
+		gpiod_set_value_cansleep(bitbang->mdo, what);
 	else
-		gpiod_set_value(bitbang->mdio, what);
+		gpiod_set_value_cansleep(bitbang->mdio, what);
 }
 
 static void mdc_set(struct mdiobb_ctrl *ctrl, int what)
@@ -97,7 +97,7 @@ static void mdc_set(struct mdiobb_ctrl *
 	struct mdio_gpio_info *bitbang =
 		container_of(ctrl, struct mdio_gpio_info, ctrl);
 
-	gpiod_set_value(bitbang->mdc, what);
+	gpiod_set_value_cansleep(bitbang->mdc, what);
 }
 
 static const struct mdiobb_ops mdio_gpio_ops = {


