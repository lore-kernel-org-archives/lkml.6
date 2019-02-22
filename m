Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2685DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DAD2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550821499;
	bh=NiSaz8I8ZWeqeCQiBOq0aRSW8jmZYFD6/NhdfLYZ5/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pb6G/LphIqlHPkXLzyCayFrJhz69d14EIUHcDPqg1K2Z/mz0TmfCSqaUu83UHQYgf
	 cxaAUd2Mlzn1Q042THzeqg0KIWsIPXsPArd8VC4vA1e6043I6mS53oLE6gkJw29wWl
	 +0dEXQxYpYLsSX7cLGgxqQqQSwg3tOQyfZAkRO40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfBVHo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfBVHo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:44:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349C0207E0;
        Fri, 22 Feb 2019 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550821495;
        bh=NiSaz8I8ZWeqeCQiBOq0aRSW8jmZYFD6/NhdfLYZ5/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O36y64CXsJMJCtzPHdihoYnyESgn33nGJy5kaw99ZG+z7uIIbYC8sWCkERuSkF9i/
         hIN6oxPi17uW8/Ju/I+431Pnx1eBMXyvBz25JDvwogcmyPbn8gV9Xrga9GypNCg+MF
         ro3Gmbr7YC6I5ujUYDaGEXU7cbbPrByGgIChZg64=
Date:   Fri, 22 Feb 2019 08:44:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] habanalabs: use GFP_ATOMIC under spin lock
Message-ID: <20190222074453.GB3698@kroah.com>
References: <20190222054601.4396-1-weiyongjun1@huawei.com>
 <20190222070450.GA22604@kroah.com>
 <CAFCwf10u1qR+GVk-B-uPU9wWgN8yVDmOmWVHRsY0ZdXDM-qiwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10u1qR+GVk-B-uPU9wWgN8yVDmOmWVHRsY0ZdXDM-qiwg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:11:17AM +0200, Oded Gabbay wrote:
> On Fri, Feb 22, 2019 at 9:04 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 22, 2019 at 05:46:01AM +0000, Wei Yongjun wrote:
> > > A spin lock is taken here so we should use GFP_ATOMIC.
> > >
> > > Fixes: 0feaf86d4e69 ("habanalabs: add virtual memory and MMU modules")
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > ---
> > >  drivers/misc/habanalabs/memory.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> > > index 9236e52852c6..9e3491dc3b55 100644
> > > --- a/drivers/misc/habanalabs/memory.c
> > > +++ b/drivers/misc/habanalabs/memory.c
> > > @@ -120,7 +120,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > >
> > >       spin_lock(&vm->idr_lock);
> > >       handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
> > > -                             GFP_KERNEL);
> > > +                             GFP_ATOMIC);
> > >       spin_unlock(&vm->idr_lock);
> > >
> > >       if (handle < 0) {
> > >
> > >
> > >
> >
> > Ah, nice catch!
> >
> > Oded, any objection to me taking this patch?
> >
> > greg k-h
> No, of course not.
> This patch is:
> Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

Great, will go queue it up now, thanks.

greg k-h
