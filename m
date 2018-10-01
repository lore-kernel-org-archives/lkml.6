Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EAA208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HT8DrI2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EAA208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeJAMcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:32:12 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:51592 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeJAMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bV6HLCMbw4S6xhR2sqP0XXA2hpM2oSt17djXL+EefOE=; b=HT8DrI2CltCHBtUWvTMUJggsY
        ZpOlAS1ZZRtPd5sk32sO/9VKjCExPA7SM4i2FOe70rP84W+6xoL2ZJp+YrB85fozQpdGmyP4S/sWe
        kdJsCGfAdX1sQNIGkQAXgeriFTeOFjdQl5XbS6RKaz/PGQgtBPYh/ibKORohSrWJWx+UQ=;
Received: from [2a02:790:ff:919:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g6rBb-0003fo-DA; Mon, 01 Oct 2018 07:56:03 +0200
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g6rBZ-0001Mn-9N; Mon, 01 Oct 2018 07:56:01 +0200
Date:   Mon, 1 Oct 2018 07:55:37 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Pavel Machek <pavel@ucw.cz>, kishon@ti.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] twl4030_charger: fix charging current
 out-of-bounds
Message-ID: <20181001075537.6f16ae2b@kemnade.info>
In-Reply-To: <20180930201642.GC23554@amd>
References: <20180917052035.12234-1-andreas@kemnade.info>
        <20180930201642.GC23554@amd>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1EQi4yZsa3QO/o1S=wQrEYx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1EQi4yZsa3QO/o1S=wQrEYx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sun, 30 Sep 2018 22:16:42 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2018-09-17 07:20:35, Andreas Kemnade wrote:
> > the charging current uses unsigned int variables, if we step back
> > if the current is still low, we would run into negative which
> > means setting the target to a huge value.
> > Better add checks here. =20
>=20
> Do you expect this to happen in practice? Too high current while
> charging seems bad, right?

I think you need a power supply delivering < 4.75V  and > 4.3 V without load
and still > 4.3 V (so that vbusunplug detection does not trigger) at 1.6A
(the maximal charge current) including loss in cables.
I think that is really rare. It is not the standard charger you find in your
cupboard. Could probably be a lab power supply with a good cable connection.

As a side effect of some other bug (I do none like this):
If some regulators are not enabled, voltage measurement can be wrong. And
then the regulators have to be turned on right in time for the charging to
start.

But I know one way to produce that behavior:
Without my "phy: phy-twl4030-usb: fix denied runtime access"
The following steps are possible to achieve that with the gta04:
1. put your device to suspend without charger connected
2. connect charger which could provide high currents.
   phy runtime will not be resumed, usb voltage measured will be very low
   (I remember something like 1.8V), so the power ramping up will be
   stopped immediately and that step-back will set current it to an
   erroneous value but it will not start charging
3. echo auto >/sys/class/power_supply/twl4030_usb/mode
   then the charging starts with the target current set in the last step.
>=20
> Cc: stable?

Rethinking it, it would be a nice idea, but I think the mentioned=20
"phy: phy-twl4030-usb: fix denied runtime access"
would even be more important to have in stable, since it fixes actual
charging problems. Well, if your device does not boot because it is empty
or if there is sometimes a kernel panic is no substancial difference to me.

Regards,
Andreas

--Sig_/1EQi4yZsa3QO/o1S=wQrEYx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluxttkACgkQfb1qx03i
kyQB9hAAx960ckXwHETStQVEcMvvDamrEfQYvcZddShX+Kh06PmqiepxhJ0Fy6gy
JfCc4SlCd89yiP6A75SB8A5XoegwEEKmYlT+FEgMducNlhqS3Bh6H3gvpEVPc0bV
WfhnX1mBzIiT4VIVusvDPQepmNc3bMu/BhZ0I5yb/SXAR4YlWwWYH+kjsj1s/SAH
FxAl+mjbRwSbK5b3zyx+DQXcbtSI0iHvqt41pBVNEYab5uOK7hO+vFAkzsYXbbzX
jSYKxl+V9mX8g+Yod/ibQ/uxXLr87Yg7tE4z2XWuJqmN+M0kR9yrxFEEDrw0kp5x
/C/X0Ake+HKtaO3IAfqFEP6vdjoIllYIf9+FD7E4f+KUQv/KcOnebEuwK8Xubgmh
1WaiMbq+HHXgikVyfkaA/XFgoqTFgUCYrMi1WcAZOaG7u5DfXOlWvhispqzl+H1x
ATmpV6QC9S2RT7JFegraBAeeLHBqb8ZUu6lhH6V4HdHrUUk4LNbASgOe+h7Yjakq
tQWGQ/cMwJQqAtQ9nsptTPw/ZlM2v3Nm5kmumWQDsAEzyE9Ws3ODEp5ZE0DBAEIO
CjZpzwgXCWCFxiw4qJdTLdHelvKA79DyvbZqNEWYkbz4XqawNFcKfhiAe0cPSySV
VDF/w9+TaM0nS+Cbjtyyj0tDW5oTaN8YbszHFyuAq/dqYdad4Bc=
=FZM9
-----END PGP SIGNATURE-----

--Sig_/1EQi4yZsa3QO/o1S=wQrEYx--
