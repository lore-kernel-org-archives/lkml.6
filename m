Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B62CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C940218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549703394;
	bh=x1bZDtpzJSa256kZ5+teSfdYKRKskL2WmjDUJ5BPnLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GFS+P2Th2oGUVvUNOOeUU9+PF15QEng4eQ/u+FnFcYX0up0iVa3fwkhM3ABMjqOA+
	 5Wsk8j6UBqVfTYDXZdxbqwm+QEJI5PaKSBbccXrUQ4zMSwYlYOls7rS3o0O5a/QQPE
	 aMzh39mpWy7c3uSnnD9jU9OKT2wxxqH3Mh76Vrxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBIJJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfBIJJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:09:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C3820823;
        Sat,  9 Feb 2019 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549703391;
        bh=x1bZDtpzJSa256kZ5+teSfdYKRKskL2WmjDUJ5BPnLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVC9RPpUw/kIn3GK3IQ8nwdHv1H/zkT3KzhGzc0bpnxW5fRpcqtgCccYGAxhPQKWw
         fFcfPw7Z8ZqkqSJ4+UytReSRPYRfKDcFBua0ufuf17Q4Xk2qL3XSo02yK7Vs+CFeUk
         lMfw0pR+Xv49qxPtmwHttybb3apzaXwxsQEMUza8=
Date:   Sat, 9 Feb 2019 10:09:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mike Rapoport <rppt@linux.ibm.com>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 05/15] habanalabs: add command buffer module
Message-ID: <20190209090948.GB3377@kroah.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
 <20190204203254.4026-6-oded.gabbay@gmail.com>
 <20190208120639.GA23483@kroah.com>
 <CAFCwf13hn+qEqv_CcR+O8fynUrz9Mma7mKzQr6COv48kTMoO=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13hn+qEqv_CcR+O8fynUrz9Mma7mKzQr6COv48kTMoO=Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:53:27PM +0200, Oded Gabbay wrote:
> On Fri, Feb 8, 2019 at 2:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 04, 2019 at 10:32:44PM +0200, Oded Gabbay wrote:
> > > +int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
> > > +{
> > > +     union hl_cb_args *args = data;
> > > +     struct hl_device *hdev = hpriv->hdev;
> > > +     u64 handle;
> > > +     int rc;
> > > +
> > > +     switch (args->in.op) {
> > > +     case HL_CB_OP_CREATE:
> > > +             rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
> > > +                                     &handle, hpriv->ctx->asid);
> >
> > so cb_size comes from userspace, ok, you check for the value to be too
> > small, but not too big.  That means someone can try to allocate too much
> > memory, possibly crashing things, not good :(
> Yes, correct, but even if I limit a single allocation to, let's say,
> 1MB, what's stopping a userspace process from allocating multiple CBs
> and draining the system memory ? I'm counting on the oom module to
> kill that process if it mis-behaves.
> And, btw, I assumed there is hard limit of 4MB on a single
> dma_alloc_coherent. i.e. I was never able to allocate more then 4MB
> through that API. So I never thought I need to check for max size
> because of that hard limit.
> Am I missing something here ?

Relying on the oom module to handle driver issues is not always a wise
idea ;)

You should put a bounds on your max allocation, if it really is 4MB,
then test for that.

thanks,

greg k-h
