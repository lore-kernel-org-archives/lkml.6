Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184702-2-1339074863749425883
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
    t=1518184702; b=rDOa3cCwVSJ3MEBiis7p3NgyaVfRWWKiuLPuW8oxD8RorjK
    wAeZGXCyL7IWk/ZZM6ODrT0iIP+dnPan/8eQWrhIgx0DdT3L8bjhncL0aRue/izc
    2UepNwITKPpk9fRgpfgi7aTT2v+gZjaDJu773nJXOcck8spZTx9jqMpgU+K4spA1
    br9kU+K78+ZCjEEXJYKdXCDTmDIpvvqJMF+M/Jz1yV+u+aFeKNkgDAPiETj8njd3
    93OhH2/pYO0r2aMHKdUVrAeH30SdXj1NVpPS6hEPSRIbqhJP4fjnzDUImCS8NXFZ
    GMnqacycClr/f5yMox3zGf57gkVXNjqeNkBCezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184702; bh=8dv78VmjRxHTa7oqCmwBdlSv1e
    6fv8RbxEcylZR2F6U=; b=Xf433cLlB6p/uVfzXmlQvlzYnNJWuaZa5jJ6PE/d+m
    ap6QD7lV5aexVjhKHOO1P6vVZ+Zwn4Q7x0mXHLdPctg4ocKtZhFpjtge5Q5Zbem9
    EPG7/UE6mPo36Hku22U+y5gVphLaQaYlin4DEHMaER3BEW5oqjsCYC+pSSrj4gSX
    AMLIjuu04X7ZwnZY77PnOmrbJLvkZYOXabNqjL3My50gBE2ydIQN1DyFRhXicmB1
    MCsuutZG2ROqtQ9B9CPanreKJ0OKOKNmaPq4xvpUkltPXNaJOvs4SEP/viOkhmcM
    Bowy3xtF1DxFRit5Apy+zV279O37uysv9ygs2cBTbXQw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeBIN6G (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:58:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbeBINom (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.9 88/92] ASoC: rsnd: dont call free_irq() on Parent SSI
Date: Fri,  9 Feb 2018 14:39:57 +0100
Message-Id: <20180209133937.429631758@linuxfoundation.org>
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

commit 1f8754d4daea5f257370a52a30fcb22798c54516 upstream.

If SSI uses shared pin, some SSI will be used as parent SSI.
Then, normal SSI's remove and Parent SSI's remove
(these are same SSI) will be called when unbind or remove timing.
In this case, free_irq() will be called twice.
This patch solve this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: thongsyho <thong.ho.px@rvc.renesas.com>
Signed-off-by: Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/ssi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -699,9 +699,14 @@ static int rsnd_ssi_dma_remove(struct rs
 			       struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	int irq = ssi->irq;
 
+	/* Do nothing for SSI parent mod */
+	if (ssi_parent_mod == mod)
+		return 0;
+
 	/* PIO will request IRQ again */
 	devm_free_irq(dev, irq, mod);
 
