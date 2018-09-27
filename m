Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F79C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27D821714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27D821714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeI1EYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:24:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42588 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725728AbeI1EYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:24:19 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ycv3F1MjcskK; Fri, 28 Sep 2018 00:03:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC7FB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:fb00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CBF21EC0317;
        Fri, 28 Sep 2018 00:03:52 +0200 (CEST)
Date:   Fri, 28 Sep 2018 00:03:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Russ Anderson <rja@hpe.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180927220355.GF19687@zn.tnic>
References: <20180925180458.GG23986@zn.tnic>
 <20180926093510.GA5584@zn.tnic>
 <20180926152752.GG5584@zn.tnic>
 <20180926130340.6b22918b@coco.lan>
 <20180926161749.GI5584@zn.tnic>
 <20180926181035.GA1132@agluck-desk>
 <20180926182317.patqjso7nzw2oxiz@hpe.com>
 <20180926230257.GA5666@agluck-desk>
 <20180927045244.GA30912@zn.tnic>
 <20180927214400.GA2249@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927214400.GA2249@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:44:01PM -0700, Luck, Tony wrote:
> The problem with your patch that gets rid of EDAC_MAX_MCS is making
> device links under /sys/bus/edac.  Which is hinted at in some of the
> code your patch deleted:
> 
> -       /*
> -        * The memory controller needs its own bus, in order to avoid
> -        * namespace conflicts at /sys/bus/edac.
> -        */
> -       name = kasprintf(GFP_KERNEL, "mc%d", mci->mc_idx);
> -       if (!name)
> -               return -ENOMEM;
> -
> -       mci->bus->name = name;

Yes, and that needed to go because I am using a single bus. Which kinda
makes sense because you want to have a single bus and multiple devices
on it. I mean, if we *have* to have a bus.

I think this whole /sys/bus/edac thing is crap and needs to go. We
have a perfectly fine hierarchy under /sys/devices/system/edac and
duplicating it under /sys/bus/edac is just bollocks. IMHO. Feel free to
correct me with, but but, this is useful for...

> which seemed to work.

Right.

> But then I began wondering what are ABI expectations
> from applications that read the EDAC /sys files?
> 
> Is this this current source repository?  https://github.com/grondo/edac-utils
> 
> This code doesn't seem to know about the "dimm*" directories below the
> "mc*" level. It just looks for the csrow* entries.

I guess this is a question for Mauro. I never really needed any special
edac tool to get info and if you ask me, we probably should try to keep
it simple and grep sysfs. So that you can always get the info without
having to install any special tools. Like ftrace works on every system
with just a shell and basic tools. I think this is very powerful. But
this is old spartan me only thinking out loud.

In any case, I'm more than fine with dropping the bus hierarchy if
nothing uses it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
