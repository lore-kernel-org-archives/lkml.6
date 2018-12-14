Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C0FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC2F2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="MlTN2WyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC2F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeLNNQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:16:29 -0500
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:41754 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729641AbeLNNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:16:27 -0500
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2018 08:16:26 EST
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 43GWBx5ZpFzRhS8;
        Fri, 14 Dec 2018 14:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de;
        s=stwm-20170627; t=1544793065;
        bh=QDppt8pJ9WfCvUfKYqviGV1VHqdZmnZK81Qt+pqzK3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlTN2WyV2Wuduph3IaQ9mugzJzuTgFYKA4hDhBi4k2xUBDiYJm5+N15NTPABRTpF8
         eM9nqkyA0jT39dz4R+Zpa/1gr/v8bUBKFkbmfw5S3e3chGd8GkYM94F9gFUuqFmUDF
         kzxs8aKaOygGBciH4nhkZeY/jpO7KPxJJGQIaqTTLOeL0D/VfUdb4OKowAA5VTSYjF
         E+MRVXoocM/4hJkp6M34ajLlaZdjYK3VuDuX5ShpzdE8ePOssSusJZj/gMbMmx3gl8
         VBoItNYGqDHOo4eAkrDLwgiTruh0pQQ59iEr8a5y7zjvuqrpImQVuw3DR4pr2/mtjr
         dmkH5ou67ASBQ==
From:   Wolfgang Walter <linux@stwm.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
Date:   Fri, 14 Dec 2018 14:11:05 +0100
Message-ID: <2559562.n5nkmlqv4s@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20181210.095856.580441946779980596.davem@davemloft.net>
References: <00000000000075fe86057ca6367e@google.com> <20181210124724.iuver2va3yjdsokf@breakpoint.cc> <20181210.095856.580441946779980596.davem@davemloft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Dezember 2018, 09:58:56 schrieb David Miller:
> From: Florian Westphal <fw@strlen.de>
> Date: Mon, 10 Dec 2018 13:47:24 +0100
>=20
> > After recent tree conversion, we could probably make the exact poli=
cies
> > part of the 'inexact tree' (which would be renamed to 'policy tree'=
 or
> > some such).
> >=20
> > Special-casing the exact policies made a lot of sense when we had
> > a single list for the inexact policies (to keep its length down).
> >=20
> > But now I think we could try to unify all of this and only maintain=

> > the existing tree-based storage.
> >=20
> > Would also remove the need to do lookups in two different
> > data structures (bydst-hash-then-inexact-tree).
> >=20
> > What do you think?
>=20
> I think this makes a lot of sense.

Sites mainly using tunnel mode this certainly makes sense.

I'm not so sure for transport mode. With transport mode the netmask usu=
ally is=20
/32 or /128, respectively (there may also be trap-rules). So a site onl=
y using=20
transport mode (road warrior scenario, for example) may see a large=20
performance regression if this is changed. They may do not have many en=
tries=20
in the inexact list if any at all.

Maybe there are a lot more transport mode users than tunnel mode users,=
 this=20
would explain why the removal of the flowcache did not hit that many pe=
ople.

We do not use transport mode, so I'm not familiar how strongswan for ex=
ample=20
handles that. I think that since 5.3 or so strongwans allows a catch ru=
le=20
(inexact) and then inserts exact policy rules on the fly. But I don't k=
now for=20
sure. There are a lot of tests on strongswan for different scenarios wh=
ich=20
also demonstrate how policy and state table finally will look like on a=
ll=20
hosts.

Here is one with such a scenario (transport mode trap policy on a gatew=
ay,=20
three road warriors):

https://www.strongswan.org/testing/testresults/ikev2/trap-any/

So I would try to find users who are heavy users of transport mode and =
see how=20
this change would impact there performance.

Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
