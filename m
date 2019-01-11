Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EA621783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547240805;
	bh=6jQeBnq89TcqELbCmxN50WFICAEpyjYKrULbIaxa+Ck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A4DvuzEqN5nHvuQrWmRPRGyBZxeen7CPB1SNhhWIWFPU3krOR3kOenxpSwvZrUz9t
	 nN/NqMbjYDoibE0/UQMHivfHpBOeSXs7tiShOUBQYMXa7ItN1LIYQvKCsLJAQ3Msqu
	 AwZhO5UMJtJTAlPEycnnre9e+jJL7V4fIqKL8VZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfAKVGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfAKVGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:06:44 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84986218AE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547240802;
        bh=6jQeBnq89TcqELbCmxN50WFICAEpyjYKrULbIaxa+Ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iS/86JjLz3y3VpdiWB//3a4pu7zv+lE1+4CjwxgcFmTcYjtTN9DZqc3Y9whDvHuVi
         /vOjeFe5NY12IngK0s7qo3LyG5+/TgKVfVxMpzdXsu6KRMUTUQDT4VlkINWets9dnF
         3K2zM24EfGS05oZd9UlKU2V79qZPn6J9PnL7GlOE=
Received: by mail-wr1-f46.google.com with SMTP id j2so16696147wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:06:42 -0800 (PST)
X-Gm-Message-State: AJcUukf7dJW7pZlk/aSlngYBHcY0ou5AnsMRCpddr9FAYRG7N/cQi3xi
        1rBf4UWAFYxgHbWIFQPpVgaUBHRrrVxEPkClHpYSNQ==
X-Google-Smtp-Source: ALg8bN6qcsUhw9C1G3ByJW8OnNA//XIcthkGNXCt5dnZrkOg0Ps3i43hN9m4OCA1rVat6MCucjfA/S/QQ226Uw50yNY=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr14599888wrm.309.1547240799072;
 Fri, 11 Jan 2019 13:06:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547153058.git.khalid.aziz@oracle.com> <31fe7522-0a59-94c8-663e-049e9ad2bff6@intel.com>
 <7e3b2c4b-51ff-2027-3a53-8c798c2ca588@oracle.com> <8ffc77a9-6eae-7287-0ea3-56bfb61758cd@intel.com>
In-Reply-To: <8ffc77a9-6eae-7287-0ea3-56bfb61758cd@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 11 Jan 2019 13:06:27 -0800
X-Gmail-Original-Message-ID: <CALCETrXqJJq1LMxfBA=LK=PYc5Q7hgeDQGap38h1AUAQuF2VHA@mail.gmail.com>
Message-ID: <CALCETrXqJJq1LMxfBA=LK=PYc5Q7hgeDQGap38h1AUAQuF2VHA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/16] Add support for eXclusive Page Frame Ownership
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liran.alon@oracle.com, Kees Cook <keescook@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        kanth.ghatraju@oracle.com,
        Joao Martins <joao.m.martins@oracle.com>,
        Jim Mattson <jmattson@google.com>, pradeep.vincent@oracle.com,
        John Haxby <john.haxby@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, steven.sistare@oracle.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:42 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> >> The second process could easily have the page's old TLB entry.  It could
> >> abuse that entry as long as that CPU doesn't context switch
> >> (switch_mm_irqs_off()) or otherwise flush the TLB entry.
> >
> > That is an interesting scenario. Working through this scenario, physmap
> > TLB entry for a page is flushed on the local processor when the page is
> > allocated to userspace, in xpfo_alloc_pages(). When the userspace passes
> > page back into kernel, that page is mapped into kernel space using a va
> > from kmap pool in xpfo_kmap() which can be different for each new
> > mapping of the same page. The physical page is unmapped from kernel on
> > the way back from kernel to userspace by xpfo_kunmap(). So two processes
> > on different CPUs sharing same physical page might not be seeing the
> > same virtual address for that page while they are in the kernel, as long
> > as it is an address from kmap pool. ret2dir attack relies upon being
> > able to craft a predictable virtual address in the kernel physmap for a
> > physical page and redirect execution to that address. Does that sound right?
>
> All processes share one set of kernel page tables.  Or, did your patches
> change that somehow that I missed?
>
> Since they share the page tables, they implicitly share kmap*()
> mappings.  kmap_atomic() is not *used* by more than one CPU, but the
> mapping is accessible and at least exists for all processors.
>
> I'm basically assuming that any entry mapped in a shared page table is
> exploitable on any CPU regardless of where we logically *want* it to be
> used.
>
>

We can, very easily, have kernel mappings that are private to a given
mm.  Maybe this is useful here.
