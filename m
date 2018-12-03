Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0DD20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EXnMKc/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0DD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLCT2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:28:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34405 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeLCT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:28:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so10076158lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcqr95NdsWGfXX2Card60ahcMyGmWKAbxTmynlD06Bc=;
        b=EXnMKc/wc5QTDT59u9qzSx53BxE0EBEVFRf9BtNtUczEBQ/0FC0eXRCMhR6YxO4MoU
         oxeoiCM+X++mBjjfORB4JRajgbYyJ4dBDuO9SHajQkPMxVOeXqA+7xthzvF7aGG2lWNd
         tltMu4+0k8D7m1pdVpx6+5npuRvdgUik8OY4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcqr95NdsWGfXX2Card60ahcMyGmWKAbxTmynlD06Bc=;
        b=bPMWImsU1/ahfO8u54m+RpczaENDCuhQ8H1j0ymvjHqtpHBXFxyYJ8+P8aZeLXn9by
         SumBy25eAZO8a+r9bl/0UG8a9BJSnR3c/HlMBcZ85sPg2Oe32u/bsuW8Np3BqYPh1z2x
         O2dtrNSrnDGTJDl5soY2RG43qHlyrp/pUom3x2GWLHT3161cIH2rOLes+90RXvlwKQiY
         EeI9d0C3H5SBov72ekA+NsDDEhwMZ84nhs2EGGv9oKAZgYawZ9fPxOeyuSLRX9OmllZt
         NmaBDKfEhJp9RPBR01qPBK7aeIKTcMCqYbfQpmb4h54+tnjlKDb4qp52Cpe1K8sDhW8O
         /yxA==
X-Gm-Message-State: AA+aEWZ1P2gCBrC8ihhRGh72OMHtkf77QSLKVD57BCJh/wZtDy4EZiT6
        J63GfFBdKL4OA5vEDiTnT1aHGULAj3g=
X-Google-Smtp-Source: AFSGD/UMDSk/0ys1CM1TCeso8SkT7yQVeLEIVCclamEtn0Cfv5Reo4YsuX6bzeYcRmDVVbBRrbWU5g==
X-Received: by 2002:a19:cd50:: with SMTP id d77mr9721452lfg.125.1543865305500;
        Mon, 03 Dec 2018 11:28:25 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q8-v6sm2692585lji.69.2018.12.03.11.28.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 11:28:24 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id s5-v6so12498868ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 11:28:24 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr11068811ljs.118.1543865303544;
 Mon, 03 Dec 2018 11:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
In-Reply-To: <20181203185954.GM31738@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 11:28:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
Message-ID: <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     mhocko@kernel.org
Cc:     ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
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

On Mon, Dec 3, 2018 at 10:59 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> You are misinterpreting my words. I haven't dismissed anything. I do
> recognize both usecases under discussion.
>
> I have merely said that a better THP locality needs more work and during
> the review discussion I have even volunteered to work on that.

We have two known patches that seem to have no real downsides.

One is the patch posted by Andrea earlier in this thread, which seems
to target just this known regression.

The other seems to be to revert commit ac5b2c1891  and instead apply

  https://lore.kernel.org/lkml/alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com/

which also seems to be sensible.

I'm not seeing why the KVM load would react badly to either of those
models, and they are known to fix the google local-node issue.

              Linus
