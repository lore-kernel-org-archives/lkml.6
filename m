Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184686-2-12356728385158678479
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
    t=1518184686; b=fRAQ9elzyOj8ZS2TJ5M//yVF9V6MCTL6TuXK6ktZVRbqxL3
    +0T9cVJZD8lf2vfgE/8guC38o7830loOfz8dQnH+psGUclt6l6nx62WzbHbysJJK
    YsTiQvgXRM/MWL13oP1CzYXJOkqHKobsd7H+Q3ogX+FO/NEK7Gd++I+mceIBzg1U
    TEVC+tSas4j77/x7GWacxWV+0QG/BaUKZcjsfZ2qFX03J3i7TfXLcfpyveXG8uPZ
    Wc9CxkzbOKuIpgxlWq6C36tPTEWMjRArmukO2nWM+lJ1JoDA182S03trvKBD/SUC
    3yrJiSCe2aTysaP6LpDL8DaRtCyyDQTGYsvQNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184686; bh=tFCE5IcAjYfqyJ44n0QP9yDftz
    7Pcc6sP2+X+sA0C/4=; b=n94G5cuYd7kQhYFyyDFZhorIfAkzdIjC4y5vzX1T4c
    pLaKoNxeE9Dqffn776D6jYvjnUjLErl26keDT5cQVqeKssjPI/oo1gz6dNdYjSRT
    XSi4CPQ4uHl0NtB2lyvTcK7pt3ePjeCAhGTPIWr78oG2Hg64DSe3GJaqpy1OtHBk
    jhqZOPFEptUACtS5NuK7pGeQQi8c4RZu8cc225XWEuUrXmLyC3gi3+uUFcagLBJM
    dqXN5FhvUr5JWinfOskYGAQTf+9AX11dXkbeBP2N29SbudVmdKcaB/O2J2d15auk
    ihLPikwzEIize3WDr1APh2ioQrclspL7Szs9W9T9BHeA==
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
        id S1752649AbeBINoq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINop (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.9 89/92] ASoC: rsnd: avoid duplicate free_irq()
Date: Fri,  9 Feb 2018 14:39:58 +0100
Message-Id: <20180209133937.472738403@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -699,12 +699,12 @@ static int rsnd_ssi_dma_remove(struct rs
 			       struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
+	struct rsnd_mod *pure_ssi_mod = rsnd_io_to_mod_ssi(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	int irq = ssi->irq;
 
-	/* Do nothing for SSI parent mod */
-	if (ssi_parent_mod == mod)
+	/* Do nothing if non SSI (= SSI parent, multi SSI) mod */
+	if (pure_ssi_mod != mod)
 		return 0;
 
 	/* PIO will request IRQ again */
