Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB831C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5D820875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5D820875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756829AbeFSJW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:22:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43045 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756453AbeFSJW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:22:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C6EC7AD5E;
        Tue, 19 Jun 2018 09:22:55 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 4CBCFA0A1B; Tue, 19 Jun 2018 11:22:55 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:22:55 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: regression: /proc/$pid/cmdline lacks trailing '\0' in 4.18-rc1
Message-ID: <20180619092254.kmww3fpqjqcsjrna@unicorn.suse.cz>
References: <20180619060754.voy2nziqwl5ehfp5@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619060754.voy2nziqwl5ehfp5@unicorn.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 08:07:55AM +0200, Michal Kubecek wrote:
> In v4.18-rc1, /proc/$pid/cmdline is missing final null byte which used
> to be there in v4.17 and older kernels:
> 
> 4.17.1:
> tweed:~ # cat /proc/self/cmdline | od -t c
> 0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
> 0000020   m   d   l   i   n   e  \0
> 0000027
> 
> 4.18-rc1:
> lion:~ # cat /proc/self/cmdline | od -t c
> 0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
> 0000020   m   d   l   i   n   e
> 0000026
> 
> The code has been rewritten quite a lot in 4.18-rc1 so I didn't find yet
> where exactly does the change come from. Still looking.

The issue was introduced by commit 5ab827189965 ("fs/proc: simplify and
clarify get_mm_cmdline() function"). The problem is that when looking
for the null character at or after args_end, strnlen() is used and it
returns the length _without_ the null character (if there is one) so
that we don't copy it.

I'll submit a patch once I test it.

Michal Kubecek
