Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11580C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ED62084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ED62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeLKXlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:41:07 -0500
Received: from sauhun.de ([88.99.104.3]:46928 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLKXlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:41:06 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id A950F4C0E8F;
        Wed, 12 Dec 2018 00:41:03 +0100 (CET)
Date:   Wed, 12 Dec 2018 00:41:03 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Message-ID: <20181211234102.GA6701@kunai>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

thanks for testing this series!

> Note that the i2c-sprd driver changes in your patchset also get close
> to triggering this problem, but they dodge the bullet because there
> are separate system-wide and runtime suspend handlers and only the
> system-wide handlers call the new i2c_mark_adapter_suspended() function.

Yes, this what I assumed to be all around - seperate handlers for RPM
and PM. And I also assumed that they could be seperated if they aren't
already. Until I read...

> As I explain in the commit message of the first attached patch
> simply always using split handlers is not really an option because
> of adapter drivers using DPM_FLAG_SMART_PREPARE or
> DPM_FLAG_SMART_SUSPEND.

... this. I don't know what these flags do (and reading SMART in there
gives me more a 'uh-oh' feeling) but if the handlers can't be split, the
issues you were seeing are a consequence, yes.

For me, this sadly spoils the whole concept. The patches you add make
things even more complicated. Not happy about that.

Looking at the open coded version you did for the designware driver, I
wonder now if it is better to just leave it at driver level? Need to
sleep over it, though.

Thanks again,

   Wolfram


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQSwoACgkQFA3kzBSg
KbZaWhAAqL4UJf4q20FrE3tk+nfMGtcTU2zNWCwJpJFXNnbUYjRE77mFF6PuBym/
CUMjKU6iKIF30DpsJFPgf1/fPnNQJy2+qM4X7oSjZfLE31sp7WMtx4juxX3GV0+E
+hVGNP4qkwytLwEz+bo4kAkBoRIszttFRKcE5Zur706OwlSh/DzVWYAgiKsA65aW
jueC7gS9FB3/4X9LfZAiKWi88NVa2DeL5l19N/uWxkfW3zNxO8u5J6x+ihqGuGXx
Sjf6gpMq9gV9WaBQtZnRSbuNNaGB3D0gmcEhShBAYmYwQBBIUVFzBlJoZnO6rhRr
lrYxym0dqgH2szh23QFwta/4qGKAbc3yyAsxh4brsAtkv7P4MgCYrNtRJhdq3LIV
qEZG7V4QFzYmdi+1dJdvc5nDxsRH3ijBMZf45884GXUxIhSpnh9qqEeOzGs94nc+
GoU+TSbNrznuTy77P3KuQfnaiY+KQVLTZi10zN2UuZbIUFLOxOSD/dRQo7zDju+1
PaKKXYh0q8Z5JmYTXqlFgBUo2zd3W0gvOWo+SNVSuFchVzg8XQSC1xTv/0UO45us
H96p+HZNmbuFIBsz04VpkLy49+YEb7F7bRFQuqkrQlnMVnUDfvcbAHseCIohonN4
RZv0M6iFGj5kObRiCJOqlacQbuT4XOdikuJDgaCBinPXCNGUoWE=
=L8ZM
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
