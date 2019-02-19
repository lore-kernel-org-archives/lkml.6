Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D4F21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="BQKXjjZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfBSSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:43:25 -0500
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:53098 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfBSSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:43:24 -0500
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 443qPQ6bmNzRhRx;
        Tue, 19 Feb 2019 19:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de;
        s=stwm-20170627; t=1550601802;
        bh=K5MS3jZ13BGgh3RDJZiSh61A7blwovI8lflGwDP8VL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQKXjjZwoTTYNQUcaNC+Jl1dGibLplg9PPcbHCS2jM6/HZwYpnPiZ89xe+PMG6hyI
         kfPcyNmGjNGHnRtZIjRkiKRzpV/TX+AGdt/9/PMC03gsKIugQxLNmjSPUMuZmP1+9U
         XyEtjPUJgNzZDP5aOLcrWOafrzejEN4SvdRA6rZmuBYyfXv1wgj8BTJy14HY1b7jP7
         Z0ZWr4yRrxembIkboC25ex5d7/u8+Q3igU19rB7lUgkgPh51EXFcaXterdMwmlOBrd
         /0w+E/y66LIoKuF2i2ksYNPvhF/4Tsgrf2IrdL1WK0wC8Z8xotMys96v+nsm5oKWBo
         BIFPcAJ1Bhm0g==
From:   Wolfgang Walter <linux@stwm.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Roman Gushchin <guro@fb.com>, Spock <dairinin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a relatively small number of objects"
Date:   Tue, 19 Feb 2019 19:43:22 +0100
Message-ID: <4113759.4IQ3NfHFaI@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20190218193452.GV10616@sasha-vm>
References: <20190218133454.668268457@linuxfoundation.org> <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com> <20190218193452.GV10616@sasha-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. Februar 2019, 14:34:52 schrieb Sasha Levin:
> On Mon, Feb 18, 2019 at 10:30:44AM -0500, Rik van Riel wrote:
> >On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
> >> 4.20-stable review patch.  If anyone has any objections, please le=
t
> >> me know.
> >>=20
> >> ------------------
> >>=20
> >> From: Dave Chinner <dchinner@redhat.com>
> >>=20
> >> commit a9a238e83fbb0df31c3b9b67003f8f9d1d1b6c96 upstream.
> >>=20
> >> This reverts commit 172b06c32b9497 ("mm: slowly shrink slabs with =
a
> >> relatively small number of objects").
> >
> >This revert will result in the slab caches of dead
> >cgroups with a small number of remaining objects never
> >getting reclaimed, which can be a memory leak in some
> >configurations.
>=20
> What's the "right" choice though? we get either leaky cgroups or hang=
ing
> xfs.

This not only made xfs hang. (Since 4.19.3) on two of our servers ext4 =
got so=20
sluggish that login with ssh needed a minute and more. bash tab complet=
ion was=20
unusable. Sometimes systemd-journald was restarted with "Watchdog timeo=
ut=20
(limit 3min)!", (journal also was on ext4).

>=20
> >But hey, that's your tradeoff to make.
>=20
> I don't think that any decision was made here, the stable tree simply=

> follows upstream with regards to fixes and bugs such as these: we rem=
ain
> "bug compatible" with upstream in these scenarios, there was no decis=
ion
> made to prefer either bug.
>=20
> --
> Thanks,
> Sasha

Regards
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
