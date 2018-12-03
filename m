Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0199C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CBD208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dH8bwQQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CBD208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLCSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:01:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42732 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeLCSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:01:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so12268856lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMequlaPSMDEgDTya61QUmB0BDWe2wvEog3UPGT3UYk=;
        b=dH8bwQQDYZ8mx2VRAevfyyZNwuF6EwrmvEUszH4nt4yl3ixUo7vonLtiUPKFdeju1x
         /hhmVCaJOecoL7MaZspW8UuoeR9jxLznh/eJsYKXrdXVWnbaLzc8N/j/1hnwirjphjkL
         Xn5IFIBYnLFWEyvRvkGFnjRYUrL8IEjX7YPKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMequlaPSMDEgDTya61QUmB0BDWe2wvEog3UPGT3UYk=;
        b=qdeNBCngWfoY97sahMD6RxC6dORuV49ZcMVn+kRZkc0wTUD/x0M7nPpcPvGJQCvGGt
         7ObbFZdCG0bJ4pD+pTINvdHzFbzVo1B5mC9oFeLxcbK//gdlQDbvpgaKzFXK9fg1bbiT
         1c+hrCdPZiWDbseHRdFB39pH2svQ4TlRsgHnR11dCjHWytOSca4dIdit6S8yWZ4b7UXf
         EwaNycJ8ub/d//XpiY7hGksLuF4PjajCKbU7CnbKNqjmkmMLqxBlhRnTqdriyJQPhJcJ
         ToeL7AhQWe5H0ThHEVDOzda9WxuDx/oNkXK6uzmLJXCXw2bNBoq9foSnGSJcIyi3oZL+
         wfnA==
X-Gm-Message-State: AA+aEWatpbDLXK8oWBxXB600yhdS9FUuc/AjGksys/9XjyrTKQPT5qsU
        z7YoYLMh/AbWMaffMUZUReiZSgCxG/E=
X-Google-Smtp-Source: AFSGD/UUciMUnmmtNo2cAdD9SQZE+0gWMgOL/XjP4VeSrQMTRKIaQXSrYxhFofBu9m0fRtxAh9zE+Q==
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr11888725lji.90.1543860096735;
        Mon, 03 Dec 2018 10:01:36 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2566274ljv.1.2018.12.03.10.01.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:01:35 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id v15-v6so12249380ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:01:35 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr10301151lja.148.1543860094870;
 Mon, 03 Dec 2018 10:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com> <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
In-Reply-To: <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 10:01:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
Message-ID: <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     ying.huang@intel.com
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, rientjes@google.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 8:48 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 27, 2018 at 7:20 PM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > In general, memory allocation fairness among processes should be a good
> > thing.  So I think the report should have been a "performance
> > improvement" instead of "performance regression".
>
> Hey, when you put it that way...
>
> Let's ignore this issue for now, and see if it shows up in some real
> workload and people complain.

Well, David Rientjes points out that it *does* cause real problems in
real workloads, so it's not just this benchmark run that shows the
issue.

So I guess we should revert, or at least fix. David, please post your
numbers again in public along with your suggested solution...

                   Linus
