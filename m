Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02F6C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12C421470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8/zwhAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12C421470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJLERC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeJLERB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:17:01 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC8C21476
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539290883;
        bh=qWbwIsw8rhTxjTA36p8BXwsikQcZ2ZVCAByAjj/9hb0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T8/zwhAiBLVt6dC+y4qmNuMP3Yq15LzSXbNpgdpoCxhz2428G2ej+aHn3bELoVMbq
         TeYOKTTqI6SriDJseZYV5ooSBJrKWb2lVNTEoU3I9mnpTFhlH5Nw8UyBep5Nb3zi/1
         xtUgVKYkQOCo8UAFl984l++rAmA0z/kXxPubMoY4=
Received: by mail-wr1-f53.google.com with SMTP id n11-v6so11051594wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:48:03 -0700 (PDT)
X-Gm-Message-State: ABuFfogSFU1M/LMfXTVWaiXL7/+A6jOLkkfWCO3JRE0AronqVXBrTkW5
        qNao0lz9un5z2WGlFiDdwliAC6vhzviMiZHUXRJNEw==
X-Google-Smtp-Source: ACcGV61UcbmqNO9eKNA2XnUFYYuXpxZ6ymZXMN2cSSjpY7hT2OUBM5VRWmAxVZrfNqdJLTABewsesvN+7Jgs9D/ehso=
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr3065017wrb.283.1539290881656;
 Thu, 11 Oct 2018 13:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com> <20181011212504.012c3ece@alans-desktop>
In-Reply-To: <20181011212504.012c3ece@alans-desktop>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Oct 2018 13:47:49 -0700
X-Gmail-Original-Message-ID: <CALCETrW29qzigJY99GSFg4EVabbh6VnUmfPvtwO+BtPKfKWj-Q@mail.gmail.com>
Message-ID: <CALCETrW29qzigJY99GSFg4EVabbh6VnUmfPvtwO+BtPKfKWj-Q@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 1:25 PM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> > Ugh.
> >
> > What exactly is this trying to protect against?  And how many cycles
>
> Most attacks by speculation rely upon leaving footprints in the L1 cache.
> They also almost inevitably resolve non speculatively to errors. If you
> look through all the 'yet another potential spectre case' patches people
> have found they would have been rendered close to useless by this change.

Can you give an example?  AFAIK the interesting Meltdown-like attacks
are unaffected because Meltdown doesn't actually need the target data
to be in L1D.  And most of the Spectre-style attacks would have been
blocked by doing LFENCE on the error cases (and somehow making sure
that the CPU doesn't speculate around the LFENCE without noticing it).
But this patch is doing an L1D flush, which, as far as I've heard,
isn't actually relevant.

>
> It's a way to deal with the ones we don't know about, all the ones theion
> tools won't find and it has pretty much zero cost
>
> (If you are bored strace an entire days desktop session, bang it through
> a script or two to extract the number of triggerig error returns and do
> the maths...)
>
> > should we expect L1D_FLUSH to take?
>
> More to the point you pretty much never trigger it. Errors are not the
> normal path in real code. The original version of this code emptied the
> L1 the hard way - and even then it was in the noise for real workloads we
> tried.
>
> You can argue that the other thread could be some evil task that
> deliberately triggers flushes, but it can already thrash the L1 on
> processors that share L1 between threads using perfectly normal memory
> instructions.
>

That's not what I meant.  I meant that, if an attacker can run code on
*both* logical threads on the same CPU, then they can run their attack
code on the other logical thread before the L1D_FLUSH command takes
effect.

I care about the performance of single-threaded workloads, though.
How slow is this thing?  No one cares about syscall performance on
regular desktop sessions except for gaming.   But people do care about
syscall performance on all kinds of crazy server, database, etc
workloads.  And compilation.  And HPC stuff, although that mostly
doesn't involve syscalls.  So: benchmarks, please.  And estimated
cycle counts, please, on at least a couple of relevant CPU
generations.

On Meltdown-affected CPUs, we're doing a CR3 write anyway, which is
fully serializing, so it's slow.  But AFAIK that *already* blocks most
of these attacks except L1TF, and L1TF has (hopefully!) been fixed
anyway on Linux.
