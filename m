Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B64C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7BE2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546957511;
	bh=tjcPeNgVCU6GAmPRjwh1mRQFI2zeGDmYUhfi2iC1CeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zb1eYOSgpz2Wp/kG9jxQqtyveJX+HsDmOJAl7mNH4jX8iMd+zqd2i8RL57FWaE/qn
	 3Eil2EmYTfTn1h7T8DwROIkHQ+5bWxfrOYyfw15ZYzcHNw8X3lDZfsEi5SeGVi8MeG
	 o1sbesC7YUXEDhc7ZweWTPqSmkTA60pSaeWZPYkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfAHOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfAHOZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:25:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E7220850;
        Tue,  8 Jan 2019 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546957509;
        bh=tjcPeNgVCU6GAmPRjwh1mRQFI2zeGDmYUhfi2iC1CeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDDdKmgYnW4SzO7l1uGANnyucTjV1XhDGGn6nc1o1qJDvEHyKTFRW+NoCd8UlbHS7
         O7UYhjTRFYBDJ8i1jSO2dQ5jcpiyRHU4APTiNjAbvsiPBaUu2oDUhVHF01ZC4TMFC3
         2/3LP4qqmI8w4m/FTnGN82kXeM1EYe9W5MWQpfFM=
Date:   Tue, 8 Jan 2019 15:25:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     devel@driverdev.osuosl.org, kirk@reisers.ca,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>
Subject: Re: general protection fault in spk_ttyio_ldisc_close
Message-ID: <20190108142507.GA13938@kroah.com>
References: <CAEAjamunJjFFJ8Yd-DQAv64MxYiiktsTUWex=boAOdc0+7h+uQ@mail.gmail.com>
 <20190108135020.GA10504@kroah.com>
 <CAEAjamuyjcxVNF5seJ0w0LQT0FSqvHYG30fzhe1s7UgVWzdaFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamuyjcxVNF5seJ0w0LQT0FSqvHYG30fzhe1s7UgVWzdaFg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:15:02AM -0500, Kyungtae Kim wrote:
> On Tue, Jan 8, 2019 at 8:50 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jan 08, 2019 at 08:37:37AM -0500, Kyungtae Kim wrote:
> > > We report a bug in linux-4.20: "general protection fault in
> > > spk_ttyio_ldisc_close"
> > >
> > > kernel config: https://kt0755.github.io/etc/config_v4.20_stable
> > > repro: https://kt0755.github.io/etc/repro.a670e.c
> > >
> > > This occurs when the function kfree is about to execute
> > > (driver/staging/speakup/spk_ttyio.c:68).
> > > Particularly, kfree takes the argument like speakup_tty->disc_data.
> > > But speakup_tty is invalid, so the pointer dereference causes GPF.
> > > At a glance, it seems that speakup_tty was deallocated somewhere ahead of kfree.
> >
> > How did you trigger this?  Did you shut down and close the device
> > already somehow?  Do you have a real tty device that is driven by the
> > device?
> >
> > thanks,
> >
> > greg k-h
> 
> For this crash, we did without real speakup tty device.

How did you bind a non-real speakup tty device to the driver?

> I'm currently trying to figure out how this actually happens.

That would be great to figure out :)

thanks,

greg k-h
