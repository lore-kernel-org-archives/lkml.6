Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5872C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EBA206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EBA206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbeKVJKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:10:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbeKVJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:10:31 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 675AC86B;
        Wed, 21 Nov 2018 22:34:09 +0000 (UTC)
Date:   Wed, 21 Nov 2018 14:34:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@kernel.org, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linuxdrivers@attotech.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3 1/6] atomics: add common header generation files
Message-Id: <20181121143408.b91c15aff4206a162f9650f6@linux-foundation.org>
In-Reply-To: <20181116025112.xhbfei677awm77ji@blommer>
References: <20180904104830.2975-1-mark.rutland@arm.com>
        <20180904104830.2975-2-mark.rutland@arm.com>
        <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
        <20181116025112.xhbfei677awm77ji@blommer>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 02:51:21 +0000 Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Andrew,
> 
> On Thu, Nov 15, 2018 at 03:10:48PM -0800, Andrew Morton wrote:
> > On Tue,  4 Sep 2018 11:48:25 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > To minimize repetition, to allow for future rework, and to ensure
> > > regularity of the various atomic APIs, we'd like to automatically
> > > generate (the bulk of) a number of headers related to atomics.
> > > 
> > > This patch adds the infrastructure to do so, leaving actual conversion
> > > of headers to subsequent patches.
> > 
> > This thing is appallingly slow.  `sh scripts/atomic/check-atomics.sh'
> > takes 8 seconds on a machine which builds an allnoconfig kernel in 30
> > seconds.
> 
> Hmm... on my laptop it's less than half that, and allnoconfig takes ~35s, so
> clearly there's a major difference between our setups.

check-atomics.sh is (was) single-threaded, so the relative pain factor
will increase with the number of cores.

> For reference, which distro are you using, and what is /bin/sh on your box?

I forget :) - I can't get at that machine from here.  Recentish
Ubuntu(ish) on a 12-core.

It seems to be partially fixed in today's linux-next?  On this 12-core
Ubuntu 17.10 bash-4.4-5ubuntu1 box the delta is 25.9s -> 27.2s.

But my one-liner remains cruelly unapplied so the build still generates
errors.  All that seems to have changed today is that the -EPERM is simply
dropped on the floor rather than terminating the build.

