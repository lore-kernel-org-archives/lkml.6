Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B17AC00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6969221473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6969221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeJFHXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:23:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeJFHXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:23:52 -0400
Received: from localhost (unknown [104.153.224.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C064684F;
        Sat,  6 Oct 2018 00:22:43 +0000 (UTC)
Date:   Fri, 5 Oct 2018 17:22:35 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation
 size multiplications
Message-ID: <20181006002235.GA18415@kroah.com>
References: <20181005233559.GA37919@beast>
 <20181005235131.GA27193@kroah.com>
 <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 05:04:16PM -0700, Kees Cook wrote:
> On Fri, Oct 5, 2018 at 4:51 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Oct 05, 2018 at 04:35:59PM -0700, Kees Cook wrote:
> >> As done treewide earlier, this catches several more open-coded
> >> allocation size calculations that were added to the kernel during the
> >> merge window. This performs the following mechanical transformations
> >> using Coccinelle:
> >>
> >>       kvmalloc(a * b, ...) -> kvmalloc_array(a, b, ...)
> >>       kvzalloc(a * b, ...) -> kvcalloc(a, b, ...)
> >>       devm_kzalloc(..., a * b, ...) -> devm_kcalloc(..., a, b, ...)
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Has this had any testing in linux-next?
> 
> No; they're mechanical transformations (though I did build test them).
> If you want I could add this to linux-next for a week?

That would be good, thanks.

> > And when was "earlier"?
> 
> v4.18, when all of these were originally eliminated:
> 
> 026f05079b00 treewide: Use array_size() in f2fs_kzalloc()
> c86065938aab treewide: Use array_size() in f2fs_kmalloc()
> 76e43e37a407 treewide: Use array_size() in sock_kmalloc()
> 84ca176bf54a treewide: Use array_size() in kvzalloc_node()
> fd7becedb1f0 treewide: Use array_size() in vzalloc_node()
> fad953ce0b22 treewide: Use array_size() in vzalloc()
> 42bc47b35320 treewide: Use array_size() in vmalloc()
> a86854d0c599 treewide: devm_kzalloc() -> devm_kcalloc()
> 3c4211ba8ad8 treewide: devm_kmalloc() -> devm_kmalloc_array()
> 778e1cdd81bb treewide: kvzalloc() -> kvcalloc()
> 344476e16acb treewide: kvmalloc() -> kvmalloc_array()
> 590b5b7d8671 treewide: kzalloc_node() -> kcalloc_node()
> 6396bb221514 treewide: kzalloc() -> kcalloc()
> 6da2ec56059c treewide: kmalloc() -> kmalloc_array()
> 
> The new patch is catching new open-coded multiplications introduced in v4.19.

As this is getting smaller, why not just break it up and do it through
all of the different subsystems instead of one large patch?

And do we have a way to add a rule to 0-day to catch these so that they
get a warning when they are added again?

thanks,

greg k-h
