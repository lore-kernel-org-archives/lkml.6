Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F00C208EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F00C208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeHUAl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:41:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:41:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A2F7CB6;
        Mon, 20 Aug 2018 21:24:41 +0000 (UTC)
Date:   Mon, 20 Aug 2018 14:24:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     tglx@linutronix.de, joe@perches.com, arnd@arndb.de,
        mhocko@suse.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Message-Id: <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
In-Reply-To: <20180820085516.9687-1-osalvador@techadventures.net>
References: <20180820085516.9687-1-osalvador@techadventures.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 10:55:16 +0200 Oscar Salvador <osalvador@techadventures.net> wrote:

> From: Oscar Salvador <osalvador@suse.de>
> 
> Currently, NODEMASK_ALLOC allocates a nodemask_t with kmalloc when
> NODES_SHIFT is higher than 8, otherwise it declares it within the stack.
> 
> The comment says that the reasoning behind this, is that nodemask_t will be
> 256 bytes when NODES_SHIFT is higher than 8, but this is not true.
> For example, NODES_SHIFT = 9 will give us a 64 bytes nodemask_t.
> Let us fix up the comment for that.
> 
> Another thing is that it might make sense to let values lower than 128bytes
> be allocated in the stack.
> Although this all depends on the depth of the stack
> (and this changes from function to function), I think that 64 bytes
> is something we can easily afford.
> So we could even bump the limit by 1 (from > 8 to > 9).
> 

I agree.  Such a change will reduce the amount of testing which the
kmalloc version receives, but I assume there are enough people out
there testing with large NODES_SHIFT values.

And while we're looking at this, it would be nice to make NODES_SHIFT
go away.  Ensure that CONFIG_NODES_SHIFT always has a setting and use
that directly.


