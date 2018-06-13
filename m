Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C2311C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818620020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXFgVQyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7818620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935824AbeFMOdV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:33:21 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34897 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935560AbeFMOdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:33:19 -0400
Received: by mail-yb0-f194.google.com with SMTP id f79-v6so987983ybg.2;
        Wed, 13 Jun 2018 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=17p0BOZbRIek1yrnhxs3uhH5J0mRJwpB6H9kMXEjuJg=;
        b=iXFgVQyvxUYQBnnKrnJjN6crXoHSjn7LplWYJksuPuZOCtiV3T5QHCX4R5Zlx8FFEY
         ikNvjGlsumTH8/EUluvo5iINsPEAQDXxbCMgXHC1DGFRV0Sy/AJ2pQ9l16QSOA/BBovF
         feJuBarOUEwW5ldoGdM+URvYhLE4bMFhuABl4uAp9GhL6CtBU/SiT0KvnuF4l4t3LijC
         ZNp0w2yVuGo6zBqBTRh+jy5AW5sD+plsYNQcGMXDUMwSdHepQI9/5u54iyBc1ohxYn4N
         S4gUeExxHD9ZjtB/1DR1tZl5j1nMQHVbADugKOkePs1Q4chiVsEBA3PmU4uIBCEiPxY1
         ZIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=17p0BOZbRIek1yrnhxs3uhH5J0mRJwpB6H9kMXEjuJg=;
        b=rTuBHubFriEQUs6LIqdJ6CzB0YO6nUzN+Kp7+Gdsi9p/hrVn3025lRYuJLkhVCda4U
         6OGvybI+t8aPOd9hktMSVLxF1BydXNaQiBm7HAT4S9r4LRsPsnjM1ecYmMFjZ0p5phKI
         bBaXjI1UlZuf/1fJy0i1ZqhiOk/l1bPDeef1yxOpwBYrVatQA1/DDMK37U54D+RenV4H
         KjuT31aQkcsmcdWV3kw5SQwa7QsoysQKWhEvqT4lbQh75NzGkgz0sa/pmj9s0D2sb2/r
         LrZXw5hB9zdAzeiXQo54QTyVA3TAvWx/o6GQbgIkYVoxXiFl6t+l/XMH5KeRwsEGwBKh
         jTtg==
X-Gm-Message-State: APt69E2u6BgCx/hvxH+KE7bufn+XAdRSMh8JtmfIupnuEF5mWY+mdRf+
        eH/RRofr5IASgg69WFXU9Go=
X-Google-Smtp-Source: ADUXVKJfJemDVo5EhisSfOTYocF4Vvp585YHXVtFaZCSlwkboR4JYlsG80X6yJH7RiQOQeWfjrv9xw==
X-Received: by 2002:a25:4885:: with SMTP id v127-v6mr2492103yba.425.1528900398533;
        Wed, 13 Jun 2018 07:33:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:f38])
        by smtp.gmail.com with ESMTPSA id 137-v6sm1009225yws.24.2018.06.13.07.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 07:33:17 -0700 (PDT)
Date:   Wed, 13 Jun 2018 07:33:15 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180613143315.GS1351649@devbig577.frc2.facebook.com>
References: <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jan.

On Tue, Jun 12, 2018 at 05:57:54PM +0200, Jan Kara wrote:
> > Yeah, right, so the root cause is that we're walking the wb_list while
> > holding lock and expecting the object to stay there even after lock is
> > released.  Hmm... we can use a mutex to synchronize the two
> > destruction paths.  It's not like they're hot paths anyway.
> 
> Hmm, do you mean like having a per-bdi or even a global mutex that would
> protect whole wb_shutdown()? Yes, that should work and we could get rid of
> WB_shutting_down bit as well with that. Just it seems a bit strange to

Yeap.

> introduce a mutex only to synchronize these two shutdown paths - usually
> locks protect data structures and in this case we have cgwb_lock for
> that so it looks like a duplication from a first look.

Yeah, I feel a bit reluctant too but I think that's the right thing to
do here.  This is an inherently weird case where there are two ways
that an object can go away with the immediate drain requirement from
one side.  It's not a hot path and the dumber the synchronization the
better, right?

Thanks.

-- 
tejun
