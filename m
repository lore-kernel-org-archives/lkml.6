Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF527C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE2020652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE2020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757331AbeFSVwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56489 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755466AbeFSVwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:52:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 71988AED2;
        Tue, 19 Jun 2018 21:52:16 +0000 (UTC)
Date:   Tue, 19 Jun 2018 16:52:02 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Ren <zren@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: dlmglue: clean up timestamp handling
Message-ID: <20180619215202.zniqq3py3hqjeudv@merlin>
References: <20180619155826.4106487-1-arnd@arndb.de>
 <20180619171407.yoncg72ed2vncf62@merlin>
 <CAK8P3a0Mcm+AxBPxouMZJKXfbEyX-UD3=_speEj7bsW9nmnjzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Mcm+AxBPxouMZJKXfbEyX-UD3=_speEj7bsW9nmnjzA@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-19 21:11, Arnd Bergmann wrote:
> On Tue, Jun 19, 2018 at 7:14 PM, Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> >
> > On 06-19 17:58, Arnd Bergmann wrote:
> >> The handling of timestamps outside of the 1970..2038 range in the dlm
> >> glue is rather inconsistent: on 32-bit architectures, this has always
> >> wrapped around to negative timestamps in the 1902..1969 range, while on
> >> 64-bit kernels all timestamps are interpreted as positive 34 bit numbers
> >> in the 1970..2514 year range.
> ...
> >
> > Will all values written to LVB be the same with or without the patch?
> > I am considering the situation where in a cluster some machines have this
> > patch and some don't. Depending on that, this may require a version
> > change.
> 
> There is one part that may change:
> 
> >> -static u64 ocfs2_pack_timespec(struct timespec *spec)
> >> +static u64 ocfs2_pack_timespec(struct timespec64 *spec)
> >>  {
> >>       u64 res;
> >> -     u64 sec = spec->tv_sec;
> >> +     u64 sec = clamp_t(time64_t, spec->tv_sec, 0, 0x3ffffffffull);
> >>       u32 nsec = spec->tv_nsec;
> >>
> >>       res = (sec << OCFS2_SEC_SHIFT) | (nsec & OCFS2_NSEC_MASK);
> 
> Here, setting a timestamp before 1970 or after 2514 will get wrapped
> around in unpatched kernels, but will be clamped to the minimum
> and maximum times after the patch.
> 
> It is extremely rare for correct code to need timestamps outside of that
> range, but it is also trivial to trigger that with a manual 'touch' command
> from user space.
> 
> If the change is a problem, I can resend the patch without that one
> line change.
> 

I think you should keep the change, but incrment OCFS2_LVB_VERSION.


-- 
Goldwyn
