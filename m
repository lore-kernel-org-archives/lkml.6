Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1CC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0049B21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544954870;
	bh=Eh9wW8TO2y4lVphbj8fY/LBgvhDq4RcVnR/VtZC/9KA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pCKMRZmOwDc8DB6MMmzEF3EFrEQf581iYAd0MPxr6B7644Abaoag9HYorSKhQ0dF2
	 KbdbtT/9TPoCo18ko5Qag0YTRxi4ibLMv9g5RaLbGLIq7mvppFQP1vlnO1121S8MOU
	 zxPkE9oG3MZHXTvYRfjjuV9D5fFinRnPSt9NDNdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbeLPKHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbeLPKHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:07:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542832086C;
        Sun, 16 Dec 2018 10:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544954867;
        bh=Eh9wW8TO2y4lVphbj8fY/LBgvhDq4RcVnR/VtZC/9KA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0hr31RY8GqkgL9j7cUK2ap7T6tTwSZ9oYmBbmhYxWN51H3XbIgRLkOQCFN0rdsbpw
         nQmAe798yMfJaDpWHT3bndYOUAu+0J37qdsbO7fzkT0vX79OD6+8Zn30KAYeZYuOQF
         3jGbjOcw0DOZ/Yf6oqS3xshE8XzfLYw2HOkn6TnQ=
Date:   Sun, 16 Dec 2018 10:07:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Add clock for external
 clock reference
Message-ID: <20181216100741.4e362a17@archlinux>
In-Reply-To: <154475156267.19322.6284056396098102605@swboyd.mtv.corp.google.com>
References: <20181206091052.7644-1-mircea.caprioru@analog.com>
        <20181208152954.596529f8@archlinux>
        <154475156267.19322.6284056396098102605@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, Clk experts, questions for you below.

Jonathan


On Thu, 13 Dec 2018 17:39:22 -0800
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jonathan Cameron (2018-12-08 07:29:54)
> > On Thu, 6 Dec 2018 11:10:51 +0200
> > Mircea Caprioru <mircea.caprioru@analog.com> wrote:
> >   
> > > This patch adds a clock to the state structure of ad7192 for getting the
> > > external clock frequency. This modifications is in accordance with clock
> > > framework dt bindings documentation.
> > > 
> > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>  
> > 
> > +cc Rob and the clk list for advise on how to do the binding for this one.
> > 
> > It is basically 2 pins, you can put a clock in on one of them or connect
> > a crystal across them.  The driver has to set a register to say which is
> > the case.  
> > 
> > Current proposal is two optional clocks (fall back to internal oscillator)
> > but that doesn't seem to be commonly done, so I'm wondering if there
> > is a 'standard' way to handle this sort of thing.
> >   
> 
> I'm not sure I fully understand, but I think perhaps
> assigned-clock-parents would work? Or does that not work because either
> way some parent is assigned, either the crystal or the optional clk that
> isn't a crystal?
> 
My concern is they aren't really separate clock inputs.   They are just different
ways of providing the same fundamental clock.  So I think we may want to just
provide a single clock and have another dt binding to say what it is.

So lots of ways we could do it, but I'm not sure what the right one to
go with is!

Jonathan

