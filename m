Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B223C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A9A2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Q4LHr1Uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A9A2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHWXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:10:24 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:36278 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeHWXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:10:24 -0400
X-Greylist: delayed 44732 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2018 19:10:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1535053149;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=l0DFXMg6XzBAxgj6DcRPModPWA/TwRl0027u7KvHwLk=;
        b=Q4LHr1UzkB5lADeQIdTRutEwg+6lB2ORYEUJEICJkJcBCifyAYQulLqK5UAUG3OZ9o
        mkWWOZHbtkZ6tQe/K5P5QUgxsp6wkZskdp1SB+fkIteyUNV0G17SuitblSM/55W6m9qe
        C0DsPkIyJvR+f7cbGADz1+v8JxxA13uqmNtxRWzRsCYUnkSCEoE3nKZbqIljVgFJHh7m
        TaQPoJ0nwRuk+6hj4H/u0BA4mT4iOP57tgTopYCGbZ2WbqyMQjRRIysstMYq9WJKfkI+
        dU3FGYcYj2bwwhIGyg7VhSlnNEnE1MWnyq9mSAeMylCKLmtmbmf54lbDUe7MW4wwx+0z
        7Jrw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRy/ty7tTpW/8zF/8xB85IFGRY1Tis01RzDelLRJ5HrWjk="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2003:e9:43cd:3500:1802:53:6c96:2488]
        by smtp.strato.de (RZmta 43.20 AUTH)
        with ESMTPSA id c07b1bu7NJcq2Ca
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 23 Aug 2018 21:38:52 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] modules_install: make missing $DEPMOD a warning instead of an error
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <4449cd91-fae5-caf1-a917-82e0c5f0aba8@infradead.org>
Date:   Thu, 23 Aug 2018 21:38:51 +0200
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A695D99-A693-4E81-A321-4DC599A8F36A@goldelico.com>
References: <4449cd91-fae5-caf1-a917-82e0c5f0aba8@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> Am 23.08.2018 um 20:13 schrieb Randy Dunlap <rdunlap@infradead.org>:
>=20
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> When $DEPMOD is not found, only print a warning instead of exiting
> with an error message and error status.
>=20
> Warning: 'make modules_install' requires /sbin/depmod. Please install =
it.
> This is probably in the kmod package.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 934193a654c1 ("kbuild: verify that $DEPMOD is installed")
> Cc: stable@vger.kernel.org
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> v2: add missing "exit 0" and update the commit message (no Error).
> v3: add Fixes: and Cc: stable
>=20
> scripts/depmod.sh |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- lnx-418.orig/scripts/depmod.sh
> +++ lnx-418/scripts/depmod.sh
> @@ -15,9 +15,9 @@ if ! test -r System.map ; then
> fi
>=20
> if [ -z $(command -v $DEPMOD) ]; then
> -	echo "'make modules_install' requires $DEPMOD. Please install =
it." >&2
> +	echo "Warning: 'make modules_install' requires $DEPMOD. Please =
install it." >&2
> 	echo "This is probably in the kmod package." >&2
> -	exit 1
> +	exit 0
> fi
>=20
> # older versions of depmod require the version string to start with =
three
>=20

works for me.

  INSTALL sound/usb/snd-usb-audio.ko - due to target is PHONY
  INSTALL sound/usb/snd-usbmidi-lib.ko - due to target is PHONY
  DEPMOD  4.18.4-letux+ - due to target is PHONY
Warning: 'make modules_install' requires /sbin/depmod. Please install =
it.
This is probably in the kmod package.

and returns success status.

BR and thanks,
Nikolaus Schaller

