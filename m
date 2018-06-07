Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id d2mdB4KaGVvjJgAAmS7hNA
	; Thu, 07 Jun 2018 20:51:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 221856074D; Thu,  7 Jun 2018 20:51:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 868256063F;
	Thu,  7 Jun 2018 20:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 868256063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeFGUu6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38419 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932634AbeFGUuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:50:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0283EAF25;
        Thu,  7 Jun 2018 20:50:38 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: Ben Evans <bevans@cray.com>, James Simmons <jsimmons@infradead.org>
Date: Fri, 08 Jun 2018 06:50:29 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 10/11] staging: lustre: move ldlm into ptlrpc
In-Reply-To: <D73EEFA7.FCA6%jevans@cray.com>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511923.16761.9237280635711887801.stgit@noble> <alpine.LFD.2.21.1806070546210.23188@casper.infradead.org> <87sh5zlyf4.fsf@notabene.neil.brown.name> <D73EEFA7.FCA6%jevans@cray.com>
Message-ID: <87k1ramicq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07 2018, Ben Evans wrote:

> On 6/7/18, 5:48 AM, "lustre-devel on behalf of NeilBrown"
> <lustre-devel-bounces@lists.lustre.org on behalf of neilb@suse.com> wrote:
>
>>On Thu, Jun 07 2018, James Simmons wrote:
>>
>>>> The ldlm code is built into the ptlrpc module, yet it lived in a
>>>> separate directory.  This requires filename editing in the Makefile
>>>> and make it difficult to e.g. build the .s file for code in ldlm.
>>>>=20
>>>> All the ldlm files have distinctive names so confusion from having
>>>> ptlrpc and ldlm in the same directory is unlikely.  So move them all
>>>> into ptlrpc.
>>>
>>> Nak. The reason is it would be nice to keep the directory structure.
>>> What really needs to be done and Oleg has looked into it is to reduced
>>> the number of modules created down to two, one for LNet and the other
>>> lustre.ko. This also is a step in the right direction to remove the
>>> create struct obd_ops and struct md_ops pointer madness. Well their
>>> is the issue with obd echo client but we can deal with this at a later
>>> date. Also the number of EXPORT_SYMBOLS and things will greatly reduce.
>>
>>Yeah, you are probably right.
>>I had a bit of a look at how to build everything into a
>>single module.  You can do with by having a single make
>>file that lists parts from other directories - the same way
>>that ptlrpc includes files from ldlm - but that is rather ugly.
>>
>>I've very nearly got it working using the lib-y infrastructure.
>>I can build lnet as a single module, but the dependency calc isn't
>>quite right so things happen in the wrong order.  The build
>>fails the first time because some files don't exist, then
>>succeeds on the second run.
>>Hopefully I'll figure out how to make it work tomorrow.
>>
>>Thanks for the review,
>>NeilBrown
>
> Would this be client-only, or could the server code be added as well with
> an ldiskfs/zfs module?

The important step is creating the infrastructure so that choice can
be easily made, and changed, with just a single line in a Makefile.
Fine-tuning decisions can follow.

I doubt it would make sense for ldiskfs and/or zfs to be in the same
module as lustre.  I also doubt that either will ever land upstream so
it hardly matters (to me).
When the server lands upstream (I think it will), it will use (at least)
the upstream ext4.  This might require changes to upstream ext4
(I understand a lot of work has already happened in that direction).  It
might require sacrificing some functionality (hopefully only
temporarily).  It might require having an incompatible on-disk format
(which is unfortunate but quite manageable).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsZmpYACgkQOeye3VZi
gbleNQ//UgWRXf1X5/IeFhJbL3XELrng4HlePmsVRZ8CGGbED+CXzeyhzJOuT3cv
DawotaTex1FEb+e4eRbfh9/lwcSriZz37FmyGUSNuoZXewKO42+IP8gRmS2jDsNo
8jHConYRfkwmB2NDFUMM5dnfY5VFFmVVZsoqa6pyw8Rob4hGeLBxvby/gR73Ut0q
wJy/7DEVJggQFTiJ5lIEKhqnq3rN9roLfN6I3cau9MBbOELjmTRs5z6s71rwVF7M
ByXIu9lWKmOC49vSSEGLSJQcAiLCESM+gjTcavE5k15EE+PiFsQ1dGdLO3A0gHJg
RxTnjnwi3OLLZSEcrinteZog5HHQwNj4HeH0fUrvb9nRLngfkYJnTm+cMe487sDY
4iQhRFLiLikWDO4N6UMUeNEO/L8UZ3wysMlIAYPifiyc9aObnQ2CtQdkPJSpbXf6
TXLXGRn61gD78EVDYMvP6IQXwkD30WOjaE8z+XCw7C2wg7ayejDYXoxQ8fRrhpcG
uL1w5W4WO5+ai0iLIWaF2kcx2Jio59iV55f700sdHpkj/iRHGzkEy6xfAlcSUYJX
isI72/j/FMIjpGvZ88RIEQ46aMB1thPkfOzWA7rfogXfvWZSfhtvRCklV6D9/2Bt
D9/kLog2nfI+nfKWc+JVJmB0Dl90lQ5aRMoQnUo+8+m0nc6lPAI=
=qQIo
-----END PGP SIGNATURE-----
--=-=-=--
