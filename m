Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A54C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB5520862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wX8Or54L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB5520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeICRX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:23:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40346 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeICRX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NT8TYYdh6JeDkahOXKzjsBWfJ3H1xycYZNxCJR8YBd4=; b=wX8Or54Lt4SD5W8Q4XgnA925h
        LUyHzjsIjvhUKJSY/4NlnIOU/GJOPsbRQ0Ii7zHIHMdRIdhxWbTLjN4Pw3S5sAjlN1oSNiPdBIvZt
        FDZBtd7Jhl2eC76UkvlgIqVxVyYEzz3Z8BTBZKrwmLqXEMO8umpAsAAWGV9gXaZ8l3b8g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwoVj-0000Ej-8D; Mon, 03 Sep 2018 13:03:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B9DE111227AE; Mon,  3 Sep 2018 14:03:18 +0100 (BST)
Date:   Mon, 3 Sep 2018 14:03:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: tlv320aic31xx: Add overflow detection support
Message-ID: <20180903130318.GH10302@sirena.org.uk>
References: <20180831182434.14499-1-afd@ti.com>
 <20180831182434.14499-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <20180831182434.14499-2-afd@ti.com>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:24:32PM -0500, Andrew F. Davis wrote:
> Similar to short circuit detection, when the ADC/DAC is saturated and
> overflows poor audio quality can result and should be reported to the
> user. This device support Automatic Dynamic Range Compression (DRC)
> to reduce this but it is not enabled currently in this driver.

> +	if (value & AIC31XX_DAC_OF_LEFT)
> +		dev_err(dev, "Left-channel DAC overflow has occurred\n");
> +	if (value & AIC31XX_DAC_OF_RIGHT)
> +		dev_err(dev, "Right-channel DAC overflow has occurred\n");

So, this will sound terrible but I'm not sure that unconditionally
shouting in the logs is the right thing to do here - people do sometimes
put non-audio signals through sound cards (using them as generic DACs
and ADCs) and it seems like it could get very spammy.  Perhaps a lower
level warning message, some counters or even some control that allows
the warnings to be masked.

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNMRUACgkQJNaLcl1U
h9Cw3Af+LKV8HPNfxx3p6lOfB6mV5JYNxNsRu3kFxuD5QTioPyOX43gCZCU1WCel
5gg3+uX6ckeV+AuWgVYltO/xACZraf7EfgO1rE0n0rrvCpOJVjeNPalQ2H0xbFcQ
XICnzRCpMQsfLEfULjIg7viL+TFKrRmWFh8h8L5UWYNJvoKt2wERYske8b38MDzy
BL+LDxzxQlR+tt4Gq6oqytajCW2H9m3MdVZWr3KiWMe0xcE0d3q68XH3AGUGanay
iN6kEksVClMWf7R6pwdBRlfCqy6lqzs3v/lYcnCvJhATEkbZZlcs3mU9fLYaL14j
Hp4laiTMRn8gv8eLVWKjLjd6+ytBlQ==
=LiVE
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
