Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662AAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EF120879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544027371;
	bh=ORsivgG4NppBhrv/ogSzDyTdA+RRYLk22016rnWWrMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dYNg/hHTDDPhZQNsIl3uSD2vTBLsC38heWHwCO03nHLsexQt9M72NAxbZX2hsgwH8
	 WYH2PNRuZH57Yx0kBCu+pxx6yIlqUMyc02AZoUx8GCBrlNluFXIjoY6iFTdgUPYE+J
	 dCqZkbDTymiS9JOa8Y9yDteELkInjXUrUgj3Kr0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EF120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeLEQ3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbeLEQ33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:29:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53AE2064D;
        Wed,  5 Dec 2018 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544027369;
        bh=ORsivgG4NppBhrv/ogSzDyTdA+RRYLk22016rnWWrMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8wBItGFIdwaFl5BVgUHWxovtNZH2EH9jSiGOzHukqwhkONKzYWgIk3fFAHLIfJWx
         Ruq4zmVyeOj8E/TOZCyqI1Zo+CLceiKYOLPTUINSudb5z7b/asT+kvCVBR/gkVr2Sd
         5UnxUHZo3ZASWUXm1It4xTuYWhhP3R+/NT4TuF3Q=
Date:   Wed, 5 Dec 2018 17:29:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH] binder: fix sparse warnings on locking context
Message-ID: <20181205162926.GA7185@kroah.com>
References: <20181203202457.228972-1-tkjos@google.com>
 <20181205105746.GA16376@kroah.com>
 <CAHRSSEyj8xsJk76r5Rinmor9szYHaca5nLATWgDvt4Vkq-NtQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSEyj8xsJk76r5Rinmor9szYHaca5nLATWgDvt4Vkq-NtQw@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 06:02:22AM -0800, Todd Kjos wrote:
> On Wed, Dec 5, 2018 at 2:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Dec 03, 2018 at 12:24:54PM -0800, Todd Kjos wrote:
> > > Add __acquire()/__release() annnotations to fix warnings
> > > in sparse context checking
> > >
> > > There is one case where the warning was due to a lack of
> > > a "default:" case in a switch statement where a lock was
> > > being released in each of the cases, so the default
> > > case was added.
> > >
> > > Signed-off-by: Todd Kjos <tkjos@google.com>
> >
> > You sent out 4 patches here, as a series, but with no numbering so I
> > don't know what order to put them in :(
> >
> > Can you resend them properly numbered so I have a chance to get it
> > right?
> >
> 
> I didn't number them because they are independent and can go in any order.

Ah, that wasn't obvious :)

> They are not really a series. I can resend with numbers though if you want
> to reflect the order I sent them in.

Ok, no need for numbering them, but they do need to be resent based on
the feedback I gave.  I've dropped them all from my queue because of
that.

thanks,

greg k-h
