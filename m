Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBAC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCC62086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCC62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbeKGHnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:43:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeKGHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:43:08 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78F4049F;
        Tue,  6 Nov 2018 22:15:43 +0000 (UTC)
Date:   Tue, 6 Nov 2018 14:15:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Skidanov <alexey.skidanov@intel.com>
Cc:     sbates@raithlin.com, logang@deltatee.com, danielmentz@google.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        labbott@redhat.com
Subject: Re: [PATCH] lib/genaloc: Fix allocation of aligned buffer from
 non-aligned chunk
Message-Id: <20181106141542.08a9d7de30a439ec9fe50486@linux-foundation.org>
In-Reply-To: <1541506853-10685-1-git-send-email-alexey.skidanov@intel.com>
References: <1541506853-10685-1-git-send-email-alexey.skidanov@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Nov 2018 14:20:53 +0200 Alexey Skidanov <alexey.skidanov@intel.com> wrote:

> On success, gen_pool_first_fit_align() returns the bit number such that
> chunk_start_addr + (bit << order) is properly aligned. On failure,
> the bitmap size parameter is returned.
> 
> When the chunk_start_addr isn't aligned properly, the
> chunk_start_addr + (bit << order) isn't aligned too.
> 
> To fix this, gen_pool_first_fit_align() takes into account
> the chunk_start_addr alignment and returns the bit value such that
> chunk_start_addr + (bit << order) is properly aligned
> (exactly as it done in CMA).
> 
> ...
>
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
>
> ...
>
> +		struct gen_pool *pool, unsigned long start_add)
>
> ...
>
> +		struct gen_pool *pool, unsigned long start_add)
>
> ...
>
> +		struct gen_pool *pool, unsigned long start_add)
>
> ...
>

We have three typos here.  Which makes me wonder why we're passing the
new argument and then not using it?
