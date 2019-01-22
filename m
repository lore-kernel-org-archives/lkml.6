Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4A4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E2720854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="sgVLnmZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfAVOe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:34:27 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:56711 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfAVOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548167666; x=1579703666;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=YkGDjKCwpTkQ3ciXGSJgFWNPj3TDMt7uYsw3MtLoxL4=;
  b=sgVLnmZPj1S14xIOx61cnfvS8k0IoDWnl3TkIZK4kvIE1pLu3cDRQYLc
   gntkCjn0EfWGlWuX1drDYUeQiB3ki5nQnewXcskxwEPxIFWEsZ5OqpvEr
   R4UOF6PUAy6hxCalQjljVp4awCS0ksVbmCpbfc/vtlTSCFBDqKNa/8q0Y
   M=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="755360991"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 22 Jan 2019 14:34:23 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id D3944A1F8C;
        Tue, 22 Jan 2019 14:34:20 +0000 (UTC)
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC] x86/speculation: add L1 Terminal Fault / Foreshadow demo
References: <1548076208-6442-1-git-send-email-jsteckli@amazon.de>
        <20190121183618.GP6118@tassilo.jf.intel.com>
        <20190121191541.GB4026@kroah.com>
        <CAGXu5j+h9RKAND8+SJR6P6CQY_YO3ezjsnfuzLGsQbY=O4XCuw@mail.gmail.com>
Date:   Tue, 22 Jan 2019 16:34:18 +0200
In-Reply-To: <CAGXu5j+h9RKAND8+SJR6P6CQY_YO3ezjsnfuzLGsQbY=O4XCuw@mail.gmail.com>
        (Kees Cook's message of "Tue, 22 Jan 2019 09:42:13 +1300")
Message-ID: <ciirm8va2gg3rp.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Jan 22, 2019 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Jan 21, 2019 at 10:36:18AM -0800, Andi Kleen wrote:
>> > > +   /* Check the start address: needs to be page-aligned.. */
>> > > +-  if (start & ~PAGE_MASK)
>> > > ++  if (start & ~PAGE_MASK) {
>> > > ++
>> > > ++          /*
>> > > ++           * XXX Hack
>> > > ++           *
>> > > ++           * We re-use this error case to show case a cache load gadget:
>> > > ++           * There is a mispredicted branch, which leads to prefetching
>> > > ++           * the cache with attacker controlled data.
>> > > ++           */
>> > > ++          asm volatile (
>> >
>> > Obviously that can never be added to a standard kernel.
>>
>> No, that's why it is a patch, right?

Yes, this is obviously only for experimenting.

>> People want to test things, it's nice to have a way to easily do
>> this.
>
> What about adding something like it to drivers/misc/lkdtm/ instead?
>
> It's not a "production" module, but it regularly get built for selftest builds.

For people who want to test L1TF hardening patches in the kernel (e.g.
XPFO) it's certainly nice to not have to manually patch the kernel to add
an easy to reach cache load gadget. It's also nice if you quickly want
to test whether a random Intel CPU has this vulnerability.

The cache load gadget as it is right now is mostly to show a reasonably
realistic scenario of speculatively executed code fetching memory into
the L1 cache. I didn't want to make this a completely crafted example
where I just literally execute a prefetch instruction.

But what I could do is add a bit of code in lkdtm that exposes a debugfs
file with this functionality.

Thoughts?

Julian
