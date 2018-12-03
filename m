Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1EB20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QbwnoqRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1EB20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLCW1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:27:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44012 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeLCW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:27:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id 83-v6so12959032ljf.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Xcr2RaqLdt+inByx0BzSFBwe7JgSAypthxfQImB8tg=;
        b=QbwnoqRDRGBP+cMN0uTU7Nf45tJ3aAdfeSSTF/b68ZUaaVh1wyBpU1tuSukdrs1MAL
         ljZsr+gFlKxEC6G20CwY5EAXaa/z9fzvtxkPWN8Yp6oLUr8hdDiHdSrp/Euy6W9du1ky
         SPyub0PpB+qNMu8prjQ02aVVMjpSzyGaK53T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Xcr2RaqLdt+inByx0BzSFBwe7JgSAypthxfQImB8tg=;
        b=rfrjk79P3eMo+OPSZLOh/YtRA49Kf1c9nJrVkC3st5NGOPRM/yLVY3VzzLGgH61IQx
         fQA3to7IqFx5hhj0c5PYxajBnutj3Bp25OvQPXefmhl/MGea5rlZdmKQGtzd6az22KUM
         E47JW3cXZ8iACWvOlzmi5EaFKLhfX8u/kZ1E1Xd+BPNOZjHSd9FliYjrgE27BTOJNvKE
         Sch6YFPNTFL0A9l+Ixrmglhf2aNBTNkCg9H2CYb2rcLP3sxMg37GPX6X6fpQA3TkHTz/
         ES65Qxz3xeZwebKffKPiI5UXMsKgU0aEASs8CqWcVwHWvKmrfZ+ijCv6N2sPIKbVJRPC
         1aow==
X-Gm-Message-State: AA+aEWas3VDBiHLYyV+nlhQKeik+BanPmAESZWW86ywvqmK3nKAdvnXg
        ro+EVLJo6I7r1Lve+qf4NR3aaRCXFmw=
X-Google-Smtp-Source: AFSGD/XwRDVNB2f81uTpAWuKKa4IF+qTefBFBY06cOJPok7yEND8d+dNeNRsDGEeE1IbQrIR07Iu4g==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr10957553lja.170.1543876057040;
        Mon, 03 Dec 2018 14:27:37 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id e14-v6sm2749808ljl.43.2018.12.03.14.27.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:27:35 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id z13so10420374lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:27:35 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr9557667lff.16.1543876054594;
 Mon, 03 Dec 2018 14:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
In-Reply-To: <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 14:27:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
Message-ID: <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 2:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> so I think all of David's patch is somewhat sensible, even if that
> specific "order == pageblock_order" test really looks like it might
> want to be clarified.

Side note: I think maybe people should just look at that whole
compaction logic for that block, because it doesn't make much sense to
me:

                /*
                 * Checks for costly allocations with __GFP_NORETRY, which
                 * includes THP page fault allocations
                 */
                if (costly_order && (gfp_mask & __GFP_NORETRY)) {
                        /*
                         * If compaction is deferred for high-order allocations,
                         * it is because sync compaction recently failed. If
                         * this is the case and the caller requested a THP
                         * allocation, we do not want to heavily disrupt the
                         * system, so we fail the allocation instead of entering
                         * direct reclaim.
                         */
                        if (compact_result == COMPACT_DEFERRED)
                                goto nopage;

                        /*
                         * Looks like reclaim/compaction is worth trying, but
                         * sync compaction could be very expensive, so keep
                         * using async compaction.
                         */
                        compact_priority = INIT_COMPACT_PRIORITY;
                }

this is where David wants to add *his* odd test, and I think everybody
looks at that added case

+                       if (order == pageblock_order &&
+                                       !(current->flags & PF_KTHREAD))
+                               goto nopage;

and just goes "Eww".

But I think the real problem is that it's the "goto nopage" thing that
makes _sense_, and the current cases for "let's try compaction" that
are the odd ones, and then David adds one new special case for the
sensible behavior.

For example, why would COMPACT_DEFERRED mean "don't bother", but not
all the other reasons it didn't really make sense?

So does it really make sense to fall through AT ALL to that "retry"
case, when we explicitly already had (gfp_mask & __GFP_NORETRY)?

Maybe the real fix is to instead of adding yet another special case
for "goto nopage", it should just be unconditional: simply don't try
to compact large-pages if __GFP_NORETRY was set.

Hmm? I dunno. Right now - for 4.20, I'd obviously want to keep changes
smallish, so a hacky added special case might be the right thing to
do. But the code does look odd, doesn't it?

I think part of it comes from the fact that we *used* to do the
compaction first, and then we did the reclaim, and then it was
re-orghanized to do reclaim first, but it tried to keep semantic
changes minimal and some of the above comes from that re-org.

I think.

                Linus
