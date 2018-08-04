Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9DC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFF7217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFF7217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeHDUVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:21:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbeHDUVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:21:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67301401B1EA;
        Sat,  4 Aug 2018 18:19:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 445092026D66;
        Sat,  4 Aug 2018 18:19:51 +0000 (UTC)
Date:   Sat, 4 Aug 2018 14:19:51 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     wgh@torlan.ru, Theodore Ts'o <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180804181950.GA10514@redhat.com>
References: <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com>
 <20180803152034.GD32066@thunk.org>
 <20180803183932.GA3258@redhat.com>
 <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
 <20180803190617.GA4498@redhat.com>
 <CA+55aFzSM6qhZpM4CCpRNR_LWNCbLyRtQQ3hnPwnRrBdDkwWUw@mail.gmail.com>
 <a5feeaa7-e043-3987-cf23-4090e3eeec4a@torlan.ru>
 <CA+55aFza3_+poqmw34ev+a_jZ1Tz0rxjTu7YfnU4HX-SU52abQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFza3_+poqmw34ev+a_jZ1Tz0rxjTu7YfnU4HX-SU52abQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 04 Aug 2018 18:19:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 04 Aug 2018 18:19:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04 2018 at  1:04pm -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Aug 4, 2018 at 3:03 AM WGH <wgh@torlan.ru> wrote:
> >
> > >
> > The patch works for me.
> >
> > However, there's no text messsage in the kernel log, just a traceback. I
> > think that's because WARN_ONCE is supposed to take condition as a first
> > argument.
> 
> Duh.
> 
> It needs to be WARN_ONCE(1, ...);
> 
> I obviously didn't test that patch, but I _did_ compile it. I wonder
> why I didn't get a compiler warning for it...
> 
> [ Goes off and looks ]
> 
> Oh, because the "bio_devname(bio, b)" argument ended up being
> interpreted as the format string, and since it was a dynamic string
> the compiler felt it was all fine. Just bad luck.
> 
> Anyway, just out of curiosity, what was the traceback?
> 
> I'm not entirely happy with that patch either (even after the obvious
> fix to add the "1" argument), but it does seem like the minimal
> temporary workaround for now.

I agree.

Please feel free to add my:

Acked-by: Mike Snitzer <snitzer@redhat.com>
