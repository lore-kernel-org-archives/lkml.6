Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D3520863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jjnx8ABa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D3520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeK3TSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:18:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbeK3TR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:17:59 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366A4206B7;
        Fri, 30 Nov 2018 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543565371;
        bh=z2MYl/L4IAF4r+79sfPwnl6D6NuGsc2wixsEvrIf0ZA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Jjnx8ABaORiNLC5WxoUNmp2HalHlHznh5JNFO/IkMo49ydzD3l3yZHlt1s5v7O8E8
         qRgN/dgzGa0cQRVpdFpzRCAiQg3yA/1EpMxcukZkf+Cuxgvp3SI1GJpOJSdiuEdYrw
         8N5C7nzXz3ovQPbHHJxqhZgusO2xhhb5S6pxIOek=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Nicholas Mc Guire <der.herr@hofr.at>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130075453.GB2456@osadl.at>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
 <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
 <20181130075453.GB2456@osadl.at>
Message-ID: <154356537055.88331.12823387821854167503@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2] clk: zynq: do not allow kmalloc failure
Date:   Fri, 30 Nov 2018 00:09:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Mc Guire (2018-11-29 23:54:53)
> On Thu, Nov 29, 2018 at 03:45:23PM -0800, Stephen Boyd wrote:
> > Quoting Nicholas Mc Guire (2018-11-21 04:28:30)
> > > The kmalloc here is small (< 16 bytes) and occurs during initializati=
on
> > > during system startup here (can not be built as module) thus if this
> > > kmalloc failed it is an indication of something more serious going on
> > > and it is fine to hang the system here rather than cause some harder
> > > to understand error by dereferencing NULL.
> > > =

> > > Explicitly checking would not make that much sense here as the only
> > > possible reaction would be would BUG() here anyway.
> > > =

> > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > ---
> > =

> > Nak. We don't have any __GFP_NOFAIL in drivers/clk and I don't see a
> > reason why we would want it here either. Just handle the failure, or
> > don't care if this is so critical to system boot.
> >
> It was not motivated by the criticality but by the low probability
> and cluttering the code for this case did not seem good to me.
> Effectively handling it here means BUG() - so more or less
> the same result that hanging it on __GFP_NOFAIL if allocation
> was not possible would cause.
> =

> Not clear what the objection to __GFP_NOFAIL here is - my understanding
> was that it is intended precisely for cases like this - but
> I=C2=B4ll send a V2 handling it with BUG_ON(!clk_name) if that is prefere=
d.
> =


Or just WARN() and return. Maybe something else can get far enough to be
helpful.

I would also appreciate if this sort of problem could be caught earlier
in code review and/or with some automated scripting. Debating BUG_ON()
and allocation failures is not what I look forward to doing so please
try to make this exact sort of patch never make it to the list in the
first place.

