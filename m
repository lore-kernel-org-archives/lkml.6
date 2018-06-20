Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C01AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275CE20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMuJmZJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275CE20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeFTQlP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:41:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38355 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:40:58 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so74445pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsI7NwqNSiKUTxrfhLpd/56KvQVyBcKftur2ju6qaNI=;
        b=hMuJmZJ5KFvxJl10fmmmzTUO35dIoUMiX2OWzBJHjOg7dX/U4d5sb4zaZGMxf4RbGl
         ivoiYAAuRjzXrI599DqFMcJg+bxkr6amVvdPl386dzgcyAS02n22is27e8FZfwQMPK7Z
         SdSz4gxp6KBfc+ta7IbBG9GVuHoeCE2AHkRWAbvHlCCTkEZcLtnvhyGVOcn3WH9JVgOW
         oSRwjcu8cD7YU7SAhtmrzsqkhecYUYBJ84glTd2nrx3EPjASK45qWU3exlSCP/qsMxM8
         Otlt31vWbufd8I3qio6k/ukZ89hcHX0H/PQHIwkyHYJbfPtBJk7pg+pdtidiJN0qNf5O
         aeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsI7NwqNSiKUTxrfhLpd/56KvQVyBcKftur2ju6qaNI=;
        b=A+wuoWWyaBG9qoIMRu9BMgtwC7gs4c0GA9jbK/OmODpkzJwRhFcexzDgI76YG9Rc1E
         +rQXns1+iLMKdV0NC5OX6JEwDQkbetkkt0CU6DvItgQtSPVEg69pMYY/Gp74/hPHu8lS
         DAgW9YKiCanPuVwD8PUDknxoTba92MoZPNPCfJH/7koVwJvDKxCAFaH6GFjwicM70BB6
         7IA1uwbCwfWpAusW8QFrCHrxfGsL3LrQKh3cXJ3BYrywsofEJvn/FLca57A7almat6GG
         aQmG/0NzvgVjZHEOYB/zyaU41jYca4w20NPkMeMUbKvL+jB4Co3C3aXY0lyRaToYhu0Q
         o0YA==
X-Gm-Message-State: APt69E32Wc5S5ALG4bvjYgyE8ml9fd/k87lBJG3JaXFJSA+U101KYGlu
        3sXhx8d8y3OkRpi5sb392PNy8jjt9fJxYI5N1xQb6g==
X-Google-Smtp-Source: ADUXVKK/CdZxj2a2K9o5CWLoEkcyEy9w69ZcFD/Zqj/jHq4ab/yE8F2E6iKd4aV328xQx/68iVulfS4aIUh3JPsRFOo=
X-Received: by 2002:a62:1747:: with SMTP id 68-v6mr23364723pfx.69.1529512857504;
 Wed, 20 Jun 2018 09:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180613210518.113983-1-ndesaulniers@google.com>
 <20180613210518.113983-3-ndesaulniers@google.com> <b027a324-ffae-fd5e-d8a3-03934be91a2d@zytor.com>
 <CAKwvOdngs8k_T=nDKh8JYdAwwFoJRcCU0bZu0tJHQ+keZ5+RFQ@mail.gmail.com> <deb5a074-b057-9388-4ab7-42295b5bb46c@zytor.com>
In-Reply-To: <deb5a074-b057-9388-4ab7-42295b5bb46c@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jun 2018 09:40:46 -0700
Message-ID: <CAKwvOdmE-EHJY7tgzkhyQqNT3m3oWtd6iE3sWBTz19Rijzx4Ew@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
To:     hpa@zytor.com, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com,
        "H. Peter Anvin" <hpa@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 5:17 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 06/14/18 13:59, Nick Desaulniers wrote:
> > On Thu, Jun 14, 2018 at 1:48 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> On 06/13/18 14:05, Nick Desaulniers wrote:
> >>> From: "H. Peter Anvin" <hpa@linux.intel.com>
> >>>
> >>> i386 and x86-64 uses different registers for arguments; make them
> >>> available so we don't have to #ifdef in the actual code.
> >>>
> >>> Native size and specified size (q, l, w, b) versions are provided.
> >>>
> >>> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> >>> Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> >>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >>
> >> I still object to Suggested-by: here.  Sedat did a correction, which is
> >> a Reviewed-by:, but unless I'm completely out to sea, there was no
> >> suggestion on Sedat's part of this; and I had certainly not seen it when
> >> I wrote the code.
> >
> > I'm fine with changing it from a Suggested-by to a Reviewed-by.  Can
> > you do that when you apply the set, or should I send a v6?
> >
>
> I'm not handling patch mechanics for x86 at the moment.

Hi Ingo and Thomas,
Have you had a chance to review this patch series for application?

Note that Juergen (the paravirt maintainer) acked the series:
https://bugs.llvm.org/show_bug.cgi?id=37880
The only issue being swapping a Suggested-by for a Reviewed-by tag for
one commit, as above.

--
Thanks,
~Nick Desaulniers
