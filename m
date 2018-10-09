Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C73C65BD1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D032213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D032213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJJEjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:39:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:54055 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeJJEjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:39:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 14:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,361,1534834800"; 
   d="scan'208";a="81242652"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2018 14:20:04 -0700
Message-ID: <38064485f5255aa999700d87debecbd6c7e084ba.camel@intel.com>
Subject: Re: [RFC PATCH v4 21/27] x86/cet/shstk: ELF header parsing of
 Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 09 Oct 2018 14:15:14 -0700
In-Reply-To: <20181003232736.GI32759@asgard.redhat.com>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
         <20180921150351.20898-22-yu-cheng.yu@intel.com>
         <20181003232736.GI32759@asgard.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 01:27 +0200, Eugene Syromiatnikov wrote:
> On Fri, Sep 21, 2018 at 08:03:45AM -0700, Yu-cheng Yu wrote:

[...]

> > diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> > index 0d157d2a1e2a..5b5f169c5c07 100644
> > --- a/arch/x86/include/asm/elf.h
> > +++ b/arch/x86/include/asm/elf.h
> > @@ -382,4 +382,9 @@ struct va_alignment {
> >  
> >  extern struct va_alignment va_align;
> >  extern unsigned long align_vdso_addr(unsigned long);
> > +
> > +#ifdef CONFIG_ARCH_HAS_PROGRAM_PROPERTIES
> > +extern int arch_setup_features(void *ehdr, void *phdr, struct file *file,
> > +			       bool interp);
> > +#endif
> >  #endif /* _ASM_X86_ELF_H */
> > diff --git a/arch/x86/include/uapi/asm/elf_property.h
> > b/arch/x86/include/uapi/asm/elf_property.h
> > new file mode 100644
> > index 000000000000..af361207718c
> > --- /dev/null
> > +++ b/arch/x86/include/uapi/asm/elf_property.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _UAPI_ASM_X86_ELF_PROPERTY_H
> > +#define _UAPI_ASM_X86_ELF_PROPERTY_H
> > +
> > +/*
> > + * pr_type
> > + */
> > +#define GNU_PROPERTY_X86_FEATURE_1_AND (0xc0000002)
> > +
> > +/*
> > + * Bits for GNU_PROPERTY_X86_FEATURE_1_AND
> > + */
> > +#define GNU_PROPERTY_X86_FEATURE_1_SHSTK	(0x00000002)
> 
> Hm, these defeinitions aren't much different comparing to NT_*
> definitions in include/uapi/linux/elf.h, is it expected that those
> properties have to be parsed individually for each architecture?

Yes, we have NT_GNU_PROPERTY_TYPE_0 defined in include/uapi/linux/elf.h.
GNU_PROPERTY_X86_FEATURE_1_xxxx is for X86 only.

[...]

> 
> There's a lot of similar code with bpf stackmap .build-id code (commit
> v4.17-rc1~148^2~156^2~3^2~1), it might be worthy generalising some ELF
> traversal routines, since there's general need of parsing ELF property
> segments.

Only a small similarity exists.  The routine find_note_type_0() does a lot more
validation.  It appears stack_map_get_build_id() does not need that.

Yu-cheng
