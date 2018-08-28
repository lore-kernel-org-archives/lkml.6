Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6FCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA494208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA494208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeH1FUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:20:54 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33248 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeH1FUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:20:53 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fuSr3-0005np-CK; Mon, 27 Aug 2018 21:31:37 -0400
Message-ID: <7e33326ecf792c1a2297d162735b3e63ac185ad0.camel@surriel.com>
Subject: Re: [PATCH] x86/nmi: Fix some races in NMI uaccess
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Date:   Mon, 27 Aug 2018 21:31:37 -0400
In-Reply-To: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9UELuK71xfu3Xf0QI4F2"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9UELuK71xfu3Xf0QI4F2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-08-27 at 16:04 -0700, Andy Lutomirski wrote:

> +++ b/arch/x86/mm/tlb.c
> @@ -345,6 +345,9 @@ void switch_mm_irqs_off(struct mm_struct *prev,
> struct mm_struct *next,
>  		 */
>  		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH,
> TLB_FLUSH_ALL);
>  	} else {
> +		/* Let NMI code know that CR3 may not match
> expectations. */

I don't get it. This is in the "ASID is up to date, do not
need a TLB flush" path.

In what case do we have a TLB that is fully up to date, but
a CR3 that does not match expectations?

Doesn't the CR3 check in nmi_uaccess_ok already catch the
window of time where the CR3 has already been switched over
to that of the next task?

What is special about this path wrt nmi_uaccess_ok that is
not also true for the need_flush branch right above it?

What am I missing?

> +		this_cpu_write(cpu_tlbstate.loaded_mm, NULL);
> +
>  		/* The new ASID is already up to date. */
>  		load_new_mm_cr3(next->pgd, new_asid, false);


=20
--=20
All Rights Reversed.

--=-9UELuK71xfu3Xf0QI4F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluEpfkACgkQznnekoTE
3oN22wgAudd3hosaK2rgt1mIpCGDSRW6HNqDazJNMFMf7yPz+Z/WPHyd4l6oQ9F0
eXkijepvnSJVFmSGD3VW01iJ0qrZx9+UcG5JTAfQvkN06/mc7bGgDOoLEiNx7irC
BqDGALQpzYMYqCZFeB0gVLoCWQW3+mzNOH4b0fzEeajIxjXK+PV/ruETn6RAstPO
YySwXplu1tVCLJcly+1kW4qMFmemdcdhia9b7KWLvfwZsiXXjPJMNhIg6KV4KmVC
DDL7uBA1O2lIBOFbojQ2QceptKwRUWy+YX8Eh9OwoRTiTapVKOcBuZfYmkJlweVv
JgTdLzGKl5wh8DQPcwyJR7WJY0wxew==
=wzSA
-----END PGP SIGNATURE-----

--=-9UELuK71xfu3Xf0QI4F2--

