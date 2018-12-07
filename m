Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE74DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9160520892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544166513;
	bh=/o3XxVTymMGUS4eUzSdcg6eMG+Jiix9BIi10ojsKqRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IIxXSpSJ1aWVtgac8PsuheLRSwI2WVfLAPirLaWaFgT/Procr9Nlt8wvaIKjqvs3E
	 Laix5JHCww+Q4kQpoKSMJP1MI7wXzPgzST3DkvzC0mdNXjmhwPVjN3Rg4ExmNUZnUj
	 kVlhRK63XA22nEK4RWCfvz4vnDz8NXDICH2gsFEo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9160520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGHIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGHIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:08:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABABD20850;
        Fri,  7 Dec 2018 07:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544166511;
        bh=/o3XxVTymMGUS4eUzSdcg6eMG+Jiix9BIi10ojsKqRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/pn/flsSa8NpTdrVmM7HCoH7p1ouomT5qQLRfpadYExd8XT3tML3cjw3MbjIrN5z
         3+v0FwXFfbFSy6Czx9Q1lnYosjifZy+N20+Twwo/iDheq3x+tegbUlCsfYfIZd+UOw
         D04/LR15laBZYoJk9xFCoPXeWy+EXmIq7iFWuFD4=
Date:   Fri, 7 Dec 2018 08:08:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] binder: fix sparse warnings on locking context
Message-ID: <20181207070828.GA8802@kroah.com>
References: <20181205231926.45928-1-tkjos@google.com>
 <20181206144408.GA24078@kroah.com>
 <CAHRSSExQzgVZdk09rxoow-OTbEq0fhgW+MgemToEPEN=TiwWLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSExQzgVZdk09rxoow-OTbEq0fhgW+MgemToEPEN=TiwWLA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:37:41AM -0800, Todd Kjos wrote:
> On Thu, Dec 6, 2018 at 6:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Dec 05, 2018 at 03:19:24PM -0800, Todd Kjos wrote:
> > > Add __acquire()/__release() annnotations to fix warnings
> > > in sparse context checking
> > >
> > > There is one case where the warning was due to a lack of
> > > a "default:" case in a switch statement where a lock was
> > > being released in each of the cases, so the default
> > > case was added.
> > >
> > > Signed-off-by: Todd Kjos <tkjos@google.com>
> > > ---
> > > v2: no change, just resubmitted as #1 of 3 patches instead of by itself
> >
> > I've already applied this one, right?
> 
> No, not yet. I confused you by failing to add the "v2" in the subject
> for the other two submitted with it that you applied this morning:
> 
> binder: filter out nodes when showing binder procs
> binder: fix kerneldoc header for struct binder_buffer
> 
> Sorry about the confusion. This one still needs to be applied.

But I thought I applied this back on November 26:
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-testing&id=324fa64cf4189094bc4df744a9e7214a1b81d845

You should have gotten an email from my scripts at that time.

or is this somehow a different patch with the same commit log?
Or a v2 that changed from the one that I had applied?  Do I need to
revert this one and apply your new one?

confused,

greg k-h
