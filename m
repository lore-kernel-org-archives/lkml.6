Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAE2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7CE20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NVYgZaFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLRLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:47:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeLRLrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:47:11 -0500
Received: from zn.tnic (p200300EC2BD17800B0C9856CE6A48B11.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:7800:b0c9:856c:e6a4:8b11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 471D11EC078A;
        Tue, 18 Dec 2018 12:47:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545133630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YhyvO1pydcyo7YS+wXJ0wZ8IdmiVY1Jrb1OAUgvzEmE=;
        b=NVYgZaFimy2+kkZi5Q4ZFs5eeznsAZDvsTNK2xJJkJ6dujO/0xdQbU/PRz1txtqbQoTpDn
        eOy+fUcfMfP+mrCu7vLcNYRy+Jp9AGtw8YJSVsSbixV1NI2VVIHfZL3vdEbjsNu1v1synX
        Oegv2nVEs/wtigmCcu5alrRO9/f1xpQ=
Date:   Tue, 18 Dec 2018 12:47:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218114709.GF7485@zn.tnic>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218111701.GA32522@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 08:17:01PM +0900, Sergey Senozhatsky wrote:
> On (12/18/18 11:48), Peter Zijlstra wrote:
> > > I know that there is a "kernel.printk_devkmsg" interface; do we
> > > expect every systemd-enabled distro to find that out and to tweak
> > > kernel.printk_devkmsg or shall we change the default devkmsg
> > > ratelimit instead?
> > 
> > How about we complain to systemd instead?
> 
> We certainly can. As far as I understand, they log shutdown events
> (including errors and warnings): what they kill, what they stop,
> what they umount, etc. The more partitions, services are running
> (I guess), the more things they need to umount, kill, stop; hence,
> the more messages. I kinda can imagine what they will answer ;)
> 
> The below (and a bunch of other) messages are getting ratelimited.
> I'm not sure what will happen should any of those steps fail and
> print warning-s. My guess would be that we probably can ratelimit
> those warnings:
> 
> ...
>  systemd[1]: Unmounting /home...
>  systemd[1]: Unmounting Temporary Directory (/tmp)...
>  systemd[1]: Unmounted Temporary Directory (/tmp).
>  systemd[1]: Stopped target Swap.
>  systemd[1]: Unmounted /boot.
>  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/a0737dff-e797-44f0-aea7-d0df1107ff63.
>  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/5d773b72-e200-4d11-a219-176d62a16d8d.
>  systemd[1]: Unmounted /home.
>  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/35319ddc-9b92-4ab0-aaa4-9922db636a5e.
>  systemd[1]: Unmounted /media/edev.
>  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/da00daaf-5601-4531-912e-bd69103b379d.
>  systemd[1]: Unmounted /media/dump.
>  systemd[1]: Reached target Unmount All Filesystems.
>  systemd[1]: Stopped File System Check on /dev/disk/by-uuid/b52da2df-161b-4c33-b700-277d95b9672f.
>  systemd[1]: Removed slice system-systemd\x2dfsck.slice.
>  systemd[1]: Stopped target Local File Systems (Pre).
>  systemd[1]: Stopped Create Static Device Nodes in /dev.
>  systemd[1]: Stopped Create System Users.
>  systemd[1]: Stopped Remount Root and Kernel File Systems.
>  systemd[1]: Reached target Shutdown.
>  systemd[1]: Reached target Final Step.
>  systemd[1]: Starting Reboot...

And we wanna see all those "very useful" messages in dmesg because...?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
