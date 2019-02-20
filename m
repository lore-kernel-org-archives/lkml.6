Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FD3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F302086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550675343;
	bh=gBoK0yhh7Wt5HHwqdk3VA5wjf9d2v3L08N4F+WTt0fM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rDPljKljWBzvB25L7szndyPb7h7SdXYzw/Huj8/ZcM8lrKT1EIsNGDcrgG/0d8mUc
	 /KB3XOmuioLra2PNQTEJiVPUwgGaDaZU7obbgdH8kCedymNjF0tZvrNiUr/77Grq/i
	 1N/JQ3HmhR0k0RxLfX6JbciRSdAmYYWQ4oTUP/nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfBTPJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:09:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37685 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBTPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:09:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so20123337edv.4;
        Wed, 20 Feb 2019 07:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7KxhyUidV5tFwycItsdaLf++bwcsQHmwpqW7sMcBjk=;
        b=Kt8aZ/xnRX1sQF/lAWbgUM2H0C09Y/nDY3H1bo3QZOe+lRC/cgL7FoE6vTFsjX1Ew9
         bPh49rI9PZyl1KIXVZVgiJNPa8B3RWfH3VHjSOKJX9DCp+vnrDnBEr+x3PnchBvDijbg
         PEt4DI2L/0RryPYdcQCNAbbZahhvTDRLo8XDEO9tNPr0T9wBLD7iMXN/KV2e4prsUhVF
         Nae60jBN4ckwVDqoxzk5B7fYgt2wKPn3L7omfnyW/5PeseKvkCGP6eZAbcRtbcN7M3b8
         +QSrCFg0lMwqHLDSeH/5mWHl0Y3WfNvZ2XsJiiCSSkUfGeMTi0Hb1+gjo8pN237RP2Pv
         57dA==
X-Gm-Message-State: AHQUAuaAMzDL6eRR7btb71UfgdcOJC9atX0xQgbRKWqI8ocjnHFDpLLK
        KHfl2Hbc4n3JLsZENe9XG+zSAK9jgQXPyOdk3+0=
X-Google-Smtp-Source: AHgI3IawBlkGZU94SdN7Q51y1TSa3e4cxsbRcIZtjcWBOf+C2HezV2da9dKf4laiKzkYeGtv+rBPmFRg5NFRb3dc8r8=
X-Received: by 2002:a17:906:2a8b:: with SMTP id l11mr23954673eje.196.1550675339791;
 Wed, 20 Feb 2019 07:08:59 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com> <20190220105542.GB17969@hirez.programming.kicks-ass.net>
In-Reply-To: <20190220105542.GB17969@hirez.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 20 Feb 2019 10:08:48 -0500
Message-ID: <CAJvTdK=+Lw1_WFE4_aGqxtRPK_JafmmzcmGSqScMOB4EK-xH5g@mail.gmail.com>
Subject: Re: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments, Peter. I'll update the patch to address the
syntax points.  (Maybe checkpatch.pl should be updated to reflect your
preferences?).

About macros vs C.  I agree with your preference.
I used macros to be consistent with the existing code, and to be as
backport friendly as possible.
(a number of distros need to pull these patches into their supported kernels)
Sure, I'm willing to write in a cosmetic-only patch, after the
functional changes are upstream.

> It would've been nice to have the CPUID instruction 1F leaf reference
> 3B-3.9 in the SDM, and maybe mention this here too.

I didn't mention SDM sections because they change -- leaving stale
pointers in our commit messages.  The SDM is re-published 4 times per
year.

> Also, figure 8-6 uses Q,R ID, without prior mention.

Yeah, the tech-writer took my real example and turned it into a
generic example.  Probably a good idea, even if not gracefully
executed.  The point of undefined "Q" and "R" are that a new level can
be invented at any time in the future, and the existing code that
doesn't know about future levels should still function properly.

The back-story is that Leaf-B was supposed to work this way, but the
original SDM code example was hard-coded to assume 3-levels.  Plenty
of software was hard-coded and would have broken if we had actually
added new levels to Leaf-B.  And so Leaf-B had to be "forked" into
Leaf-1F, with the implicit contract that only new code that can
function properly in the face of unknown levels parses leaf-1F.

Yes, the parsing routine in the Linux Kernel will work fine in the
face of future unknown levels.  Some utilities (such as cpuid), would
have actually crashed if we added levels to Leaf-B.

> You haven't explained, and I can't readily find it in the SDM either,
> how these topology bits relate to caches and interconnects.
>
> Will these die thingies share LLC, or will LLC be per die. Will NUMA
> span dies or not.

Excellent question.
Cache enumeration in Leaf-4 is totally unchanged.
ACPI NUMA tables are totally unchanged.

From a scheduler point of view, imagine that a SKX system with 4 die
in 4 packages
was mechanically re-designed so that those 4 die resided in 2
double-sized packages.

They may have tweaked the links between the die, but logically it is
identical and compatible,
and the legacy kernel will function properly.

So the effect of Leaf B,1F is that it defines the scope of MSRs.
eg. what processors does a die-scope MSR cover.
That is why the rest of the patch is about sysfs topology, and about
package MSR scope.

Yes, there will be more exotic MSR situations in future products --
the first ones are pretty simple --
something  called a package-scope-MSR  in the SDM today becomes a
die-scope-MSR in this generation
on a multi-die/package system.

It also reflects how many packages appear in sysfs, and this can
effect licensing of some kinds of software.

thanks,
Len Brown, Intel Open Source Technology Center
