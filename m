Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD8EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F0D20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K9nflufy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F0D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLCWFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:05:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33965 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeLCWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:05:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so12931620ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICGzCv10SUhPz/zyqjorDeeDkj5bTz4pBRwpMyj29eQ=;
        b=K9nflufyfVmDB2iFuf4W3n4gsm8rMSUar/zsx0upLdN/uBEvdEwTVSL3klHqPtOFGa
         akOLUCM4ZRntykg2nXAU4i5FL5bFZ5gJFAQ1lEYsQTGp77S5rLuY4lVizNc5sr7nkUfT
         Ibg1Le87qOs0BEURUkKnSO8lUyM6ECr+XzKE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICGzCv10SUhPz/zyqjorDeeDkj5bTz4pBRwpMyj29eQ=;
        b=KNBp8+f5/frlVQ4cHR7qHOGDlU+5pBiA/4pHejNhBME9267jwjhK6bpW7ZmKTncRw5
         0+HyUIU9TOyVvAg6CODDRDhnytynyfnGfNKMXkru3TF0/GLlDA6QfBF9OZAC9W0lUO81
         BjEOZ3O7bfn5+Ow39mpldnARVEkKNFsIzGFF2tshWzjxrUrm+jPQAkqBE5MQWw69GXGR
         wRbH6vTVN1N4+TPBAeRfCBOFhMp+Td5iTxicSzzv465zG2VBz0uCFxJEukEodfcC31az
         7+sjcQsfO7N4XKnemnJR1RHadP8MHQVZfcDgd/Y/TnyOtZxIGJfrb/yeb3I5O6cTUp6w
         WwHw==
X-Gm-Message-State: AA+aEWYkn0oBvV90SCYMc5sFdFCIHMzFgJXxKpPhA5fYdoMKI9HTvqF2
        lVcYMy8A6xkbFncBVeX7h3Fo3QqSwFg=
X-Google-Smtp-Source: AFSGD/VZ1KjNzV+XNPBh9OY4kt0TuOL6H/R00XuJUOkywzrRE9k+0pPhwwcJgMktf8D+0s9GoCC0Bg==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr12291498lje.78.1543874698421;
        Mon, 03 Dec 2018 14:04:58 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p10-v6sm2722448ljg.19.2018.12.03.14.04.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:04:57 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id e5-v6so12945561lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:04:56 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr11356257ljs.118.1543874696203;
 Mon, 03 Dec 2018 14:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
In-Reply-To: <20181203201214.GB3540@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 14:04:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
Message-ID: <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 12:12 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Mon, Dec 03, 2018 at 11:28:07AM -0800, Linus Torvalds wrote:
> >
> > One is the patch posted by Andrea earlier in this thread, which seems
> > to target just this known regression.
>
> For the short term the important thing is to fix the VM regression one
> way or another, I don't personally mind which way.
>
> > The other seems to be to revert commit ac5b2c1891  and instead apply
> >
> >   https://lore.kernel.org/lkml/alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com/
> >
> > which also seems to be sensible.
>
> In my earlier review of David's patch, it looked runtime equivalent to
> the __GFP_COMPACT_ONLY solution. It has the only advantage of adding a

I think there's a missing "not" in the above.

> new gfpflag until we're sure we need it but it's the worst solution
> available for the long term in my view. It'd be ok to apply it as
> stop-gap measure though.

So I have no really strong opinions either way.

I looking at the two options, I think I'd personally have a slight
preference for that patch by David, not so much because it doesn't add
a new GFP flag, but because it seems to make it a lot more explicit
that GFP_TRANSHUGE_LIGHT automatically implies __GFP_NORETRY.

I think that makes a whole lot of conceptual sense with the whole
meaning of GFP_TRANSHUGE_LIGHT. It's all about "no
reclaim/compaction", but honestly, doesn't __GFP_NORETRY make sense?

So I look at David's patch, and I go "that makes sense", and then I
compare it with ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
MADV_HUGEPAGE mappings") and that makes me go "ok, that's a hack".

So *if* reverting ac5b2c18911f and applying David's patch instead
fixes the KVM latency issues (which I assume it really should do,
simply thanks to __GFP_NORETRY), then I think that makes more sense.

That said, I do agree that the

        if (order == pageblock_order ...)

test in __alloc_pages_slowpath() in David's patch then argues for
"that looks hacky".  But that code *is* inside the test for

                if (costly_order && (gfp_mask & __GFP_NORETRY)) {

so within the context of that (not visible in the patch itself), it
looks like a sensible model. The whole point of that block is, as the
comment above it says

                /*
                 * Checks for costly allocations with __GFP_NORETRY, which
                 * includes THP page fault allocations
                 */

so I think all of David's patch is somewhat sensible, even if that
specific "order == pageblock_order" test really looks like it might
want to be clarified.

BUT.

With all that said, I really don't mind that __GFP_COMPACT_ONLY
approach either. I think David's patch makes sense in a bigger
context, while the __GFP_COMPACT_ONLY patch makes sense in the context
of "let's just fix this _particular_ special case.

As long as both work (and apparently they do), either is perfectly find by me.

Some kind of "Thunderdome for patches" is needed, with an epic soundtrack.

   "Two patches enter, one patch leaves!"

I don't so much care which one.

             Linus
