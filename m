Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3090CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCE3217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545813310;
	bh=bpIcwbWzZRvgepOTahZPuu02H07rsjBEpyTD0Obebcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LqBPQyZnVkr/6cqiUI6jli9DfVjTNxWRoR6LqjdSVLC8DZkCk7Ea0bRF4e25meE3y
	 4hnyR9TuVkAHLUsxD234AuMPr/EJJyvsk4nZuMZUdt8jr160zKvGhuuvVEDKu/iMPY
	 1xnVYilqmKsIuw07PCqJPvdYyK3jj13d/edfSxJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbeLZIfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:35:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:42714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeLZIfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD322ACC2;
        Wed, 26 Dec 2018 08:35:06 +0000 (UTC)
Date:   Wed, 26 Dec 2018 09:35:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 0/1] mm: add a warning about high order allocations
Message-ID: <20181226083505.GF16738@dhcp22.suse.cz>
References: <20181225153927.2873-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225153927.2873-1-khorenko@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-12-18 18:39:26, Konstantin Khorenko wrote:
> Q: Why do we need to bother at all?
> A: If a node is highly loaded and its memory is significantly fragmented
> (unfortunately almost any node with serious load has highly fragmented memory)
> then any high order memory allocation can trigger massive memory shrink and
> result in quite a big allocation latency. And the node becomes less responsive
> and users don't like it.
> The ultimate solution here is to get rid of large allocations, but we need an
> instrument to detect them.

Can you point to an example of the problem you are referring here? At
least for costly orders we do bail out early and try to not cause
massive reclaim. So what is the order that you are concerned about?

> Q: Why warning? Use tracepoints!
> A: Well, this is a matter of magic defaults.
> Yes, you can use tracepoints to catch large allocations, but you need to do this
> on purpose and regularly and this is to be done by every developer which is
> quite unreal.
> On the other hand if you develop something and get a warning, you'll have to
> think about the reason and either succeed with reworking the code to use
> smaller allocation sizes (and thus decrease allocation latency!) or just use
> kvmalloc() if you don't really need physically continuos chunk or come to the
> conclusion you definitely need physically continuos memory and shut up the
> warning.

Well, not really. For one thing, there are systems to panic on warning
and you really do not want to blow up just because somebody is doing a
large order allocation.

> Q: Why compile time config option?
> A: In order not to decrease the performance even a bit in case someone does not
> want to hunt for large allocations.
> In an ideal life i'd prefer this check/warning is enabled by default and may be
> even without a config option so it works on every node. Once we find and rework
> or mark all large allocations that would be good by default. Until that though
> it will be noisy.

So who is going to enable this option?

> Another option is to rework the patch via static keys (having the warning
> disabled by default surely). That makes it possible to turn on the feature
> without recompiling the kernel - during testing period for example.
> 
> If you prefer this way, i would be happy to rework the patch via static keys.

I would rather go and chase the underlying issue. So can we get an
actual data please?

-- 
Michal Hocko
SUSE Labs
