Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39014C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CDD20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CDD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeJEVF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:05:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34565 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:05:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id x23-v6so13903856qtr.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnhMcVTxaAJd/6pCWYaQjBEPZPbSiEhBQt0tqcSjpFk=;
        b=fogSQBl664kwxkRV9VGGeRHjObxKl5+uMDZ52br+tr+Q20zcAkIyzVwhiZZHkkeOfX
         M4PSlkVVu2U53poU2qlSE49KYXrHJO9BTYBY8UmE5xP15v12DBhS3PE8jHANNcFXJSCz
         KXTFwt6VzS/TmAt9wonVmrqPSRkeLo37mL68KzezyoWxkOAyAqVA6GqnFWapYHZw2OR4
         5dvjnISTi00JFrBWtuasBZ3d4KwgvPvYto3szekRPJV6rC1BTWfH8s0PAkNMrowaEyto
         ct/miO5YN+aKDBClQh8kiRR9jIL/NpUusY40Vb7Rw4jrGnpfggN3rRzWdfMFO6FZyCvf
         MzxA==
X-Gm-Message-State: ABuFfoi1/zrgkuilfnm7bWFZy/lFpb32ujRXN5/FDuSpviAkCSQGpfE0
        bltIWBx5qp4hA6DN606Xk8OHyDNUAlKwEdm+tIM=
X-Google-Smtp-Source: ACcGV62OFbJgpvJQAmOvFbLLCrtB4/Fv1fhrk0Umw7Xau5G6X9a2XYc8vFpjKlOhhk/QUVPvGr2pFkaSMa5dlK1GbO4=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr9390624qtf.185.1538748423732;
 Fri, 05 Oct 2018 07:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <1531906876-13451-1-git-send-email-joro@8bytes.org> <1531906876-13451-33-git-send-email-joro@8bytes.org>
In-Reply-To: <1531906876-13451-33-git-send-email-joro@8bytes.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Oct 2018 16:06:47 +0200
Message-ID: <CAK8P3a13D6v=R7GKMxf7tZo6MjaMqoRudcW=u_AGQZOTbrocWA@mail.gmail.com>
Subject: Re: [PATCH 32/39] x86/pgtable/pae: Use separate kernel PMDs for user page-table
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        dhgutteridge@sympatico.ca, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:43 AM Joerg Roedel <joro@8bytes.org> wrote:
>  arch/x86/mm/pgtable.c | 100 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 81 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index db6fb77..8e4e63d 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -182,6 +182,14 @@ static void pgd_dtor(pgd_t *pgd)
>   */
>  #define PREALLOCATED_PMDS      UNSHARED_PTRS_PER_PGD
>
> +/*
> + * We allocate separate PMDs for the kernel part of the user page-table
> + * when PTI is enabled. We need them to map the per-process LDT into the
> + * user-space page-table.
> + */
> +#define PREALLOCATED_USER_PMDS  (static_cpu_has(X86_FEATURE_PTI) ? \
> +                                       KERNEL_PGD_PTRS : 0)

>   * Xen paravirt assumes pgd table should be in one page. 64 bit kernel also
>   * assumes that pgd should be in one page.
> @@ -376,6 +431,7 @@ static inline void _pgd_free(pgd_t *pgd)
>  pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
>         pgd_t *pgd;
> +       pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
>         pmd_t *pmds[PREALLOCATED_PMDS];
>

This commit from back in July now causes a build warning after the patch
from Kees that enables -Wvla:

In file included from /git/arm-soc/include/linux/kernel.h:15,
                 from /git/arm-soc/include/asm-generic/bug.h:18,
                 from /git/arm-soc/arch/x86/include/asm/bug.h:83,
                 from /git/arm-soc/include/linux/bug.h:5,
                 from /git/arm-soc/include/linux/mmdebug.h:5,
                 from /git/arm-soc/include/linux/mm.h:9,
                 from /git/arm-soc/arch/x86/mm/pgtable.c:2:
/git/arm-soc/arch/x86/mm/pgtable.c: In function 'pgd_alloc':
/git/arm-soc/include/linux/build_bug.h:29:45: error: ISO C90 forbids
variable length array 'u_pmds' [-Werror=vla]
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                             ^
/git/arm-soc/arch/x86/include/asm/cpufeature.h:85:5: note: in
expansion of macro 'BUILD_BUG_ON_ZERO'
     BUILD_BUG_ON_ZERO(NCAPINTS != 19))
     ^~~~~~~~~~~~~~~~~
/git/arm-soc/arch/x86/include/asm/cpufeature.h:111:32: note: in
expansion of macro 'REQUIRED_MASK_BIT_SET'
  (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
                                ^~~~~~~~~~~~~~~~~~~~~
/git/arm-soc/arch/x86/include/asm/cpufeature.h:129:27: note: in
expansion of macro 'cpu_has'
 #define boot_cpu_has(bit) cpu_has(&boot_cpu_data, bit)
                           ^~~~~~~
/git/arm-soc/arch/x86/include/asm/cpufeature.h:209:3: note: in
expansion of macro 'boot_cpu_has'
   boot_cpu_has(bit) :    \
   ^~~~~~~~~~~~
/git/arm-soc/arch/x86/mm/pgtable.c:190:34: note: in expansion of macro
'static_cpu_has'
 #define PREALLOCATED_USER_PMDS  (static_cpu_has(X86_FEATURE_PTI) ? \
                                  ^~~~~~~~~~~~~~
/git/arm-soc/arch/x86/mm/pgtable.c:431:16: note: in expansion of macro
'PREALLOCATED_USER_PMDS'
  pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
                ^~~~~~~~~~~~~~~~~~~~~~

       Arnd
