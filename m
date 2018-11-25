Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556BDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F18720865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F18720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeKYVKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:10:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeKYVKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:10:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB8585AFE9;
        Sun, 25 Nov 2018 10:19:34 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D4B917001;
        Sun, 25 Nov 2018 10:19:33 +0000 (UTC)
Date:   Sun, 25 Nov 2018 18:19:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181125101930.GA1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CACi5LpPx1bmH6duAbWFNMVStg-2GR=dSVuKrEfVCko8HzmqF_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpPx1bmH6duAbWFNMVStg-2GR=dSVuKrEfVCko8HzmqF_A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 25 Nov 2018 10:19:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/18 at 01:36am, Bhupesh Sharma wrote:
> Hi Boris,
> 
> Thanks for your review. Please see my replies inline:
> 
> On Wed, Nov 21, 2018 at 5:10 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > + Kees.
> >
> > On Fri, Nov 16, 2018 at 03:17:49AM +0530, Bhupesh Sharma wrote:
> > > x86_64 kernel uses 'page_offset_base' variable to point to the
> > > start of direct mapping of all physical memory. This variable
> > > is also updated for KASLR boot cases, so this can be exported
> > > via vmcoreinfo as a standard ABI between kernel and user-space,
> > > to allow user-space utilities to use the same for calculating
> > > the start of direct mapping of all physical memory.
> > >
> > > 'arch/x86/kernel/head64.c' sets the same as:
> > >    unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
> > >
> > > and also uses the same to indicate the base of KASLR regions on x86_64:
> > >    static __initdata struct kaslr_memory_region {
> > >           unsigned long *base;
> > >               unsigned long size_tb;
> > >    } kaslr_regions[] = {
> > >           { &page_offset_base, 0 },
> > >    .. snip ..
> >
> > Why is that detail needed in the commit message?
> 
> This (and similar) details were requested by Baoquan during the v1
> review, that is why I added them to the v2 commit log.

Hmm, Bhupesh, this is what I requested in your v1:
lkml.kernel.org/r/20181030020752.GB11408@MiWiFi-R3L-srv

You said x86 makedumpfile is broken because KCORE_REMAP is added. I
wanted to know why it's broken. Now I think I don't need to request it
in this thread, becasue Kazu has made it clear and fixed it:
4AE2DC15AC0B8543882A74EA0D43DBEC0355DFC9@BPXM09GP.gisp.nec.co.jp

Or could you abstract the sentences in which I requested you to add
above information into patch log so that I can notice my expression
and can improve on future reviewing and communicating?

And for problem solving and describing, if things are simple, just
tell it direclty; If things are complex, try to simplify it and make it
be simply told. For this page_offset_base exporting, we can save time on
'what' and 'how' since it's very simple and very easy to see what it is
and how it's done. You just need tell WHY it's needed. BUT I saw so many
words and not easy to get why. If simplifying problems is one kind of
ability, I don't know what to say about complicating one simple problem,
another kind of ability?

I have read your patch log when you sent out v2, honestly I don't like it.
I tried to not touch this patch, hope other people can review and give
comments. This can make you know I didn't intentionally embarrass you on
patch reviewing.

Honestly, if this patch is merged, no matter v2 or your old v1,
a small record will be made. On my x1 laptop, I need scroll down FOUR
full screens till the real patch content is seen. Are those really
needed? You can check other vmcoreinfo exporting patch.

I really don't want to review people's patch if they don't welcome my
words, just I was asked to do. Hope you know I had no any offence when
I started to read your patch, just I felt not good when my head was 
scratched to bleed when read. My english is not good, I don't know how to
express euphemistically sometime, so if I say so about one thing, that is
how I think so to the thing, without any personal prejudice or attack to
person. Please forgive me if any offence felt.

Thanks
Baoquan

> Although personally I also think that such details are probably not
> needed in a commit log (may be better suited for a cover letter, which
> is maybe a overkill for this single patch).
> Will drop this from v3.

