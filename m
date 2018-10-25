Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA062082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA062082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJYMSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 08:18:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbeJYMSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 08:18:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27EC4AFAF;
        Thu, 25 Oct 2018 03:47:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 14:46:57 +1100
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
In-Reply-To: <20181024131534.GD11606@thunk.org>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com> <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org> <87h8hkc9fd.fsf@notabene.neil.brown.name> <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com> <871s8ndg6a.fsf@notabene.neil.brown.name> <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com> <871s8g6roy.fsf@notabene.neil.brown.name> <20181024131534.GD11606@thunk.org>
Message-ID: <87o9bi6632.fsf@notabene.neil.brown.name>
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

On Wed, Oct 24 2018, Theodore Y. Ts'o wrote:

> On Wed, Oct 24, 2018 at 12:47:57PM +1100, NeilBrown wrote:
>>=20
>> I doubt it was copied - more likely independent evolution.
>> But on reflection, I see that it is probably reasonable that it
>> shouldn't be used this way - or at all in this context.
>> I'll try to understand what the issues really are and see if I can
>> find a solution that doesn't depend on this interface.
>> Thanks for your help.
>
> At least for ext4, the primary problem is that we want to use a 64-bit
> telldir/seekdir cookie if all 64-bits will make it to user space, and
> a 32-bit telldir cookie if only 32 bits will make it userspace.  This
> impacts NFS as well because if there are people who are still using
> NFSv2, which has 32-bit directory offsets, we need to constrain the
> telldir/seekdir cookies we give to NFS to be a 32 has as opposed to a
> 64-bit hash.

NFSd uses FMODE_32BITHASH or FMODE64BITHASH to allow ext4 to do the
right thing.  FMODE_32BITHASH is set for NFSv2 only.

Maybe sys_getdents needs to set FMODE_32BITHASH, and sys_getdent64 needs
to set FMODE_64BITHASH - or something like that.

For lustre it is a bit more complex.  The internal "inode number" is 128
bits and we (sort of) hash it to 32 or 64 bits.  cp_compat_stat() just
says -EOVERFLOW if we give a 64 bit number when 32 are expected, and
there is no flag to say "this is a 32-bit 'stat' request".

But I need to dig into exactly what that "sort-of" means - maybe there
is an answer in there.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvRPLEACgkQOeye3VZi
gblxig//TgmzFCedxxSaLnabEJvi6RiAJ9r+gPJWo0a5vtU42gXpFAXE1D+ub+lB
MEIDmcgHoGLc8eQrlfznoADqUBHUnuRdcqnWj1K0BBscE3PoXLMO6V9R37JVHD1h
+hAibmP5o2dzHyukCOvszC+A1YHy+Wu5BvyeAWcax20SqjFYJHno/QSInifpA7Oc
dzRimFFr5M1UG3OqaF0/y/g/36Hx3CuT1kWYfX8JHg8/bTnUp1n/kWDmtlbj63X2
PoQcFZi4B2iYg6tamslQqVsazppA+yXeNcf/HAF1mBwyIU71bXWj8Gl/UU5eW9cq
pDZMNrHmAO4h/SXJzcfyrrzo5beBe9DjXfVqhCLClCCx5WHBbkdR6wuMTAfS2LEF
faGRqiwR+kYFv1/2DD56YPfXSgV0B0qsQhd0wAY0t0O4PIQFoUeuFc4b/DjoOt8f
+yN+0rpJa+lKa2ibJ9KgOf/7K6Ir1mz2tvr3CT5nql7oKn97jd8o8HpZv1MwZuUf
miQlieFk0KU3Cl2L2RDGXdxUe1sp5P4qtXYKUgQNSf8KlAggtEyOxbykXYDZhRXj
K7DNCEkj9DbGv8N9IuhgYQlewxEHxXyQBsWtiq3RHTtXnKeeQcMnUEZxNcog2nCx
Lq6DYsf3i2wlrT8rxu+bEhjL80BhR7pev1iWRzqdYdfFJnP0M3M=
=BiUl
-----END PGP SIGNATURE-----
--=-=-=--
