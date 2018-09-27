Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D927C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05771216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05771216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeI1FJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:09:45 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:58492 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeI1FJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:09:45 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8RMmxLL000501;
        Thu, 27 Sep 2018 23:48:59 +0100
Date:   Thu, 27 Sep 2018 23:48:58 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180927234858.507ea60b@alans-desktop>
In-Reply-To: <20180926214909.GD3688@thunk.org>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
        <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
        <20180925003044.239531c7@alans-desktop>
        <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
        <20180925154627.GC2933@thunk.org>
        <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
        <20180925223054.GH2933@thunk.org>
        <20180926191055.6fc1514f@alans-desktop>
        <20180926214909.GD3688@thunk.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 17:49:09 -0400
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> On Wed, Sep 26, 2018 at 07:10:55PM +0100, Alan Cox wrote:
> > In almost all cases you don't care so you wouldn't use it. In those cases
> > where it might matter it's almost always the case that a reader won't
> > consume it before it hits the media.
> > 
> > That's why I suggested having an fbarrier() so you can explicitly say 'in
> > the even that case does happen then stall and write it'. It's kind of
> > lazy fsync. That can be used with almost no cost by things like mail
> > daemons.  
> 
> How could mail daemons use it?  They *have* to do an fsync() before
> they send a 2xx SMTP return code.

Point - so actually it would be less useful

> > Another way given that this only really makes sense with locks
> > is to add that fbarrier notion as a file locking optional semantic so you
> > can 'unlock with barrier' and 'lock with barrier honoured'  
> 
> I'm not sure what you're suggesting?

If someone has an actual case you could in theory constrain it to a range
specified in a file lock and only between two people who care. That said
seems like a lot of complexity to make a case nobody cares about only
affect people who care about it

Alan
