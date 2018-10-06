Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB838C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 03:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836DD208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 03:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xJUB/see"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836DD208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeJFKQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 06:16:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35023 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeJFKQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 06:16:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id l17-v6so1535497pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=suCoay0QDIWtHm2tijyxcdrOkSUsgE2+EpD78wypXAo=;
        b=xJUB/seeWe7QkFLxGPi3cRiIKShN8M72MUeSHDnAtTXqPdvZC+s3Q+IrZuLIZt1eQN
         nYUy/9uUB/6iHSn4olq5ZM8dJ9vzFfQ1vfv4U+Oh4ldw7WMNIecy7ECExua7CZlQYCRc
         ERYvfXKXTZeYX/N6nAPMbceJm7Xy2ue0O6mAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=suCoay0QDIWtHm2tijyxcdrOkSUsgE2+EpD78wypXAo=;
        b=hdqPjEvsSxctE6qNgMK5pCivuPkl92moGa/NMBt2tgHJGftEz38DdjSVfC2A1eLnqr
         6ggRZoTn4ZSRTMWV8pw/4/p3eTuray2l7El211E1M2+auqgkUWhJqvDRrouz14KL6beV
         lgdg9w2P/cRSd7LYn970ps82h+GFZe2R07P4xvYBYkycsZX5qDatc9+XcGMbWOBpcVT8
         1kUgGUmTM2vCWWOwAk6r7BpkguXkZH0u5bNa6E4su+8ITHQwrh2DwBvBQkmBXjth0OzQ
         qqzV6amtizem7uRv+/YcUx87BxO7Wu0cZFuC55n5Hpcclmc9mib5AxElOxLnQaS4WW3r
         Ou3w==
X-Gm-Message-State: ABuFfogVF5wDMGcP0TN0KeLk6UpdN3znsEtYyklkU+qO4powy9yVm/iD
        A0SnWPXYeyFdvIacOYLFuxZK3A==
X-Google-Smtp-Source: ACcGV60DcTvA8xuoD+W90eOTMM68HritI9lSoDmrNa2+luvApyzX86VuZTt/G/odURn8rH/uu0uBWw==
X-Received: by 2002:a63:2e47:: with SMTP id u68-v6mr12750966pgu.294.1538795677045;
        Fri, 05 Oct 2018 20:14:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id c28-v6sm34652750pfk.48.2018.10.05.20.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 20:14:35 -0700 (PDT)
Date:   Fri, 5 Oct 2018 20:14:34 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, fengguang.wu@intel.com
Subject: Re: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation
 size multiplications
Message-ID: <20181006031434.GA224454@joelaf.mtv.corp.google.com>
References: <20181005233559.GA37919@beast>
 <20181005235131.GA27193@kroah.com>
 <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
 <20181006002235.GA18415@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006002235.GA18415@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 05:22:35PM -0700, Greg KH wrote:
> On Fri, Oct 05, 2018 at 05:04:16PM -0700, Kees Cook wrote:
> > On Fri, Oct 5, 2018 at 4:51 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Fri, Oct 05, 2018 at 04:35:59PM -0700, Kees Cook wrote:
> > >> As done treewide earlier, this catches several more open-coded
> > >> allocation size calculations that were added to the kernel during the
> > >> merge window. This performs the following mechanical transformations
> > >> using Coccinelle:
> > >>
> > >>       kvmalloc(a * b, ...) -> kvmalloc_array(a, b, ...)
> > >>       kvzalloc(a * b, ...) -> kvcalloc(a, b, ...)
> > >>       devm_kzalloc(..., a * b, ...) -> devm_kcalloc(..., a, b, ...)
> > >>
> > >> Signed-off-by: Kees Cook <keescook@chromium.org>
> > >
> > > Has this had any testing in linux-next?
> > 
> > No; they're mechanical transformations (though I did build test them).
> > If you want I could add this to linux-next for a week?
> 
> That would be good, thanks.
> 
> > > And when was "earlier"?
> > 
> > v4.18, when all of these were originally eliminated:
> > 
> > 026f05079b00 treewide: Use array_size() in f2fs_kzalloc()
> > c86065938aab treewide: Use array_size() in f2fs_kmalloc()
> > 76e43e37a407 treewide: Use array_size() in sock_kmalloc()
> > 84ca176bf54a treewide: Use array_size() in kvzalloc_node()
> > fd7becedb1f0 treewide: Use array_size() in vzalloc_node()
> > fad953ce0b22 treewide: Use array_size() in vzalloc()
> > 42bc47b35320 treewide: Use array_size() in vmalloc()
> > a86854d0c599 treewide: devm_kzalloc() -> devm_kcalloc()
> > 3c4211ba8ad8 treewide: devm_kmalloc() -> devm_kmalloc_array()
> > 778e1cdd81bb treewide: kvzalloc() -> kvcalloc()
> > 344476e16acb treewide: kvmalloc() -> kvmalloc_array()
> > 590b5b7d8671 treewide: kzalloc_node() -> kcalloc_node()
> > 6396bb221514 treewide: kzalloc() -> kcalloc()
> > 6da2ec56059c treewide: kmalloc() -> kmalloc_array()
> > 
> > The new patch is catching new open-coded multiplications introduced in v4.19.
> 
> As this is getting smaller, why not just break it up and do it through
> all of the different subsystems instead of one large patch?
> 
> And do we have a way to add a rule to 0-day to catch these so that they
> get a warning when they are added again?

They could just be added to scripts/coccinelle and 0-day will report them?

For example, 0-day ran scripts/coccinelle/api/platform_no_drv_owner.cocci on
a recently submitted patch and reported it here:
https://lore.kernel.org/lkml/201808301856.vMNJerSs%25fengguang.wu@intel.com/

But I'm not sure if 0-day runs make coccicheck on specific semantic patches,
or runs all of them (CC'd Fengguang).

thanks,

 - Joel

