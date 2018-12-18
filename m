Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D47217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hfuJ2bpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeLRL3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:29:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FAKsZSVf2S0E+nyC1FDpLhK6DsQWrlnEfdac8lJBcU4=; b=hfuJ2bpx1DQwIdBOoahQtxwcS
        nj9uX6pwVlJ2/6j+GJ3zZ+I7G0G50CcUDLkRwxINSjs0dwWjlNCUyiJZ1ggyERp3hixpCA4GbaQlo
        2Nuojn5bUugODeZ+jDZf8ZFfsa+vAVJadGOZKcVz+QES7CBgdEFy5KE/s5iwTzeL8lIXbCDopSdkm
        dZLJEXjKHJSJ2yisT4MqoWbap0h/w+D4zeSOy5/qPLe6ilpOoHFM48cakvCXy4AzCIT6vdppl3osA
        JddcfHSRobdB1PSadkGV8wfh4FN/zBAW/pJiwZb9U7zTpnMiG3UykeYAjCufS3ZzNZfyPCMFbnJZ7
        2kYAldIfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZDZ9-0007ft-Vv; Tue, 18 Dec 2018 11:29:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C69B62027E1A4; Tue, 18 Dec 2018 12:29:34 +0100 (CET)
Date:   Tue, 18 Dec 2018 12:29:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218112934.GF15430@hirez.programming.kicks-ass.net>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
 <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Why are they writing it to /dev/kmsg though? Shouldn't they be writing
this to syslog directly?


