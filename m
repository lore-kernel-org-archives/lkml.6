Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5808AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED62F249D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HrDEAXfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED62F249D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934020AbeFVX1f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:27:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeFVX1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ZuCUbssZOsf3ZG4KTzDvZiadYuDIZW00+9rbnQtoWU=; b=HrDEAXfpGd5c0hcU1MzylyF6s5
        ogTeTb8jQMnf+tvtpFHOQH/AjpUFwHk7IflVmT2XCUz+Ka8/SP9Gg7WVN0JCT8/tRJQaqauyDX4Dd
        Nu9cHfGWzDexh1s9TDxOWh0ZdEbydEPPcdDTz1K/HS2+vUBoBg7UHDns0zmSLtAAW63D6tysMae6D
        kzK7dCejjrCTCS/mnLh0uWBgwLQP6x2iFM7o4vHPucvPaHQtlM6Tr0QS9/wgkQ2hXPR51oMHGzNnd
        Lwzoi3ZZFWOIboXrA2w+N2JRLiVjj0owPDfce6xzYE7dqSoaRsQp4YSd1LgQOgT2ieWdmRasM27lp
        HrUnVlZw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWVSl-00057z-LY; Fri, 22 Jun 2018 23:27:31 +0000
Date:   Fri, 22 Jun 2018 16:27:30 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mario.Limonciello@dell.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org,
        mihai.dontu@gmail.com
Subject: Re: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
Message-ID: <20180622232730.GA27466@fury>
References: <20180620213141.GA8957@beast>
 <20180620233736.GA3250@fury>
 <CAGXu5jL4V9sL7Ai1SVTNkg8OE70c6kLJBdqNtj9Z06MOb4zG0g@mail.gmail.com>
 <20180621001721.GB3250@fury>
 <3974cbadd027497982b5a52c765fb698@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3974cbadd027497982b5a52c765fb698@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:24:34AM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Wednesday, June 20, 2018 7:17 PM
> > To: Kees Cook
> > Cc: LKML; Andy Shevchenko; Platform Driver; Mihai Donțu; Limonciello, Mario
> > Subject: Re: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
> > 
> > On Wed, Jun 20, 2018 at 04:43:14PM -0700, Kees Cook wrote:
> > > On Wed, Jun 20, 2018 at 4:37 PM, Darren Hart <dvhart@infradead.org> wrote:
> > > > On Wed, Jun 20, 2018 at 02:31:41PM -0700, Kees Cook wrote:
> > > >> The probe handler_data was being allocated with __get_free_pages()
> > > >> for no reason I could find. The error path was using kfree(). Since
> > > >
> > > > v4 of Mario's series used kmalloc:
> > > > https://patchwork.kernel.org/patch/9985827/
> > > >
> > > > This was changed in v10 to use __get_free_pages:
> > > > https://patchwork.kernel.org/patch/10018023/
> > > >
> > > > But... I'm not finding the discussion that led to this change.... Mario,
> > > > do you recall? Something about contiguous memory? We had a similar
> > > > discussion on an earlier series:
> > > >
> > > > https://patchwork.kernel.org/patch/9975277/
> > >
> > > FWIW, kmalloc gets you contiguous memory...
> > 
> > Yeah, I'm not finding a valid reason to use __get_free_pages over kmalloc in
> > this case. I'll give Mario a chance to respond in case I'm just missing
> > something, but otherwise will plan to apply this patch.
> 
> I think it was for contiguous memory, so if kmalloc is giving that I agree
> no need to keep __get_free_pages instead.
> 
> Acked-by: Mario Limonciello <Mario.limonciello@dell.com>

Confirmed, kmalloc in physically contiguous.

Queued up, and tagged for stable. Thanks everyone.

-- 
Darren Hart
VMware Open Source Technology Center
