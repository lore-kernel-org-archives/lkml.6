Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C42C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791C920869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLcPuPFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeL2Wd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:33:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40480 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeL2Wd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:33:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so11871987pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 14:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gpgQIU5D+OIQK/a9foK0Lb5am6Xc0nLHPXlA0S4mQgo=;
        b=cLcPuPFc/6TxZgJQ+9oqaOJmItP7PrpX+dnUh7/Snt8EBJOPQJg4vip2mrZg07iZVD
         +NIBlNGvZJxjHqGXCSG/QXYOn357AbIrqvGqqORHkLWphzINuN2SZlpQagihNl9tWMV0
         fJcI4vY5tV8T1sHKu1/qs7K63zTwHQhBA8L7hlrGE2rswUqg3cEWoJmWusew0jh+HdcI
         j8f3Dxm0fDLjxm5W8vpKbKp73VCvHEAbQGYXURxQamEkWToqe5wdy9f+yHN0fhRwamsy
         nws9CYggAz1J4yOs5QsDYaj/90HgUVJcJQOAiFw/6Od5QgwW0LGQw/4t9mZnIAbHGU8f
         RoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gpgQIU5D+OIQK/a9foK0Lb5am6Xc0nLHPXlA0S4mQgo=;
        b=Jz8pB3OrYaHdK1Zcg+iawCdGLRMy7Lmwv1Gw8a1dyFA+hjfP1YKyRYj6VcGnhx90Yx
         mNWa133eaF5PzCCJUYqYIWjCmdNOtGjVSc8VwF8SCAHYNpXgIwJMkR5kDFGFxwWYpG30
         DfR2dX5A3lahUTlxcr+NK2bCG3sajHq0CGXpkgJnx8iu+SwLr8GqwQoFwMldfUGYYwMi
         Hdr4/POb6jbwsqPZ6/q0X9pFsf/gouWjIA31Ke3p/+jLFZyiIuwcoGyV3WCSWyoM6DBX
         8ZGY3/V3P/f6CBHRwjy0/G9UWX7pWMD6qToDtFNeNWA2T8++Ln6Hboxh0Fa9XoahnqpS
         1itg==
X-Gm-Message-State: AJcUukcc95k6anrONDfq90UM9XVd8167GImmwpnMDF8pYBmLRfhOHeOk
        eKmD0sUDnFaru2ph5vuOWxk5OvNWW7g=
X-Google-Smtp-Source: ALg8bN444ucKq2RLAA/igXW/Kf7O9/a2z1zfFM0C+UA0Vkdn5SbaX12h7MnwPe98MyqhRhqVBtukOQ==
X-Received: by 2002:a63:c24c:: with SMTP id l12mr2901523pgg.146.1546122806861;
        Sat, 29 Dec 2018 14:33:26 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id c9sm72111923pfc.92.2018.12.29.14.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 14:33:26 -0800 (PST)
Date:   Sat, 29 Dec 2018 12:33:24 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH 3/4] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Message-ID: <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Willy Tarreau <w@1wt.eu>, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-4-w@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g4fwmgl6g5tu4vyb"
Content-Disposition: inline
In-Reply-To: <20181229180218.15798-4-w@1wt.eu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g4fwmgl6g5tu4vyb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 29, 2018 at 07:02:18PM +0100, Willy Tarreau wrote:
> + *   - the lower level is the arch-specific syscall() definition, consis=
ting in
> + *     assembly code in compound expressions. These are called my_syscal=
l0() to
> + *     my_syscall6() depending on the number of arguments. The MIPS
> + *     implementation is limited to 5 arguments. All input arguments are=
 cast
> + *     to a long stored in a register. These expressions always return t=
he
> + *     syscall's return value as a signed long value which is often eith=
er a
> + *     pointer or the negated errno value.
> + *
> + *   - the second level is mostly architecture-independent. It is made of
> + *     static functions called sys_<name>() which rely on my_syscallN()
> + *     depending on the syscall definition. These functions are responsi=
ble
> + *     for exposing the appropriate types for the syscall arguments (int,
> + *     pointers, etc) and for setting the appropriate return type (often=
 int).
> + *     A few of them are architecture-specific because the syscalls are =
not all
> + *     mapped exactly the same among architectures. For example, some ar=
chs do
> + *     not implement select() and need pselect6() instead, so the sys_se=
lect()
> + *     function will have to abstract this.
> + *
> + *   - the third level is the libc call definition. It exposes the lower=
 raw
> + *     sys_<name>() calls in a way that looks like what a libc usually d=
oes,
> + *     takes care of specific input values, and of setting errno upon er=
ror.
> + *     There can be minor variations compared to standard libc calls. For
> + *     example the open() call always takes 3 args here.

Shouldn't these sentences begin with a capitalized "The" for
consistency?

>  /* some archs (at least aarch64) don't expose the regular syscalls anymo=
re by
>   * default, either because they have an "_at" replacement, or because th=
ere are
>   * more modern alternatives. For now we'd rather still use them.

Also here. Shouldn't this begin with a capitalized "Some"?

--=20
Cheers,
Joey Pabalinas

--g4fwmgl6g5tu4vyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwn9jMACgkQ2rGdfm9D
tVIEFRAAmZU3CLtJRYeYkNoMBa0M28KE6K/cHn1CxONj5MnaYOJDBj8r6yfLBQxB
xbFh8Qn/cQRe2xIojA78ilZFnFKDP3HSd/4Pyy6RzALwdZ1AnxNVvo2InzIvuxXS
/MpJb1g2IGEAdVAMsvoGadbQY6Q64aHB8vJ87MRSh3DqDPu0qiNOXmkCWY0B1nGp
DxugTNz3RLkAN6R7qdh+jl8aFd9wmkW9xM609igStd8rnnO91o+wVc2+GiYdaRjt
k8k2oNfH+E2NOJw5jsJw1dgptM2ub4Pb5aYHsHe8x6KK5u3IZizA2nLSDEjWggQm
Yg2TsjE6ZUEjDJWR+ZfnD968nkV2rW9e0x/6+80CKELJFQvLooeFQwFI6e2NyyeC
MglPa+XAjlFcfVME8h04/UKGhKpDV6+nlAI1ZlUjUqBXc1GNeCXfAym5ggfuIcgr
Y6Os2yQHjAbdkQDwTMCRIywSx0wwqPkHFAzwJ55IoOlkD6kxsIheCeG3/S+/jkJ4
KOSLRKrMYExqsSK2nRBsTYUjNeGdtRcrVqHXlxj4ZnKvO2+eDiq3tqSl+wgSGrFW
/5KFfGgjoOGWVS1eG1Fx1+z/fqcaNdtf4RImi24BC4gc54qbazKlir3SFL9lxMHV
qrREv99+imyVua3mpsTeXf0y1+GJSz7mBPCxApjN1uDeXTPlLzM=
=UXKw
-----END PGP SIGNATURE-----

--g4fwmgl6g5tu4vyb--
