Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D961FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB842168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB842168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeI0TBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:01:20 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42877 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeI0TBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:01:20 -0400
Received: by mail-qk1-f180.google.com with SMTP id g20-v6so325167qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSogzSrnj7cf+TG55dYC7OMHvE/PtJdF9+4xnMO//kk=;
        b=I1UGyhZejlfZbmOUfDj9YfCfh+CJWpNVIYHaQEdTV6IVRewSZyVopf4OtGZ7eEXLbh
         p7dRySHaPUUMsERVRZRcsqszRmJF0z4z/UxoFHrWfHNQ/UbQT/c87L6xAKakEHi37ujB
         tV4MU913R9EHJho/rzyjRJoeOyqovyUZ5isV16yWl9dBqNGBvC8Oytq2KzgUkcoMCv3E
         53qPD7VMnbo16FrM+Xh0YygdVw859VGrIeDBrjgDdUAHja7ogOjAbuqlbrbwfCLsCHcM
         qVPyJTLRZAalOTkzuGUg3jpP9rwdHCXxZ4EuKW2CyN5kIQQCcDahzMzPlfFgL0fsJI2J
         twIA==
X-Gm-Message-State: ABuFfogZKURFNYzlKZoo5GgW3E3/nOzAMizUo+Z/qki36A2O+kqeYDei
        4w3FEOQU/xeeEHk3FLty5a+5xg==
X-Google-Smtp-Source: ACcGV60l3eZdkmTfD6YsJWXydBVawLEJ8lyk55y8szaN/kSeTrAatKDOSEIPeEKcHdJFzGNV0c4DEg==
X-Received: by 2002:a37:e104:: with SMTP id c4-v6mr7844823qkm.28.1538052193052;
        Thu, 27 Sep 2018 05:43:13 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-F4F.dyn6.twc.com. [2606:a000:1100:db::f4f])
        by smtp.gmail.com with ESMTPSA id h58-v6sm1234631qtk.60.2018.09.27.05.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 05:43:12 -0700 (PDT)
Message-ID: <51b401b82356c2d8e124bb8701f310afd98e0838.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Matthew Wilcox <willy@infradead.org>
Date:   Thu, 27 Sep 2018 08:43:10 -0400
In-Reply-To: <20180925223054.GH2933@thunk.org>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
         <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
         <20180925003044.239531c7@alans-desktop>
         <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
         <20180925154627.GC2933@thunk.org>
         <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
         <20180925223054.GH2933@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 18:30 -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 25, 2018 at 12:41:18PM -0400, Jeff Layton wrote:
> > That's all well and good, but still doesn't quite solve the main concern
> > with all of this. It's suppose we have this series of events:
> > 
> > open file r/w
> > write 1024 bytes to offset 0
> > <background writeback that fails>
> > read 1024 bytes from offset 0
> > 
> > Open, write and read are successful, and there was no fsync or close in
> > between them. Will that read reflect the result of the previous write or
> > no?
> 
> If the background writeback hasn't happened, Posix requires that the
> read returns the result of the write.  And the user doesn't know when
> or if the background writeback has happened unless the user calls
> fsync(2).
> 
> Posix in general basically says anything is possible if the system
> fails or crashes, or is dropped into molten lava, etc.  Do we say that
> Linux is not Posix compliant if a cosmic ray flips a few bits in the
> page cache?  Hardly!  The *only* time Posix makes any guarantees is if
> fsync(2) returns success.  So the subject line, is in my opinion
> incorrect.  The moment we are worrying about storage errors, and the
> user hasn't used fsync(2), Posix is no longer relevant for the
> purposes of the discussion.
> 
> > The answer today is "it depends".
> 
> And I think that's fine.  The only way we can make any guarantees is
> if we do what Alan suggested, which is to imply that a read on a dirty
> page *block* until the the page is successfully written back.  This
> would destroy performance.  I know I wouldn't want to use such a
> system, and if someone were to propose it, I'd strongly argue for a
> switch to turn it *off*, and I suspect most system administators would
> turn it off once they saw what it did to system performance.  (As a
> thought experiment, think about what it would do to kernel compiles.
> It means that before you link the .o files, you would have to block
> and wait for them to be written to disk so you could be sure the
> writeback would be successful.  **Ugh**.)
> 
> Given that many people would turn such a feature off once they saw
> what it does to their system performance, applications in general
> couldn't rely on it.  which means applications who cared would have to
> do what they should have done all along.  If it's precious data use
> fsync(2).  If not, most of the time things are *fine* and it's not
> worth sacrificing performance for the corner cases unless it really is
> ultra-precious data and you are willing to pay the overhead.

Basically, the problem (as I see it) is that we can end up evicting
uncleanable data from the cache before you have a chance to call fsync,
and that means that the results of a read after a write are not
completely reliable.

We had some small discussion of this at LSF (mostly over malt beverages)
and wondered: could we offer a guarantee that uncleanable dirty data
will stick around until:

1) someone issues fsync() and scrapes the error

...or...

2) some timeout occurs (or we hit some other threshold? This part is
definitely open for debate)

That would at least allow an application issuing regular fsync calls to
reliably re-fetch write data via reads up until the point where we see
fsync fail. Those that don't issue regular fsyncs should be no worse off
than they are today.

Granted #2 above represents something of an open-ended commitment -- we
could have a bunch of writers that don't call fsync fill up memory with
uncleanable pages, and at that point we're sort of stuck.

That said, all of this is a rather theoretical problem. I've not heard
any reports of problems due to uncleanable data being evicted prior to
fsync, so I've not lept to start rolling patches for this.
-- 
Jeff Layton <jlayton@redhat.com>

