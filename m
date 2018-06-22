Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F9FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1A924690
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1A924690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbeFVRQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:16:03 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60220 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeFVRQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:16:02 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWPfE-0001EU-Rj; Fri, 22 Jun 2018 13:16:00 -0400
Message-ID: <1529687760.7898.200.camel@surriel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, efault@gmx.de, songliubraving@fb.com,
        kernel-team@fb.com
Date:   Fri, 22 Jun 2018 13:16:00 -0400
In-Reply-To: <187ad4e2-d72b-2267-df40-dfb178ab0e47@linux.intel.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-5-riel@surriel.com>
         <187ad4e2-d72b-2267-df40-dfb178ab0e47@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+GVLtYbPYUpEmsSDSx4S"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+GVLtYbPYUpEmsSDSx4S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:05 -0700, Dave Hansen wrote:
> On 06/20/2018 12:56 PM, Rik van Riel wrote:
> > This patch deals with that issue by introducing a third TLB state,
> > TLBSTATE_FLUSH, which causes %CR3 to be reloaded at the next
> > context
> > switch.
>=20
> With PCIDs, do we need to be a bit more explicit about what kind of
> %CR3
> reload we have?  Because, with PCIDs, we do have non-TLB-flushing
> %CR3
> writes.

Probably not in this patch series, because switch_mm_irqs_off
calls choose_new_asid, which figures all of this out for us
already.

Specifically, it has this bit of code to figure out whether
we need a flush:

                *need_flush =3D
(this_cpu_read(cpu_tlbstate.ctxs[asid].tlb_gen) <
                               next_tlb_gen);

As long as we get the memory ordering right, we should be
able to rely on that to switch back from lazy to non-lazy
TLB mode.

--=20
All Rights Reversed.
--=-+GVLtYbPYUpEmsSDSx4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstLtAACgkQznnekoTE
3oN93wf+KW+bpoRkPGv3Yoe6I7v2+tr/QwCuu+74/jc54x8rDGs/E1ZO4gFZX4uQ
q/uDMwq7+JyiXPBtxPXdBAgq/An4743IPzTyrHzwwTiPI8G/A3sl6gpD0Wjm5W4x
qVvZ0I009GSI3enFk07nD8F9d6qSXdW7lQCma+cPnaEiWifmS/bHsqxsuZqriYqM
8SegQwXEiXmb0AFw7/aEnId6AnPyVfN0OUstD36N1OpEqH66rcZVLjy9IrPUrbw5
p3v8Z01w51oMaKk7DFTNcZSfSrMQwDdWhz3383klY5Ym9iF9FYu8vmt2Q6hE9Hmc
qlVowUSaPMQIFBMSyteUT3XsZ2du1A==
=ZQ7O
-----END PGP SIGNATURE-----

--=-+GVLtYbPYUpEmsSDSx4S--

