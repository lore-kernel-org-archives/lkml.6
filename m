Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00F520827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfAHO0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:26:11 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:46134 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728752AbfAHO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:26:11 -0500
X-IronPort-AV: E=Sophos;i="5.56,454,1539640800"; 
   d="scan'208";a="363100600"
Received: from unknown (HELO function) ([193.50.110.88])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2019 15:26:09 +0100
Received: from samy by function with local (Exim 4.92-RC3)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1ggsKX-0005Bd-1o; Tue, 08 Jan 2019 15:26:09 +0100
Date:   Tue, 8 Jan 2019 15:26:09 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kyungtae Kim <kt0755@gmail.com>, devel@driverdev.osuosl.org,
        kirk@reisers.ca, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>
Subject: Re: general protection fault in spk_ttyio_ldisc_close
Message-ID: <20190108142609.3nraohfx6msxb4hm@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kyungtae Kim <kt0755@gmail.com>, devel@driverdev.osuosl.org,
        kirk@reisers.ca, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>
References: <CAEAjamunJjFFJ8Yd-DQAv64MxYiiktsTUWex=boAOdc0+7h+uQ@mail.gmail.com>
 <20190108135020.GA10504@kroah.com>
 <CAEAjamuyjcxVNF5seJ0w0LQT0FSqvHYG30fzhe1s7UgVWzdaFg@mail.gmail.com>
 <20190108142507.GA13938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108142507.GA13938@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le mar. 08 janv. 2019 15:25:07 +0100, a ecrit:
> On Tue, Jan 08, 2019 at 09:15:02AM -0500, Kyungtae Kim wrote:
> > On Tue, Jan 8, 2019 at 8:50 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jan 08, 2019 at 08:37:37AM -0500, Kyungtae Kim wrote:
> > > > We report a bug in linux-4.20: "general protection fault in
> > > > spk_ttyio_ldisc_close"
> > > >
> > > > kernel config: https://kt0755.github.io/etc/config_v4.20_stable
> > > > repro: https://kt0755.github.io/etc/repro.a670e.c
> > > >
> > > > This occurs when the function kfree is about to execute
> > > > (driver/staging/speakup/spk_ttyio.c:68).
> > > > Particularly, kfree takes the argument like speakup_tty->disc_data.
> > > > But speakup_tty is invalid, so the pointer dereference causes GPF.
> > > > At a glance, it seems that speakup_tty was deallocated somewhere ahead of kfree.
> > >
> > > How did you trigger this?  Did you shut down and close the device
> > > already somehow?  Do you have a real tty device that is driven by the
> > > device?
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > For this crash, we did without real speakup tty device.
> 
> How did you bind a non-real speakup tty device to the driver?

One can tell any device name to the driver and it will attempt to
communicate with it.

Samuel
