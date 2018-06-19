Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9CCC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00332075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00332075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030272AbeFSRXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:23:22 -0400
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:44948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966551AbeFSRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:23:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E93E0182CED34;
        Tue, 19 Jun 2018 17:23:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: help55_90d044ab8042a
X-Filterd-Recvd-Size: 5561
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 17:23:15 +0000 (UTC)
Message-ID: <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>, pbonzini@redhat.com
Cc:     Matthias Kaehlcke <mka@chromium.org>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 10:23:13 -0700
In-Reply-To: <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
References: <20180615174731.47588-1-mka@chromium.org>
         <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
         <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
         <20180615182945.GN88063@google.com>
         <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
         <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
         <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
         <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 10:08 -0700, Nick Desaulniers wrote:
> On Tue, Jun 19, 2018 at 8:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > On 15/06/2018 20:45, Nick Desaulniers wrote:
> > > > 
> > > > > In any case I think it it preferable to fix the code over disabling
> > > > > the warning, unless the warning is bogus or there are just too many
> > > > > occurrences.
> > > > 
> > > > Maybe.
> > > 
> > > Spurious warning today, actual bug tomorrow?  I prefer to not to
> > > disable warnings wholesale.  They don't need to find actual bugs to be
> > > useful.  Flagging code that can be further specified does not hurt.
> > > Part of the effort to compile the kernel with different compilers is
> > > to add warning coverage, not remove it.  That said, there may be
> > > warnings that are never useful (or at least due to some invariant that
> > > only affects the kernel).  I cant think of any off the top of my head,
> > > but I'm also not sure this is one.
> > 
> > This one really makes the code uglier though, so I'm not really inclined
> > to applying the patch.
> 
> Note that of the three variables (w, u, x), only u is used later on.
> What about declaring them as negated with the cast, that way there's
> no cast in a ternary?

It'd be simpler to cast in the BYTE_MASK macro itself

Ex:
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index d594690d8b95..53673ad4b295 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4261,8 +4261,9 @@ static void update_permission_bitmask(struct
> kvm_vcpu *vcpu,
>  {
>         unsigned byte;
> 
> -       const u8 x = BYTE_MASK(ACC_EXEC_MASK);
> -       const u8 w = BYTE_MASK(ACC_WRITE_MASK);
> +       const u8 x_not = (u8)~BYTE_MASK(ACC_EXEC_MASK);
> +       const u8 w_not = (u8)~BYTE_MASK(ACC_WRITE_MASK);
> +       const u8 u_not = (u8)~BYTE_MASK(ACC_USER_MASK);
>         const u8 u = BYTE_MASK(ACC_USER_MASK);
> 
> 
>         bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
> @@ -4278,11 +4279,11 @@ static void update_permission_bitmask(struct
> kvm_vcpu *vcpu,
>                  */
> 
>                 /* Faults from writes to non-writable pages */
> -               u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> +               u8 wf = (pfec & PFERR_WRITE_MASK) ? w_not : 0;
>                 /* Faults from user mode accesses to supervisor pages */
> -               u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
> +               u8 uf = (pfec & PFERR_USER_MASK) ? u_not : 0;
>                 /* Faults from fetches of non-executable pages*/
> -               u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
> +               u8 ff = (pfec & PFERR_FETCH_MASK) ? x_not : 0;
>                 /* Faults from kernel mode fetches of user pages */
>                 u8 smepf = 0;
>                 /* Faults from kernel mode accesses of user pages */
> 
> 
> Maybe you have a better naming scheme than *_not ? What do you think?

It'd be nicer to cast in the BYTE_MASK macro
and using "unsigned byte;" is misleading at best.

---
 arch/x86/kvm/mmu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..201711aa99b9 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4246,15 +4246,14 @@ reset_ept_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 				    boot_cpu_data.x86_phys_bits, execonly);
 }
 
-#define BYTE_MASK(access) \
-	((1 & (access) ? 2 : 0) | \
-	 (2 & (access) ? 4 : 0) | \
-	 (3 & (access) ? 8 : 0) | \
-	 (4 & (access) ? 16 : 0) | \
-	 (5 & (access) ? 32 : 0) | \
-	 (6 & (access) ? 64 : 0) | \
-	 (7 & (access) ? 128 : 0))
-
+#define BYTE_MASK(access)				\
+	((u8)(((access) & 1 ?   2 : 0) |		\
+	      ((access) & 2 ?   4 : 0) |		\
+	      ((access) & 3 ?   8 : 0) |		\
+	      ((access) & 4 ?  16 : 0) |		\
+	      ((access) & 5 ?  32 : 0) |		\
+	      ((access) & 6 ?  64 : 0) |		\
+	      ((access) & 7 ? 128 : 0)))
 
 static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu, bool ept)

