Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F6C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B072214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fDei5UCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B072214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeLFA6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:58:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46488 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFA6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:58:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so20071010ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMhC0HqWli534yYkvp/Kknwo+jaBjSunFiEWH9es4FM=;
        b=fDei5UCrq9gB/BQr0VvXmN2VjiVxs3z7f8NhHC6M/5jjcMS62iAeVzo0Uhox8MEzT+
         bwX7MsKMCrqQNYNvoWUX8ZR4XRj3X0RSrd5cfhwVrEUu/8JQol6ylAMrwz8cGLqGgIkD
         csxbLgtM9895m1/i9YaOIW/tHsTu6/lRIENV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMhC0HqWli534yYkvp/Kknwo+jaBjSunFiEWH9es4FM=;
        b=qiGVKq979w9rnzZ2WpCR/t8+0mvEjvv1wxFojVZW+Dul9Q4Pj/wbr4jNAN/S3PgwID
         SYBWBNPQFkPSQNSz3TDIxTZKCw93yUwa7xoffLsATfzo6ZWYz58BGcHt6gM6ui/j844M
         GxoxYtWF81qCJbU/DAMjvj5Kir1vW7H4OPULayl6tMQ5S/vFxxok7/VNl764IOuGznXR
         ibbfKRcNd7XYL3rW8fUrY/DtpKJW1ErXg/tTtvVz4j6qyQj8yM+cxzGi7z7HCD9DvoBF
         Ataz5NB86MhKLgaeRTowUUdVPUBZTgg8AbyxxCxhma/sI4jIpBOOEXuvCPVVEJNQcXAl
         vNew==
X-Gm-Message-State: AA+aEWZjT1+oX4nRYmNZ5llJsCJc4qIB3mWe34aLci4hCn0rh7fMdK8o
        Be23z61L5ch8UdKsIjcQuGuzc6k3XBM=
X-Google-Smtp-Source: AFSGD/Vx9Q2S+t/Jtgvh2/ixP1qJ2iBz9c3T0qOjYPPLff5e4Z/JDhHL9p6BGPusIEJJPBVsCSH3vA==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr17251186ljs.118.1544057900205;
        Wed, 05 Dec 2018 16:58:20 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id i127-v6sm3990546lji.3.2018.12.05.16.58.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 16:58:19 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id i26so16186112lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:58:19 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr16309011lfg.117.1544057898543;
 Wed, 05 Dec 2018 16:58:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com> <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com> <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
In-Reply-To: <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Dec 2018 16:58:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
Message-ID: <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, I've applied David's latest patch.
>
> I'm not at all objecting to tweaking this further, I just didn't want
> to have this regression stand.

Hmm. Can somebody (David?) also perhaps try to state what the
different latency impacts end up being? I suspect it's been mentioned
several times during the argument, but it would be nice to have a
"going forward, this is what I care about" kind of setup for good
default behavior.

How much of the problem ends up being about the cost of compaction vs
the cost of getting a remote node bigpage?

That would seem to be a fairly major issue, but __GFP_THISNODE affects
both. It limits compaction to just this now, in addition to obviously
limiting the allocation result.

I realize that we probably do want to just have explicit policies that
do not exist right now, but what are (a) sane defaults, and (b) sane
policies?

For example, if we cannot get a hugepage on this node, but we *do* get
a node-local small page, is the local memory advantage simply better
than the possible TLB advantage?

Because if that's the case (at least commonly), then that in itself is
a fairly good argument for "hugepage allocations should always be
THISNODE".

But David also did mention the actual allocation overhead itself in
the commit, and maybe the math is more "try to get a local hugepage,
but if no such thing exists, see if you can get a remote hugepage
_cheaply_".

So another model can be "do local-only compaction, but allow non-local
allocation if the local node doesn't have anything". IOW, if other
nodes have hugepages available, pick them up, but don't try to compact
other nodes to do so?

And yet another model might be "do a least-effort thing, give me a
local hugepage if it exists, otherwise fall back to small pages".

So there are different combinations of "try compaction" vs "local-remote".

                      Linus
