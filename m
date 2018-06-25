Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476BAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A2025B6B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A2025B6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934406AbeFYO2C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:28:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:58181 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934258AbeFYO2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:28:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9814AD69;
        Mon, 25 Jun 2018 14:27:59 +0000 (UTC)
Date:   Mon, 25 Jun 2018 16:27:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180625142758.ourdvfid3aymgvan@pathway.suse.cz>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
 <20180618061550.GA27996@jagdpanzerIV>
 <20180618062306.GA29683@jagdpanzerIV>
 <20180619093244.ehj34uhpnpv6447f@pathway.suse.cz>
 <20180619094953.GB2631@jagdpanzerIV>
 <20180619105213.uzf6ba3oo3475icz@pathway.suse.cz>
 <20180620015525.GC650@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620015525.GC650@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-20 10:55:25, Sergey Senozhatsky wrote:
> On (06/19/18 12:52), Petr Mladek wrote:
> > > But when I set /sys/module/printk/parameters/ignore_loglevel I naturally
> > > expect it to take an immediate action. Without waiting for the consoles
> > > to catch up and to discard N messages [if the consoles were behind the
> > > logbuf head].
> > 
> > Yeah, I understand this view. I thought about it as well. But did you
> > ever needed this behavior in the real life?
> >
> > I personally changed ignore_loglevel only before I wanted to reproduce a
> > bug. Then it would be perfectly fine to handle it only in
> > vprintk_emit(). In fact, it would be even better because it would
> > affect only messages that happened after I triggered the bug.
> 
> So maybe the patch can stand the way it is, after all. JFI, still haven't
> seen those "helps in real life a lot" examples, tho.

I have personally seen these races when testing printk in NMI. I
combined iptables logging, ping -f and sysrq-l. I am not sure
how often they happen in the real life but I could understand
that it might be annoying.

This patch goes in the right direction and nobody really blocks
it. Therefore I pushed it into printk.git, branch for-4.19.

Best Regards,
Petr
