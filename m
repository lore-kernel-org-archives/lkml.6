Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AB8JxZozrzOQmPjIpMVYeGUfKUTmeTWKBeYrdOWbx9vI+fn/tcgJSq9/N98XW6SmKsIbsW5CLaij
ARC-Seal: i=1; a=rsa-sha256; t=1525115528; cv=none;
        d=google.com; s=arc-20160816;
        b=tWa6wYB69vyYqq5C+QtkN1ZjnF8OjACzzeVeQ++dpAEI8rQQ6ECsFFpzesDEvYCx1x
         ZoToxpQMjOfgZSsdOiXgKpYxJU/0voWz87LdrI25+apxE49SlfZ4GJhzO1qNv+lWcfuy
         ZhVFcM/z4sVoKaRWSm08gZ+e1QJ9rL3gp49VUoYBaACPUOsJivkKPn1GhrORPv1SYtoc
         gNcgxs4pcO60W2tdhYAZjGBUHXfB/8igmy39enAHk6y0NFwC7Wxk9E8Kngcg9iomNP19
         s2qKM8g97APr1Xg/yVbfLY06OZTPJK/jx0LzkGT+aTUwrK3+1ucxfBj+8YQdWwFVpPrB
         mPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=aVlEsfvNiFtMg8JnjbguDNoUYAuozjMrDJ8nI0iGA1A=;
        b=guYxbCUKW6LUIgp56UisSL1jMVDDCQT5tavasEV3/i+JT0NjNr6L9Txa5u/G9+euLD
         CnwtSqs1Vkz/AaddQ/JAqbvwe5GCGLz81iOH9mXY1QNEBg0dhUcJA6SK0xF+Y/ViMRBn
         WKV5mv4HsRKvMxPGx2JHbDqV5FKlcCfeBVIZR2J4C44oJ6+yQKKwNoemDzxDo6xGJy1v
         ii+LVBykPnYKX/hGy2K4sP6PMVUh7S2ik1t0JVIKcIPZvwuZnBv2JKWtMYbewz1MehIM
         iSFFz5+zjtC401dJuuV4JPCGsmKFbAey6xDwsRWNjslE1nzCZxJtat0/suefPRwuiSOR
         i3Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.49,348,1520895600";
   d="scan'208";a="325166180"
Date: Mon, 30 Apr 2018 21:12:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Sasha Levin <Alexander.Levin@microsoft.com>
cc: Greg KH <gregkh@linuxfoundation.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches (or: -rc cycles suck)
In-Reply-To: <20180430175829.GB1544@sasha-vm>
Message-ID: <alpine.DEB.2.20.1804302109140.2269@hadrien>
References: <20180430175829.GB1544@sasha-vm>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599194910340136485?=
X-GMAIL-MSGID: =?utf-8?q?1599199540692410603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Mon, 30 Apr 2018, Sasha Levin wrote:

> Working on AUTOSEL, it became even more obvious to me how difficult it is for a patch to get a proper review. Maintainers found it difficult to keep up with the upstream work for their subsystem, and reviewing additional -stable patches put even more load on them which some suggested would be more than what they can handle.
>
> While AUTOSEL tries to understand if a patch fixes a bug, this was a bit late: the bug was already introduced, folks already have to deal with it, and the kernel is broken. I was wondering if I can do a similar process to AUTOSEL, but teach the AI about bug-introducing patches.
>
> When someone fixes a bug, he would describe the patch differently than he would if he was writing a new feature. This lets AUTOSEL build on different commit message constructs, among various inputs, to recognize bug fixes. However, people are unaware that they introduce a bug, so the commit message for bug introducing patches is essentially the same as for commits that don't introduce a bug. This meant that I had to try and source data out of different sources.
>
> Few of the parameters I ended up using are:
>  - -next data (days spent in -next, changes in the patch between -next trees, ...)
>  - Mailing list data (was this patch ever sent to a ML? How long before it was merged? How many replies did it get? ...)
>  - Author/commiter/maintainer chain data. Just like sports, some folks are more likely to produce better results than others. This goes beyond just "skill", but also looks at things such as whether the author patches a subsystem he's "familiar with" (== subsystem where most of his patches usually go), or is he modifying a subsystem he never sent a patch for.
>  - Patch complexity metrics - various code metrics to indicate how "complex" a patch is. Think 100 lines of whitespace fixes vs 100 lines that significantly changes a subsystem.
>  - Kernel process correctness - I tried using "violations" of the kernel process (patch formatting, correctness of the mailing to lkml, etc) as an indicator of how familiar the author is with the kernel, with the presumption that folks who are newer to kernel development are more likely to introduce bugs

I'm not completely sure to understand what you are doing.  Is there also
some connection to things that are identified in some way as being bug
introducing patches?  Or are you just using these as metrics of low
quality?

I wonder how far one could get by just collecting the set of patches that
are referenced with fixes tags by stable patches, and then using machine
learning taking into account only the code to find other patches that make
similar changes.

julia

> Running an initial iteration on a set of commits made two things very obvious to me:
>
> 1. -rc releases suck. seriously suck. The quality of commits that went in -rc cycles was much worse that merge window commit:
>  - All commits had the same chance of introducing a bug whether they came in a merge window or an -rc cycle. This means that -rc commits mostly end up replacing obvious bugs with less obvious ones.
>  - While the average merge window commit changes, on average, 3x more lines than an -rc commit, the chances of a bug introduced per patch is the same, which means that bugs-per-line metric of code is much higher with -rc patches.
>  - A merge window commit spent 50% more days, on average, in -next than a -rc commit.
>  - The number of -rc commits that never saw any mailing list or has never been replied to on a mailing list was **way** higher than merge window commits.
>  - For some reason, the odds of a -rc commit to be targetted for -stable is over 20%, while for merge window commits it's about 3%. I can't quite explain why that happens, but this would suggest that -rc commits end up hurting -stable pretty badly.
>
> 2. Maintainers need to stop writing patches, commiting them, and pushing them in without reviews.
> In -rc cycles there is quite a large number of commits that were either written by maintainers, commited, and merged upstream the same day. These patches are very likely to introduce a new bug.
>
>
> I don't really have a proposal beyond "tighten up -rc cycles", but I think it's a discussion worth having. We have enough data to show what parts of kernel development work, and what parts are just hurting us.
