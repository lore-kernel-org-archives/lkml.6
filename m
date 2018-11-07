Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA26CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D5420882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D5420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeKHHpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:45:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKHHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:45:09 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 268B0B37;
        Wed,  7 Nov 2018 22:12:46 +0000 (UTC)
Date:   Wed, 7 Nov 2018 14:12:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Skidanov <alexey.skidanov@intel.com>
Cc:     sbates@raithlin.com, logang@deltatee.com, danielmentz@google.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        labbott@redhat.com
Subject: Re: [PATCH] lib/genaloc: Fix allocation of aligned buffer from
 non-aligned chunk
Message-Id: <20181107141244.624161486d7b187eb02b714a@linux-foundation.org>
In-Reply-To: <fa2b502b-13a1-2f93-02aa-de1121b6e602@intel.com>
References: <1541506853-10685-1-git-send-email-alexey.skidanov@intel.com>
        <20181106141542.08a9d7de30a439ec9fe50486@linux-foundation.org>
        <fa2b502b-13a1-2f93-02aa-de1121b6e602@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 08:27:31 +0200 Alexey Skidanov <alexey.skidanov@intel.com> wrote:

> 
> 
> On 11/7/18 12:15 AM, Andrew Morton wrote:
> > On Tue,  6 Nov 2018 14:20:53 +0200 Alexey Skidanov <alexey.skidanov@intel.com> wrote:
> > 
> >> On success, gen_pool_first_fit_align() returns the bit number such that
> >> chunk_start_addr + (bit << order) is properly aligned. On failure,
> >> the bitmap size parameter is returned.
> >>
> >> When the chunk_start_addr isn't aligned properly, the
> >> chunk_start_addr + (bit << order) isn't aligned too.
> >>
> >> To fix this, gen_pool_first_fit_align() takes into account
> >> the chunk_start_addr alignment and returns the bit value such that
> >> chunk_start_addr + (bit << order) is properly aligned
> >> (exactly as it done in CMA).
> >>
> >> ...
> >>
> >> --- a/include/linux/genalloc.h
> >> +++ b/include/linux/genalloc.h
> >>
> >> ...
> >>
> >> +		struct gen_pool *pool, unsigned long start_add)
> >>
> >> ...
> >>
> >> +		struct gen_pool *pool, unsigned long start_add)
> >>
> >> ...
> >>
> >> +		struct gen_pool *pool, unsigned long start_add)
> >>
> >> ...
> >>
> > 
> > We have three typos here.  Which makes me wonder why we're passing the
> > new argument and then not using it?
> > 
> genpool uses allocation callbacks function that implement some
> allocation strategy - bes fit, first fit, ... All of them has the same
> type. The added chunk start_addr is used only in one of them -
> gen_pool_first_fit_align()

OK, but the argument name here is start_add, not start_addr.
