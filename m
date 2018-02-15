Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720721-2-10086650210081569936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720720; b=rF3CtN2gF31dipr6rP9TjvybB2GagaF90gGQqvUGVVfzIWw
    1y0cE+WQPBTd7SYcqvDtJ32R+dVJhnvFM8x72Tacs7qYnZC1IuaCPS/4DXkHkGqN
    wufQDByla0RSTm17X479KOrYYGsvbEpkZC+tunApq0Wxxl1LM+oSM+BqL8uqcpmx
    lTLjpaKs8XQHkIbUZKf6Bw1CSh0y2HLCH0yBB9FmSWK0zYGK9q6tgWkAIFkvYzme
    5Rg0SOF0MGjIzsn49Sli0U6QFCXSFtMelrrJ5hPTRQsrrxewcpXXWS11iIEJCJWp
    /Dmo4E8EfdciWehhgsDLvbl9KLvlEJ4CqWITHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720720; bh=PC8ZwPls5yrQr/p/cLzQSJwH13
    R9z1hl73aeTMMLhdk=; b=ezJqhqbQDWwvhL8hcsPi+lToLkruH/0Iqss4hqY4Wc
    /7icDEfzL5vSI54VjOKD9Hyhc+OVZjCfCBj8Ln7cfUdprZehuSEuDvXP4yKemCIZ
    M++0dcIjKUMj0P7kEWA1/kPGUyI0iECS91o8cpG887yaHPfF3HNfs+FJ25VQcEoL
    YevI1EermJffpJ93HmZPYdELDan/cuIsHmu4jOU58/NKSDl3yt2zndo003/Ga5tX
    YkEn01rIAfSpgwkDyLgY8e70RcstRVHLhvzM+dxW1a3FQ7+/dIs2OsMQ6381Wdwe
    S515/9UHsM+XD5keVWUifOzp9cP+LxX2fQs2M2ESPK2A==
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
        id S1162064AbeBOSvo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:51:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162039AbeBOPVX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.4 023/108] ASoC: rsnd: avoid duplicate free_irq()
Date: Thu, 15 Feb 2018 16:16:20 +0100
Message-Id: <20180215151225.812905378@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit e0936c3471a8411a5df327641fa3ffe12a2fb07b upstream.

commit 1f8754d4daea5f ("ASoC: rsnd: don't call free_irq() on
Parent SSI") fixed Parent SSI duplicate free_irq().
But on Renesas Sound, not only Parent SSI but also Multi SSI
have same issue.
This patch avoid duplicate free_irq() if it was not pure SSI.

Fixes: 1f8754d4daea5f ("ASoC: rsnd: don't call free_irq() on Parent SSI")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: thongsyho <thong.ho.px@rvc.renesas.com>
Signed-off-by: Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/ssi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -550,14 +550,14 @@ static int rsnd_ssi_dma_remove(struct rs
 			       struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
+	struct rsnd_mod *pure_ssi_mod = rsnd_io_to_mod_ssi(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	int irq = ssi->info->irq;
 
 	rsnd_dma_quit(io, rsnd_mod_to_dma(mod));
 
-	/* Do nothing for SSI parent mod */
-	if (ssi_parent_mod == mod)
+	/* Do nothing if non SSI (= SSI parent, multi SSI) mod */
+	if (pure_ssi_mod != mod)
 		return 0;
 
 	/* PIO will request IRQ again */
