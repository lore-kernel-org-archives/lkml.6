Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413482-2-12225954619742076544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413481; b=HJXphd1x/1uu3hFDT0F/HiNK+cQjgtaCjMpHyamriuFvEaz
    +d1yZK/ohjJU95jPrTFli5k0wSkATuWTLfLjRC3PSYxSFDXznqcpKAcbmh46+c1x
    xUWcfg9pKsPFqmAcN6GBGJx9WmNhnwRfBXKcRdeYD/e0q9YFW2n9pOFMq4v48R9+
    IDYLQhMYfGW/neHdoVtAD4LWlr2V1My3WDo+ur9k6xevVYool9x5U6B8Ve2xxrmp
    1DKUZXh5risgzVqyJdelOvV9Qfy6CK1sc3rmhPrAriKKUZKf6VFD+NlxSvarTODH
    GbQoATd4K4Edv5UPKZbr1z72hcxeoZcHEFyyWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413481; bh=1adxxiZ2NUJ/r+KJMMc/eIBlCy
    hOT17GD7j/Cz7lGc4=; b=Nu0cgYW1MspP31rN9n2231WtmFGx6K4kqPYolo9kkv
    J7b+9lBcZz/SWa8JQ039xP9pIwAVo+582tUeViufkGMlHYmM5Ra4IJ9BFmpp9qk6
    k24hKVMuPYoEgOwKtrPEHs8Dxi9Hj1TTobIJztcNgZc9MOr5AMQ28uYRbmhFmzew
    n5IHI9vqixklyereAuPVHSWe2Oo8wBU++JLxldcnLFq/WtrghNy13ITGNeickbAr
    elEeCBX9TDn6yV2u7n434iwJQUV/51dxYTy39R2umEjCLkLyP37v5o7sgavEv8Ru
    dPoSjI6PlEvi5BwCIiN/26H9cy0R572xQEu3kqeEa27A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965020AbeBWSyw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965013AbeBWSyv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Branislav Radocaj <branislav@radocaj.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 123/159] net: ethernet: arc: fix error handling in emac_rockchip_probe
Date: Fri, 23 Feb 2018 19:27:11 +0100
Message-Id: <20180223170758.114603707@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Branislav Radocaj <branislav@radocaj.org>


[ Upstream commit e46772a6946a7d1f3fbbc1415871851d6651f1d4 ]

If clk_set_rate() fails, we should disable clk before return.
Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Branislav Radocaj <branislav@radocaj.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
