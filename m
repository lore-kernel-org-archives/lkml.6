Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TRACKER_ID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E5AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243E2222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="OxNU3yDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbfBKPei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:34:38 -0500
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:57788 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388498AbfBKPeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:34:37 -0500
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 43yqbH0G0LzRhS4;
        Mon, 11 Feb 2019 16:34:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de;
        s=stwm-20170627; t=1549899275;
        bh=19nuiacV19xmkpfgKbv+iH3PJpuaptko+I7zTJ2ft7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxNU3yDcaN3H1PrQOaftLhUJN35jnqGVr7zf3DIfQaerJ+PBnG72ioCK/o22gUoGI
         mqCrhncgFmEv6eUGE8+1pv04CGWidvzpOwV+a970M56vbCBKRUaw7cYKbEmON9/E7b
         wHPpgVbBgEEM6D81PEOtYaIUFC8KT0j92eqy5x04M1pNN+BdsQ3KLjdsl40KsMY7Vm
         fxZXM6reSNRnSTFbLdun0Nd0DqFQs9vvZd6Lfo0xN2SO2ZMF/zwWWETX5+Q0Hcjz81
         3SxMOhUGKQZMCBMTKR7OEsh8oroJ6yW2SNnqZv2xs91Nv6oPCK3CYJXIwi90YYDCJY
         U0p2ouScLPNdQ==
From:   Wolfgang Walter <linux@stwm.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, Chris Mason <clm@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        akpm@linux-foundation.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached pages"
Date:   Mon, 11 Feb 2019 16:34:34 +0100
Message-ID: <2582452.8YSf1DXvRS@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20190207102750.GA4570@quack2.suse.cz>
References: <20190130041707.27750-1-david@fromorbit.com> <20190131221904.GL4205@dastard> <20190207102750.GA4570@quack2.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 7. Februar 2019, 11:27:50 schrieb Jan Kara:
> On Fri 01-02-19 09:19:04, Dave Chinner wrote:
> > Maybe for memcgs, but that's exactly the oppose of what we want to
> > do for global caches (e.g. filesystem metadata caches). We need to
> > make sure that a single, heavily pressured cache doesn't evict smal=
l
> > caches that lower pressure but are equally important for
> > performance.
> >=20
> > e.g. I've noticed recently a significant increase in RMW cycles in
> > XFS inode cache writeback during various benchmarks. It hasn't
> > affected performance because the machine has IO and CPU to burn, bu=
t
> > on slower machines and storage, it will have a major impact.
>=20
> Just as a data point, our performance testing infrastructure has bise=
cted
> down to the commits discussed in this thread as the cause of about 40=
%
> regression in XFS file delete performance in bonnie++ benchmark.

We also bisected our big IO-performance problem of an imap-server (star=
ting=20
with 4.19.3) down to

=09mm: don't reclaim inodes with many attached pages
=09commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0 upstream.

On other servers the filesystems sometimes seems to hang for 10 seconds=
 and=20
more.

We also see a performance regression compared to 4.14 even with this pa=
tch=20
reverted, but much less dramatic.

Now I saw this thread and I'll try to revert

172b06c32b949759fe6313abec514bc4f15014f4

and see if this helps.

Regards,
--=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
