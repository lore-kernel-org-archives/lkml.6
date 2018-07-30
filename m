Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED540C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D66D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D66D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeG3XXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:23:25 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50464 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeG3XXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:23:25 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkFzW-0006rD-G1; Mon, 30 Jul 2018 17:46:10 -0400
Message-ID: <1532987170.28585.52.camel@surriel.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon, 30 Jul 2018 17:46:10 -0400
In-Reply-To: <CALCETrXnG9nPzJKOtd=65BWeoTs2y=mVUAEvNGmFrD8fvg-EfQ@mail.gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
         <20180729155452.37eddc11@imladris.surriel.com>
         <20180730095502.GG2494@hirez.programming.kicks-ass.net>
         <1532961011.28585.30.camel@surriel.com>
         <20180730162653.GM2494@hirez.programming.kicks-ass.net>
         <1532978146.28585.32.camel@surriel.com>
         <CALCETrXZPN6Lt55siHM__YW4jFfoy5w+Hd2aJtEi8qhsro6RMA@mail.gmail.com>
         <1532979368.28585.33.camel@surriel.com>
         <CALCETrXnG9nPzJKOtd=65BWeoTs2y=mVUAEvNGmFrD8fvg-EfQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jFEYLkuCRCWCOb7iteU5"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jFEYLkuCRCWCOb7iteU5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-30 at 12:49 -0700, Andy Lutomirski wrote:

>=20
> I think it's a big step in the right direction, but it still makes be
> nervous.  I'd be more comfortable with it if you at least had a
> functional set of patches that result in active_mm being gone,
> because
> that will mean that you actually audited the whole mess and fixed
> anything that might rely on active_mm pointing somewhere or that
> might
> be putting a value you didn't take into account into active_mm.  IOW
> I'm not totally thrilled by applying the patches as is if we're still
> a bit unsure as to what might have gotten missed.
>=20
> I don't think it's at all necessary to redo the patches.
>=20
> Does that seem reasonable?

Absolutely. I tried to keep ->active_mm very similar
to before for exactly that reason.

Lets go through all the places where it is used, in
x86 and architecture independent code. I have not
checked other architectures.

It looks like we should be able to get rid of
->active_mm at some point, but a lot of it depends
on other architecture maintainers.


arch/x86/events/core.c:
- get_segment_base: get current->active_mm->context.ldt,
  this appears to be for TIF_IA32 user programs only, so
  we should be able to use current->mm here

arch/x86/kernel/cpu/common.c:
- current task's ->active_mm assigned in two places,
  never read

arch/x86/lib/insn-eval.c:
- get_desc() gets current->active_mm->context.ldt, this
  appears to be only for user space programs

arch/x86/mm/tlb.c:
- this series adds two places where current->active_mm is
  written, it is never read

arch/x86/platform/efi/efi_64.c:
- current->active_mm is set to efi_mm for a little bit,
  with irqs disabled, and then changed back, with irqs still
  disabled; we should be able to get rid of ->active_mm here
- in the init code, ->active_mm is set to efi_mm as well,
  presumably the kernel automatically switches that back on
  the next context switch; this may be buggy, since preemption
  is enabled and a GFP_KERNEL allocation is just a few lines
  below

arch/x86/power/cpu.c:
- fix_processor_context() calls load_mm_ldt(current->active_mm);,
  we should be able to use cpu_tlbstate.loaded_mm instead

drivers/cpufreq/pmac32-cpufreq.c:
- pmu_set_cpu_speed() restores current->active_mm - don't know if
  anyone still cares about 32 bit PPC :)

drivers/firmware/efi/arm-runtime.c:
- efi_virtmap_unload switches back the pgd to current->active_mm
  from &efi_mm; that mm could be stored elsewhere if we excised
  ->active_mm everywhere

drivers/macintosh/via-pmu.c:
- same deal as pmap32-cpufreq.c above

mm/mmu_context.c:
- use_mm() tracks the ->active_mm a kernel thread is pointing to,
  but the mm is also tracked in ->mm
- unuse_mm() is the same deal as use_mm(), we should be able to
  get rid of ->active_mm if everybody stops using it, and we
  no longer refcount it anywhere

init/init_task.c:
- init_task.active_mm =3D &init_mm

fs/exec.c:
- exec_mmap() juggles both ->mm and ->active_mm, in order to
  get refcounting right; without refcounting we can lose ->active_mm


--=20
All Rights Reversed.
--=-jFEYLkuCRCWCOb7iteU5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltfhyIACgkQznnekoTE
3oMyPggAhzdVoswWzCP6ZpxFYpWaneT0VypiM9spbl87zsDnSANr5opDPBl4ZJDq
HjGLBGCKVKYFpN9pnR9iFImQllHosMKFKrEOoYueTXwjZu/hPZoyONghxWCVbgYL
QSCgpWGkrO6EPnlwKqdXuAyX7vsE4z9NmSWCltpywtJ+ZMq/yfovYByOEt9JEd8Q
XLGmlDV4I9rUFRDG5Fhfg3zNYulRkyfAVD7wCu3jyb7sKnAQ88bPXojPIBxgQI3p
8uWtl8FhO7d5U9Rc2KspW8kuto5Hzy2VzlrFiPhhG/CcpDOpTwskNqAkaSAKQ6MW
W0P0QQiVwf5a6MxcKIIrTMlvCbtpow==
=Bhiw
-----END PGP SIGNATURE-----

--=-jFEYLkuCRCWCOb7iteU5--

