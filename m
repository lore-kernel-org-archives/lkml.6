Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4DDC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03292064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03292064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIEMdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:33:46 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:45756 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbeIEMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:33:46 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 3B23013FC8F; Wed,  5 Sep 2018 10:04:45 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:04:45 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180905080444.GD24519@BitWizard.nl>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180905070847.GC24519@BitWizard.nl>
 <3805399.0d8HT3LL4o@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3805399.0d8HT3LL4o@merkaba>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:39:58AM +0200, Martin Steigerwald wrote:
> Rogier Wolff - 05.09.18, 09:08:
> > So when a mail queuer puts mail the mailq files and the mail processor
> > can get them out of there intact, nobody is going to notice.  (I know
> > mail queuers should call fsync and report errors when that fails, but
> > there are bound to be applications where calling fsync is not
> > appropriate (*))
> 
> AFAIK at least Postfix MDA only reports mail as being accepted over SMTP 
> once fsync() on the mail file completed successfully. And I´d expect 
> every sensible MDA to do this. I don´t know how Dovecot MDA which I 
> currently use for sieve support does this tough.

Yes. That's why I added the remark that mailers will call fsync and know
about it on the write side. I encountered a situation in the last few
days that when a developer runs into this while developing, would have
caused him to write: 
  /* Calling this fsync causes unacceptable performance */
  // fsync (fd); 

I know of an application somewhere that does realtime-gathering of
call-records (number X called Y for Z seconds). They come in from a
variety of sources, get de-duplicated standardized and written to
files. Then different output modules push the data to the different
consumers within the company. Billing among them. 

Now getting old data there would be pretty bad. And calling fsync
all the time might have performance issues.... 

That's the situation where "old data is really bad". 

But when apt-get upgrade replaces your /bin/sh and gets a write error
returning error on subsequent reads is really bad. 

It is more difficult than you think. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
