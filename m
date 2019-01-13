Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B77C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605221721
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547363423;
	bh=r3nUFbOwVLYAUHE9uia3FFweptc1mQZub1DWXzAaG9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XLQe+mzfuraw8YNZZ7TdejiLpQBfk21/WvoBZmpasESXpan4dCzhq2g7nOfg/Y8pm
	 r/HIRSOoIoVICbM3u+tskc1B0tD0M5JXHBTJlkDHlUcYdqPZHiurAN9SA76XDg6+di
	 iGsR5ifNDEQNLJ7iZWhstqG2GtjOohvbKKxoy9WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfAMHKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 02:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAMHKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 02:10:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F6820873;
        Sun, 13 Jan 2019 07:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547363418;
        bh=r3nUFbOwVLYAUHE9uia3FFweptc1mQZub1DWXzAaG9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0c7O64XuWiQV7Iqxhu0iitCYNoBQJSNzO3qmWENcdlY9kBasr1KUls8qChZbZMLx
         vE0g5EUwek0AWF90ShjdFEjOOikSxpZP+eex2kmtpTSYF7P9xE1O6en1zF5HjteZqM
         uX20djK6pnalAYn4yvMsv3dI/LOIyeTaruwT+xgE=
Date:   Sun, 13 Jan 2019 08:10:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kelly <martin@martingkelly.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pali Rohar <pali.rohar@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: [PATCH 4.14 058/105] tools: fix cross-compile var clobbering
Message-ID: <20190113071015.GB5540@kroah.com>
References: <20190111131102.899065735@linuxfoundation.org>
 <20190111131107.880515108@linuxfoundation.org>
 <CADVatmMALKGQc3M3vyuHekDiR6zNhFzCiJCLrg00_9N0nDSChg@mail.gmail.com>
 <76359b4d-94e1-f88b-7ca6-e99555c2910a@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76359b4d-94e1-f88b-7ca6-e99555c2910a@martingkelly.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 01:35:35PM -0800, Martin Kelly wrote:
> On 1/12/19 1:18 PM, Sudip Mukherjee wrote:
> > Hi Greg,
> > 
> > On Fri, Jan 11, 2019 at 2:34 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Martin Kelly <martin@martingkelly.com>
> > > 
> > > commit 7ed1c1901fe52e6c5828deb155920b44b0adabb1 upstream.
> > 
> > This was fixed upstream by 755396163148 ("tools: power/acpi, revert to
> > LD = gcc")
> > 
> > 
> 
> Yes, both patches should be applied. This patch fixed a bunch of Makefiles
> but caused a regression in power/acpi, which is fixed by
> 755396163148.

Thanks all, now queued up.

greg k-h
