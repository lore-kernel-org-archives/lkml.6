Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E8A2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc89MxrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E8A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGIOCC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:02:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42557 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGIOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:02:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1-v6so11122104wrs.9;
        Mon, 09 Jul 2018 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8KYWQaFayXwM7iKrytPPIYw0L5a+Vhxxpvnf82eB48=;
        b=Hc89MxrHEFz1FIIPaA7Pq7wtpHwz/5vZmlGLtuEKb2UxaREUzg+QMbCS6arpfDzRcf
         h7bkrAStTXwPwDzujH5hmZYg8BfQ1KQj+aFM8YfP3fG2j0xyRP64SOYPZIibkeqvZp1L
         FlniDVEDNDsdpZLjJCdZwwpUBzf+sO7EC3qcVSZXWG99cisoUhxDNxyCptKM3clCSMLq
         Ip4R3Drf/iwfdKmns9wfRCrsQF1U9cDo9Ueh2scnvurMDo/aGvSBUAbXGmM+fMGka5la
         nYcKY+aWSPomaCD81uWNrfvhTL8oDfbdTA0UYqfc9p26IkPqskpgMMjs0J1t/zk0DgU8
         Qapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8KYWQaFayXwM7iKrytPPIYw0L5a+Vhxxpvnf82eB48=;
        b=DToYqx7NFe7wm81LPkG5BWm01oR6ug6D18DH+A1eKsTBs4fFMZJciNof0jqfcI5a3Z
         ghXnPYtTykHKt2Bgff6tPM4w3frhHdBVH5C7/XOCBbAC4mUegyoNdU8u8XHnbUfG5G+m
         ZXBTxN7aKsG1JEqprL1gdPGsTBb29vembIT6/echzytw3TjRp2lE8y2yIPw+STfwvELb
         xukgQ//FXj60I6cnWiu/ZW022qqrQPII/k/l/Uin29j98MscwwiwMYQODcmbJ9JitkNo
         JdaRMnFt+u75FDXLDJlCR7NpmO80jsx3viD6mHjEY8cYeR7GOQhfAh1Byo9uAJxE0VbP
         RCFQ==
X-Gm-Message-State: APt69E1WsFVhxbmx8oGaWq/HdJBKJWbEfp96TKXJHPv4wNri1Hz3g2dh
        5mwZKuV4N0HPbwyK4nKHE9UwFw==
X-Google-Smtp-Source: AAOMgpfRIwvHXVkFFUxGjqyfRI7GfEbyCRv7iDyfchBE5L7G5pJ2RepNX1LaWrFc2ijVstONTrAy6w==
X-Received: by 2002:adf:c891:: with SMTP id k17-v6mr15970013wrh.6.1531144918284;
        Mon, 09 Jul 2018 07:01:58 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id i190-v6sm22302358wmd.33.2018.07.09.07.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 07:01:57 -0700 (PDT)
Date:   Mon, 9 Jul 2018 16:01:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: tegra: Fix NACK error handling
Message-ID: <20180709140156.GB18353@ulmo>
References: <1530608143-9222-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <1530608143-9222-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 09:55:43AM +0100, Jon Hunter wrote:
> On Tegra30 Cardhu the PCA9546 I2C mux is not ACK'ing I2C commands on
> resume from suspend (which is caused by the reset signal for the I2C
> mux not being configured correctl). However, this NACK is causing the
> Tegra30 to hang on resuming from suspend which is not expected as we
> detect NACKs and handle them. The hang observed appears to occur when
> resetting the I2C controller to recover from the NACK.
>=20
> Commit 77821b4678f9 ("i2c: tegra: proper handling of error cases") added
> additional error handling for some error cases including NACK, however,
> it appears that this change conflicts with an early fix by commit
> f70893d08338 ("i2c: tegra: Add delay before resetting the controller
> after NACK"). After commit 77821b4678f9 was made we now disable 'packet
> mode' before the delay from commit f70893d08338 happens. Testing shows
> that moving the delay to before disabling 'packet mode' fixes the hang
> observed on Tegra30. The delay was added to give the I2C controller
> chance to send a stop condition and so it makes sense to move this to
> before we disable packet mode. Please note that packet mode is always
> enabled for Tegra.
>=20
> Fixes: 77821b4678f9 ("i2c: tegra: proper handling of error cases")
>=20
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Seems sensible:

Acked-by: Thierry Reding <treding@nvidia.com>

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDatQACgkQ3SOs138+
s6Gr6RAAlVI3fpyoaEJqFnqAF1Hu9DAR/AgxeUqnBf8ZMsUTskUdRe+QxFnMot40
Oo6Ck5DBDFeZ0W/NeRTu63e+I/w+WjTMMiANfxwGgc1e0m6ih0lorLsf/FUsOMvG
NUyHy/RBIy1pKPs76vrJsxz/We29yiZqAGFeQsWLcN/XS+5CzvXSX0xwzYn43Bfr
5g9lulphxCfRAc3oLv4+Ehy/a0AJPCQxIyjFggvp2iwI+gWGURsrVij4UKweSKsk
fxWcrLWhKlqUToyM4i/XdOXa87wqGMYXefhtsLiYqSIdHOZbuCbmGhoRonlyI4Ls
1E8pDyS4zfRTiGTLcbo1C+t7aKw2+S3PrprOi0xRvhGAOceeddcJpL8JxUY0pFf8
9F88dZF1FKO6UZSU30h6MZuMAqgkT6Po6QFVQa24l9HJqrL1WUZkNEfXpOiX1aKD
6Bd+SF39tFAxkChmJl3hT1XEOXAo0PuTdGZmR8KtlF1DunXpIySmN6cpb3+C8cO4
pERVhCA0wv4MqFG19MdjbTh8MvEi60kqohfSie0U3IhBOwzTgyzMhV2/BpgzT2gw
wDnIUakuOmygH13T1ymLlWUUC70AxmpMj0BWo7FYp98sY6zaCgXnBVJubpuSduya
k5pzHmae69GhjrsaHWQJUIGn7vgMstCJ17NF2BWD661LFHicYxA=
=VXDy
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
