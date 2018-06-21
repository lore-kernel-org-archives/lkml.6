Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF256C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE7B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nu/vETDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE7B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbeFUAR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:17:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeFUARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8bingSqYufrouwKCY41SOaU2Kt/j6GabdVNF914z6D0=; b=nu/vETDQIQr3rhYdDUgQVfqWv
        jlCvzLBmIVIC1Uup9Ya470vkLD10/VsL04LUjP/cv36wM04SUUFpoGJvhVzJQXC1xfTvGlhqz1ZWd
        eFkUKekz+Kpw5vSAhzEzVINPT50PVrypdTs4Tuztd0vdcJ2cOou1e+Z9qsEhcA+/CFRa129BrhGyP
        cyrzTKor+iKjKv/fcylGkn9zC3gLp89ZyBJAMN97MLPDpnYwUOf8+LFWYsHftz+OSmFom6BoooeTv
        wVBOMii7S4K9f16/OccKPzkS5eUja3cIxYLCdviSBT+37Fp9b5lmMM41vkv1zBCir9qiF6LKUFhaf
        fp4xmLaVg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVnHv-0005ul-C9; Thu, 21 Jun 2018 00:17:23 +0000
Date:   Wed, 20 Jun 2018 17:17:21 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mihai =?utf-8?B?RG9uyJt1?= <mihai.dontu@gmail.com>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
Message-ID: <20180621001721.GB3250@fury>
References: <20180620213141.GA8957@beast>
 <20180620233736.GA3250@fury>
 <CAGXu5jL4V9sL7Ai1SVTNkg8OE70c6kLJBdqNtj9Z06MOb4zG0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL4V9sL7Ai1SVTNkg8OE70c6kLJBdqNtj9Z06MOb4zG0g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:43:14PM -0700, Kees Cook wrote:
> On Wed, Jun 20, 2018 at 4:37 PM, Darren Hart <dvhart@infradead.org> wrote:
> > On Wed, Jun 20, 2018 at 02:31:41PM -0700, Kees Cook wrote:
> >> The probe handler_data was being allocated with __get_free_pages()
> >> for no reason I could find. The error path was using kfree(). Since
> >
> > v4 of Mario's series used kmalloc:
> > https://patchwork.kernel.org/patch/9985827/
> >
> > This was changed in v10 to use __get_free_pages:
> > https://patchwork.kernel.org/patch/10018023/
> >
> > But... I'm not finding the discussion that led to this change.... Mario,
> > do you recall? Something about contiguous memory? We had a similar
> > discussion on an earlier series:
> >
> > https://patchwork.kernel.org/patch/9975277/
> 
> FWIW, kmalloc gets you contiguous memory...

Yeah, I'm not finding a valid reason to use __get_free_pages over kmalloc in
this case. I'll give Mario a chance to respond in case I'm just missing
something, but otherwise will plan to apply this patch.

> 
> But if the reason is found and needs to stay, the probe error path's
> kfree() needs to be fixed, and __GFP_COMP needs to be added to the
> free page flags.

Got it, thanks Kees.

-- 
Darren Hart
VMware Open Source Technology Center
