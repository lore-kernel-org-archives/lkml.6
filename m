Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF42FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C85E25792
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayRb6gMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C85E25792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755478AbeFYQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755335AbeFYQkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:40:02 -0400
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com [209.85.128.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8F625792
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529944801;
        bh=XA+eIg1NmyZYTZQnEPJ7kb1o7KlTdRRU0dIcsTKQLTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ayRb6gMgA5sN4t6qD5BJ6ILeuR/pNdvv6IXqBKYzGh1mdxQqhaPEu+ClGLVuX7Wzj
         Wn2v9uxiyNTJRI6o6XXXkOsHZKVNE+5tx3q0LCSBTlmwXpjBCoThw575duK8VFApFe
         QQlPbLb5xe5zAs1DWA/kJwOP5+xdMjLoFzDh+3QM=
Received: by mail-wr0-f175.google.com with SMTP id w10-v6so14353800wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:40:01 -0700 (PDT)
X-Gm-Message-State: APt69E2/d3i/WOSlPUIoqtKR/kRtiVKLUtJCd9OJSHgibl5gIms/Mcqc
        Lt5nQEx1n/wU67GCtbF0YXQ4F0jjarMixda7ljhD6Q==
X-Google-Smtp-Source: AAOMgpeAvvbaMGIHFrPQtxNVYbKg4BIlWct4HPADd2el8HQpPFAyOOQE5aGbpb93klewnCemjyXKjHFTg0wv648yVqg=
X-Received: by 2002:adf:e0c5:: with SMTP id e5-v6mr6789719wri.199.1529944799802;
 Mon, 25 Jun 2018 09:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180625155750.GA14306@jordon-HP-15-Notebook-PC>
 <CALCETrU3dS5t714BYqkxEYgkbJaESK6NP1Rsn3xq3En38yjJzQ@mail.gmail.com> <CAFqt6zZHo3frivz0Qjj7v2ifF-p+6530Bb8HZqO3iPrL9kemuA@mail.gmail.com>
In-Reply-To: <CAFqt6zZHo3frivz0Qjj7v2ifF-p+6530Bb8HZqO3iPrL9kemuA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 09:39:47 -0700
X-Gmail-Original-Message-ID: <CALCETrUTeVfj7n29AHK6Pa=caqmZOwqtZrBNawXKa_GBvCw8XQ@mail.gmail.com>
Message-ID: <CALCETrUTeVfj7n29AHK6Pa=caqmZOwqtZrBNawXKa_GBvCw8XQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: Change return type to vm_fault_t for fault handlers
To:     jrdr.linux@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 9:15 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Mon, Jun 25, 2018 at 9:41 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Mon, Jun 25, 2018 at 8:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>
> >> Use new return type vm_fault_t for fault handler. For
> >> now, this is just documenting that the function returns
> >> a VM_FAULT value rather than an errno. Once all instances
> >> are converted, vm_fault_t will become a distinct type.
> >
> > Whoa there..  Your commit message makes it sound like you're just
> > changing the return type, but:
> >
> >>                 if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
> >> -                       ret = vm_insert_pfn(vma, vmf->address,
> >> +                       ret = vmf_insert_pfn(vma, vmf->address,
> >>                                             vmalloc_to_pfn(tsc_pg));
> >>         }
> >>
> >> -       if (ret == 0 || ret == -EBUSY)
> >> -               return VM_FAULT_NOPAGE;
> >> -
> >> -       return VM_FAULT_SIGBUS;
> >> +       return ret;
> >
> > You're refactoring the code, too.
> >
> > Please fix your changelog.
>
>
> I have mentioned it.
>
> ********************
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>
> Previously vm_insert_pfn() returns err which has to
> mapped into VM_FAULT_* type. The new function
> vmf_insert_pfn() will replace this inefficiency by
> returning VM_FAULT_* type.
> *********************

The second line of your changelog says "For now, this is just
documenting...".  Please don't make future readers read all the way
through the whole changelog and try to reconcile conflicting sentences
to figure out what the patch does.

I read your changelog, then I read through the diff to make sure that
you were really just changing the return type (as your changelog
seemed to claim), and I decided that your patch was incorrect.  As the
maintainer of this code, this means that you've made my work harder
than it should be, so NAK.  Please improve your changelog and
resubmit.

--Andy
