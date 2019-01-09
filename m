Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBFBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4B72070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="Nq6lxBmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfAIG2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:28:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:34435 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbfAIG2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547015294;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1OdEB3EtEnRSly1kcr4nRjkcZPexvXmqwXWNB1dtNIw=;
        b=Nq6lxBmT0RGNAuTm2Vg69dW6ibk1byKrZfXW97jbnt15/eXzm6cuSiQrcHafDHFpLv
        gIy2o5kGLsDqxuLqDIwyHvzTH5PfB5H9NkYCoY96mxeCvzBrjAFtfyDXiUa5Cs/8MLMx
        bA/hAeu+ZKxvEbVshYQleyXpr6Xil2rujYZGBZ49zj0C9z+omCvzzgjn7cA4/fy1+aGU
        VnlAPL7oPn+uCx3eOmLMpyhZtT8qardUHeaH6Lqx+ZyFXj+sLL4B8wAypkfWH9I/bsbN
        +Hq6iiMIiw9FKJnuc4gF5zML7OSMrlYZYzhr49zu/OPRhQuFsXgBR7+JfakxC9WpCsxT
        EbKA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaLvSbdkg="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv096RSNnh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 07:27:28 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date:   Wed, 09 Jan 2019 07:27:28 +0100
Message-ID: <3239276.QO2kezntxR@tauon.chronox.de>
In-Reply-To: <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
References: <20190103143227.9138-1-jlee@suse.com> <1565399.7ulKdI1fm5@tauon.chronox.de> <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 00:54:22 CET schrieb Andy Lutomirski:

Hi Andy,
>=20
> I think that, if the crypto API is going to grow a KDF facility, it should
> be done right. Have a key type or flag or whatever that says =E2=80=9Cthi=
s key may
> *only* be used to derive keys using such-and-such algorithm=E2=80=9D, and=
 have a
> helper to derive a key.  That helper should take some useful parameters a=
nd
> mix them in:
>=20
> - What type of key is being derived?  ECDSA signing key?  HMAC key?  AES
> key?
>=20
> - Can user code access the derived key?
>=20
> - What is the key=E2=80=99s purpose?  =E2=80=9CEncrypt and authenticate a=
 hibernation image=E2=80=9D
> would be a purpose.
>=20
> - Number of bytes.
>=20
> All of these parameters should be mixed in to the key derivation.
>=20
> Also, an AE key, even for AES+HMAC, should be just one derived key.  If y=
ou
> need 512 bits, ask for a 512-bit key, not two 256-bit keys.

I concur with your requirements. However, is the kernel crypto API the righ=
t=20
place to enforce such policies? To me, the kernel crypto API is a tinker-to=
y=20
set of ciphers.

The real policy enforcer would or should be the keyring facility. Thus, may=
 I=20
propose to:

=2D implement the cryptographic primitive of the KDF in the kernel crypto A=
PI

=2D implement the policy system how to use the KDF in the keyring facility

Ciao
Stephan


