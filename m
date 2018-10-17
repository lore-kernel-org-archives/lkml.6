Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F888ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E518C2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E518C2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJQXT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:19:59 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:15364 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQXT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:19:59 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 0DF2E40ABD;
        Wed, 17 Oct 2018 17:23:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id vlT2dOdZJDGe; Wed, 17 Oct 2018 17:23:44 +0200 (CEST)
Date:   Thu, 18 Oct 2018 02:23:32 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, Tycho Andersen <tycho@tycho.ws>,
        dev@opencontainers.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 0/3] namei: implement various lookup restriction AT_*
 flags
Message-ID: <20181017152332.madyld45jvhtoog3@ryuk>
References: <20181009070230.12884-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yre24zmboslmb52j"
Content-Disposition: inline
In-Reply-To: <20181009070230.12884-1-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yre24zmboslmb52j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-09, Aleksa Sarai <cyphar@cyphar.com> wrote:
> The need for some sort of control over VFS's path resolution (to avoid
> malicious paths resulting in inadvertent breakouts) has been a very
> long-standing desire of many userspace applications. This patchset is a
> revival of Al Viro's old AT_NO_JUMPS[1,2] patchset (which was a variant
> of David Drysdale's O_BENEATH patchset[3] which was a spin-off of the
> Capsicum project[4]) with a few additions and changes made based on the
> previous discussion within [5] as well as others I felt were useful.

I've been thinking about this problem a little more (from the UX side of
things) and I have a feeling that adding 5 different O_* flags related
to resolution -- rather than properties related to opening the file --
might be less than ideal (even though, as discussed in previous threads,
there is a need for these flags and for them to be separated).

There is *some* precedence for this with O_PATH[**] changing fairly
large semantics of openat(2) but there are some things about O_PATH
which I think could be improved.

What if we had a resolveat(2) which acted like openat(..., O_PATH) *but*
it allowed us to have new flags and to separate the scoping flags from
the (fairly limited) space of O_* flags. Then O_PATH could effectively
just be a legacy way of doing resolveat(2) -- with only O_CLOEXEC,
O_DIRECTORY, and O_NOFOLLOW support.

And the main things we could add would be:

  * These resolution flags, with only support available from
	resolveat(2) for the moment. The idea would be that AT_EMPTY_PATH
	would be the recommended way to make use of this.

  * Support for RESOLVE_{NOPERM,RDONLY,WRONLY,RDWR} (which after some
	discussions with Eric last year might be necessary in order to make
	/proc/$pid/fd/$fd re-opening of O_PATH descriptors safer -- which is
	something that we use in both runc and LXC).

Is this idea palatable, or was this something considered during the
development of O_PATH and someone had an argument why augmenting O_PATH
is better than a new syscall?

[**] And while writing this paragraph I noticed that I didn't update the
     O_PATH "flag whitelist" to allow the scoping flags to affect it. I
	 will include a fix for this in v4 (I must've lost it in an early
	 rebase before I sent v1).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--yre24zmboslmb52j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvHU/EACgkQnhiqJn3b
jbQ9yg/7BtjjNaT0TCHf7tBBGch6f70YhcTrfpJBxLByOep4fb/HsSXTMhcy6cCI
ZzmSMXyuNOhlxdg7b1ON5+rLJY0MDmsVzaLhCKCg0erstdTSESUdt7yqnAz5qPw6
+Sag25hC7wXl8U2/Wem/JK9JZXEAcCfUiadac8MF7tWluy/Ivf/mWhsvkmCN00UY
TfSVlb7t83PwGEpTEzdbZ6IkwdEIky44vYJl/Phbau/01A8tM51f74KiDlos/+XH
eMkzU9MYdhG7bsmEh+erBGCuiFevJ+ffAerjerwhqKOCi6KAEbiQJSqxlbRX2rmT
7azLPL6IiJjH47NfnXIo1gTgXKJYp8up7esQpj/lbcP7ZraxEveBQpvTxvGHEdUM
+7CzFxDIVbljZD6kRgvTM/iY5KXHFVcCsg+7NhRbfQoqViJeLL8hRshtqki2+zbX
3fSmkKYIRzkMirrePpT0VVLJw7mkVQfPVAyyn4ZixM+ECzkLSTnwaac33IVvLH6z
86Tf9yBPnpeH7A0MaCUs0EfTSV6hnSV9Wc2RYK+C5bTnBHUUCmO0gN6WIFSHtNAI
BynbcTmD3YACuFxa4hB/h/zqsjrKaSi8g6gVq21+Q10w3iMM93rAZwjaMTGjS1A3
AScZfEJi459Ez/xq7+rwThMW5BD66aX/txL95J+bV8B55V7uvX0=
=06RI
-----END PGP SIGNATURE-----

--yre24zmboslmb52j--
