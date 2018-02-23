Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415658-2-6412049049809253743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415658; b=S8cwKsMAuQqX/yDM8zoyL/zAxqa6n5hlMsp8GHhdKEJmlRf
    yRxk+93TzTmAEr/5B5DxfPwBABUXtjYYEBc/v+q9i3GdZ61jWfuGde8nP1OlN8J8
    bhx+tsxUWWS9PNaSxp6KHa/R6n9+7baNB5X5TVY8WR9Py8gWZLREF6Lw7aU9POU7
    rMof+9GfoetZIxkZGe4kVC9S0CFcDQOLBbDRODgP4zU7sxH6eTd3Ir9OfO52c/Cm
    ia67YRlY/5upygsMOfqsHYjqyS5i0T62t1HyO9ot6q1/b7fpQdbNEdp2DXh6Zj+L
    TGXzjygZpBzANUC3zRXc9ualrDN0TulhJeQqlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415658; bh=81//qKzh2bv1IjVOJupSF/LS5Q
    dIAiqV0FP6kux6bGA=; b=tINqe0r+dLS28L0ImtW95eH9nXbt9J2djusyngyyZI
    UvUUozAul8/xUvuxu1bztS73XwueoP4+Dd8JzovGvH4oHjfWw44SAEfW+l9UIxuW
    7N3+s269o+mGCYHRB0+P578Yx7lJEZlMxOtyNeTo/CTj0P/wLaeqGj2iudw2lCi4
    lADwsMDNBoqd4DUZR++ndW7zpcchUUdv1B9tinWLwhS9KI9ifPV8DexAsxN+HC6V
    dkF4UNMuHb5cRPQIqoffU2wkcvR3CZ5AthTTuNVBKghsbSyazI1jsbRfX08L3qSQ
    x1r/RBm5br5II3+51r3Z7oqZv8nf6JASxToE9NeHSZXw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933760AbeBWSpS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933755AbeBWSpQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Branislav Radocaj <branislav@radocaj.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 069/145] net: ethernet: arc: fix error handling in emac_rockchip_probe
Date: Fri, 23 Feb 2018 19:26:15 +0100
Message-Id: <20180223170733.558199456@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Branislav Radocaj <branislav@radocaj.org>


[ Upstream commit e46772a6946a7d1f3fbbc1415871851d6651f1d4 ]

If clk_set_rate() fails, we should disable clk before return.
Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Branislav Radocaj <branislav@radocaj.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/arc/emac_rockchip.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -220,9 +220,11 @@ static int emac_rockchip_probe(struct pl
 
 		/* RMII TX/RX needs always a rate of 25MHz */
 		err = clk_set_rate(priv->macclk, 25000000);
-		if (err)
+		if (err) {
 			dev_err(dev,
 				"failed to change mac clock rate (%d)\n", err);
+			goto out_clk_disable_macclk;
+		}
 	}
 
 	err = arc_emac_probe(ndev, interface);
@@ -232,7 +234,8 @@ static int emac_rockchip_probe(struct pl
 	}
 
 	return 0;
-
+out_clk_disable_macclk:
+	clk_disable_unprepare(priv->macclk);
 out_regulator_disable:
 	if (priv->regulator)
 		regulator_disable(priv->regulator);
