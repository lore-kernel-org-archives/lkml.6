Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D56C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D54920871
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D54920871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeGCWOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:14:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753183AbeGCWOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:14:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6AB1AD73;
        Tue,  3 Jul 2018 22:14:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 04 Jul 2018 08:14:28 +1000
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 4/5] kbuild: disable KBUILD_MODNAME when building for mod.a
In-Reply-To: <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com>
References: <152929708853.17463.17302660556961083137.stgit@noble> <152929772052.17463.10728056000221362647.stgit@noble> <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com>
Message-ID: <87efgk0xx7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Jun 27 2018, Masahiro Yamada wrote:

> 2018-06-18 13:55 GMT+09:00 NeilBrown <neilb@suse.com>:
>> When building an object to be included in mod.a we
>> cannot know the name of the module.  So don't define
>> KBUILD_MODNAME.  This will ensure attempt to use
>> that macro when the module name isn't know will
>> trigger an error.
>
> Honestly, I hate KBUILD_MODNAME.
>
> If KBUILD_MODNAME is undefined,
> you cannot call pr_debug() in the sub-directory for example.

I think this is only true if you have something like

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

in your .c files.  Developers who use modobj-m could be advised not to
do this.

>
> CONFIG_DYNAMIC_DEBUG requires KBUILD_MODNAME,
> but people often miss to notice that, then cause build errors.

Yes, I can see that.
We could change it to use a default ("no-name") if KBUILD_MODNAME isn't
defined.  Or we could require that KBUILD_MODNAME always be defined.

Where I've been using these patches I've sometimes been adding

  ccflags-y += -DKBUILD_MODNAME='"FOO"'

to Makefiles so that modules_params get handled correctly on non-module
builds.  I've thought about instead allowing "modobj-name" to be defined
and requiring that it be set if either modobj-[yn] is set.  Then it gets
used for the KBUILD_MODNAME when building modobj modules.

Would you prefer to always require KBUILD_MODNAME, or to use a default
name for dynamic-debug?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls79UQACgkQOeye3VZi
gbkeuw//Qmp9HcEtcoeR8iagsbCxtosyNdqv4zrcLVMtTIOc3ECO8dFFPtKvVyUB
uu3/HnDYNwx2En59vilrk1pdfpKe97ivK4MBzQ/ztMspploxGuVqL0qrExjxKYXB
shkzEhxu8bjSRiZ7DpOBMN2ngUDN+oIbcmRST3UuYlJz4yUleqoI3wpWpcO6faQ6
wFNRbV7SUT5LRaunEeIyWIzgvOqIU+97iv2AeCyZjfOL5del/v/IKdeMj9JVFJQK
8UUmF8oktj8Rys+5eJ0jjxqhsOatUiwnsF4ThrC3eR3gro62RFkgfTMb4tzZ/jAU
s5G8diFhqzwg+KXCD2WdnmejWqjuHWCZvAvJzZ8KfomcfP7kjE8kMjJSZun4xh1j
Th29yWuH2jYm5/Ltw9YftqXjogrxdMmscl3Xotdz9m1NUQVar2Y27BZm3v2E5Mw7
FsMmgml1rCDh6OuVxY8j2hoB+1TbBx4Yo7uwp/DL/8WUKKb6rTVxdZ8oiot6YqH1
RskoE1jXW7xf4ZOtFGZ4+u4qORqd+x8hMyEFY/tx2vA5ULC539QxoFtL1saIuU9M
LET3AgxhGO70C1cGJtzgPLyzNkCVARcSaFINB52qpRtKcBYiwJGagJS5t9ZF92+U
Y/xa0Q05t5wCpeuxKtfNbr2whMSLnSA9GS5gTpRqazF4tQEWcuA=
=G3LZ
-----END PGP SIGNATURE-----
--=-=-=--
