Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC337C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CBC2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OxXn/5jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CBC2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeLEWDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:03:32 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:37426 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:03:31 -0500
Received: by mail-lj1-f175.google.com with SMTP id e5-v6so19815839lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jeBCiMRjj6emHZgqF9aI6xfjnoFCV7BrQmzQ31NuRYM=;
        b=OxXn/5jftXfYxnB8kIaksOk1tG8sO9RRBauyeFarUiXHKvJ+Rncz7Y/qUSfnDpIxGX
         XW5ZVG+y8Ll5Mw1m8Oqtu/HfgktTWPPr5EsGYHlxfNa8WRcKHNgpZyD9Oj7MdYegXmK0
         KvxhbNc1NCZ/5X+8oTw5TZq42xUW6bDwnxFUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeBCiMRjj6emHZgqF9aI6xfjnoFCV7BrQmzQ31NuRYM=;
        b=YhtDF1ms4i1ctqKA/hjWk47htTBmeMGJSRbz97jYkNETHXzMTIqn/rD9gKLINzi08X
         vAtGMUIxtoqyjSnac1GoSBc685KSTX4P5NLyUH/qTkKCVNJkTNt2eJRMYQU0EUjbfv+p
         NpXpeOT7Fnndoq1O8eR0kOOSH91WFM03GAz3naHqR2s2ilyf3a8RJJnsq+H7XipmbXp6
         mEUh9pFvoJlzHd9Ho1RL7UXRUd5OqpZm7vrpA9Nc1pfhqm7UzR+KKqwd6HuuC5rn8a21
         p9m/8APUjR7iFRVEZz+pLK4GaB1Zw6wG7BiCFcO/W79ahVfSCFBXUdcPMinY/VohoUHp
         JtOw==
X-Gm-Message-State: AA+aEWbWlBlDEG+HzVLJz05vgO99Z2+3KkE2ThO8r8QuOGI0Z5bOuVnH
        Wsosm9zOP9Ed2eTAHr0Hg4vrrbA1RqM=
X-Google-Smtp-Source: AFSGD/Uxp+4Qs8OniJSZ3Fx6Y2/qKhDO8C96I1Y9tLfXoHEj3PMVveQ0Sb6tRh58INc7e2A+FLcOgg==
X-Received: by 2002:a2e:5654:: with SMTP id k81-v6mr16346264ljb.48.1544047409020;
        Wed, 05 Dec 2018 14:03:29 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m13-v6sm4133342ljg.56.2018.12.05.14.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 14:03:28 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id g11-v6so19800218ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:03:27 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr18359782ljj.6.1544047407295;
 Wed, 05 Dec 2018 14:03:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
In-Reply-To: <20181205204034.GB11899@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Dec 2018 14:03:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
Message-ID: <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
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

On Wed, Dec 5, 2018 at 12:40 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> So ultimately we decided that the saner behavior that gives the least
> risk of regression for the short term, until we can do something
> better, was the one that is already applied upstream.

You're ignoring the fact that people *did* report things regressed.

That's the part I find unacceptable. You're saying "we picked
something that minimized regressions".

No it didn't. The regression is present and real, and is on a real
load, not a benchmark.

So that argument is clearly bogus.

I'm going to revert the commit since people apparently seem to be
ignoring this fundamental issue.

Real workloads regressed.  The regressions got reported. Ignoring that
isn't acceptable.

                    Linus
