Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0201BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B627920821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gg/Hcy5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B627920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeKAAHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:07:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39505 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbeKAAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:07:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id n18so3575606lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e5frE0WJ4d8tX8keWMYH6dLS7V4PumD0YzkgOc87U20=;
        b=Gg/Hcy5+noTBg1aPXPBql0TGm7aVmka1GfD/Vo1kGojY3HYsyfUiMfv+eIu9vjJktQ
         Ir2zVFwFOpaV0lnm5scoV1NYnHpmMZRJxL2HyHxYIN8tDXxS/R3YDz0HRijxZfNMyeto
         fEb7F4H9J3SApKheQiC1irCxjobJGVbzQ8E9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e5frE0WJ4d8tX8keWMYH6dLS7V4PumD0YzkgOc87U20=;
        b=bW5cnA8U5bL6u/qw5CZFqZ8AmY9NjpUwDBT1HRb1qp+3RKJD3X500smSYBbZMJmdNM
         iWjK2H64r1jj4YjsBikiLcybhyb3c3ybykVVJk3+L+bkIBXJ5LVxARXQc2IMdw0ly5fD
         fzpM8EJjU2/+cEUppGeBa020JjovMJ928rrxkIWnzNxgauzw9rbg3nHXlYonDhwzI0OV
         d8g4iT4hhz/NtjEghL10XGi4n0lZ8GlZOI9hCVwJ68+jIFJdldiXaSJCovp5tEjbdt0K
         0grTqcS76ypR5XcrE+qxoO/zdy6sJ7Q8dTJGTDOgE7igx9dKgeern8wC3Czgxz+gnUtK
         /m/A==
X-Gm-Message-State: AGRZ1gJAK6IB6FnTGav1rDGnJb/1hmIEJB3V7Qb+XPFsfUk9mTAvVNCd
        RYr55StLTHlkSAWgZ4KTPUKv/w==
X-Google-Smtp-Source: AJdET5e2aEfuu9h9V0EqP2gHQwPP1MHSXWGVK52IntXUL/smNjv821MneACQUglaQOKsX9n/RypJCg==
X-Received: by 2002:a19:d145:: with SMTP id i66mr2158515lfg.97.1540998515293;
        Wed, 31 Oct 2018 08:08:35 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id o72sm4281690lfg.33.2018.10.31.08.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:08:34 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     vkoul@kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules
Date:   Wed, 31 Oct 2018 16:08:10 +0100
Message-Id: <20181031150810.16665-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building stmmac, it is only possible to select CONFIG_DWMAC_GENERIC,
or any of the glue drivers, when CONFIG_STMMAC_PLATFORM is set.
The only exception is CONFIG_STMMAC_PCI.

When calling of_mdiobus_register(), it will call our ->reset()
callback, which is set to stmmac_mdio_reset().

Most of the code in stmmac_mdio_reset() is protected by a
"#if defined(CONFIG_STMMAC_PLATFORM)", which will evaluate
to false when CONFIG_STMMAC_PLATFORM=m.

Because of this, the phy reset gpio will only be pulled when
stmmac is built as built-in, but not when built as modules.

Fix this by using "#if IS_ENABLED()" instead of "#if defined()".

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index b72ef171477e..bdd351597b55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -243,7 +243,7 @@ static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
  */
 int stmmac_mdio_reset(struct mii_bus *bus)
 {
-#if defined(CONFIG_STMMAC_PLATFORM)
+#if IS_ENABLED(CONFIG_STMMAC_PLATFORM)
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	unsigned int mii_address = priv->hw->mii.addr;
-- 
2.17.2

