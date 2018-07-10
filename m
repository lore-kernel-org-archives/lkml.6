Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C65C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCF2208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCF2208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbeGJTkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:40:17 -0400
Received: from sauhun.de ([88.99.104.3]:44470 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeGJTkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:40:16 -0400
Received: from localhost (p54B33462.dip0.t-ipconnect.de [84.179.52.98])
        by pokefinder.org (Postfix) with ESMTPSA id D661A56A485;
        Tue, 10 Jul 2018 21:39:44 +0200 (CEST)
Date:   Tue, 10 Jul 2018 21:39:44 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Message-ID: <20180710193944.34phe4zafzvwjm5v@ninjato>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
 <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato>
 <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iy6h4fc4vvkdlifj"
Content-Disposition: inline
In-Reply-To: <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iy6h4fc4vvkdlifj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry, what do you mean "show up as"? Yes, we could first shift all our
> addresses in user-space before passing them to the driver, so that the
> msg->addr field is exactly what the hardware expects already... This would
> be non-trivial for our users considering all our documentation represents
> the addresses as the top 7 bits of a byte :(

Ah, now I understand the whole situation! Good that I asked. But I have
bad news for you:

msg->addr is 7 bit and LSB aligned. No way around that. This is how
Linux I2C worked since the beginning. You have to adapt to it.

I know what you mean. Most doumentation I get has the addresses in 8
bit, i.e. 7 bit address shifted + RW bit. But sorry again, the Linux
representation is different and all drivers have to adhere to that.

An EEPROM ist at 0x50 in Linux. There is no write addr 0xa0 and read
addr 0xa1.

> > > Indeed, real 10-bit addresses require some additional manipulation of=
 this
> > > I2C master in order to work. We don't support it right now.
> > Then you should remove the associated FUNC flag.
>=20
> Ah, but due to the addressing situation, tools like i2cget don't work with
> our addresses unless the 10 bit flag is specified. For example, we may wa=
nt
> to access 0xA0.

This is a kinda dirty workaround to the above problem. It is even wrong
because 10-bit addresses look totally different on the wire.

Sorry for the hazzle with the docs, but there is no way around that.


--iy6h4fc4vvkdlifj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltFC3wACgkQFA3kzBSg
KbYUlw/+P+yaoYck29Vb1xu2t8LvZhr4HGDJlnjCyGMHy93cragQfDf/Wh6Q3tcX
moehkb/k7Bgv2UnqAp4oYyNklMVZzfeoCbQAfBHN+qIcIh6G6T4Aqle0AtboucrU
2UecWaKFClaqIuEihXfCWbVAFlmliLMTfGdqDXlycPbNVYOXcdQ5a3tfmq1QUcLV
UfzoXlvtXLr9YcWjgYGNHStOQjRmpt5RonjsmueoHKUQd0GF5HyqpDrxTsYRsCEs
CMgB+M7fsuh/OwW00H59NYXlMXcnmSiM2mzD3KOOs8VNYDw13Af1//XZWSZnpdud
rZ5sEd+OvT4SvNFIyDE+9n0a1AYcup4SCLQVDfn4g3bLpp0lgix+vnI4Rz9o57DD
favWSvG0VTPkEkuYQGeDT1Mv0Yuld9/ZEzAkOj1pL7lG0iOfEvvXWssAhoa/eoA6
eIKYFSPbI7PZXtW5Hg9eOCy/oBKaFcVnn1VMtqIjDQIy/xcoELCyI1eJi0IjMnkp
hwXJcc7l8vvLt2IgG+8gZpLGYhPAdDZFvvQagF/xwmMyKNNqook47uS8uEuRd1Zt
TeuxGE8qg+a6mMQl6YZKIwfbujByjghNLDYL0kirHzVbVb04XAUxT5gJTD1gt2F5
1gFtGPOLQhT2m/8sHRcGK759DUGnT0BtKh+EKDq8Qx1lORuHk0U=
=w5AV
-----END PGP SIGNATURE-----

--iy6h4fc4vvkdlifj--
