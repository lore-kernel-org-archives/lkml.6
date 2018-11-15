Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C279C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFBE208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFBE208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeKPHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:47:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:47:09 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5E5FC75;
        Thu, 15 Nov 2018 21:37:36 +0000 (UTC)
Date:   Thu, 15 Nov 2018 13:37:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
Message-Id: <20181115133735.bb0313ec9293c415d08be550@linux-foundation.org>
In-Reply-To: <20181114235040.36180-1-richard.weiyang@gmail.com>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 07:50:40 +0800 Wei Yang <richard.weiyang@gmail.com> wrote:

> For one zone, there are three digits to describe its space range:
> 
>     spanned_pages
>     present_pages
>     managed_pages
> 
> The detailed meaning is written in include/linux/mmzone.h. This patch
> concerns about the last two.
> 
>     present_pages is physical pages existing within the zone
>     managed_pages is present pages managed by the buddy system
> 
> >From the definition, managed_pages is a more strict condition than
> present_pages.
> 
> There are two functions using zone's present_pages as a boundary:
> 
>     populated_zone()
>     for_each_populated_zone()
> 
> By going through the kernel tree, most of their users are willing to
> access pages managed by the buddy system, which means it is more exact
> to check zone's managed_pages for a validation.
> 
> This patch replaces those checks on present_pages to managed_pages by:
> 
>     * change for_each_populated_zone() to for_each_managed_zone()
>     * convert for_each_populated_zone() to for_each_zone() and check
>       populated_zone() where is necessary
>     * change populated_zone() to managed_zone() at proper places
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> 
> ---
> 
> Michal, after last mail, I did one more thing to replace
> populated_zone() with managed_zone() at proper places.
> 
> One thing I am not sure is those places in mm/compaction.c. I have
> chaged them. If not, please let me know.
> 
> BTW, I did a boot up test with the patched kernel and looks smooth.

Seems sensible, but a bit scary.  A basic boot test is unlikely to
expose subtle gremlins.

Worse, the situations in which managed_zone() != populated_zone() are
rare(?), so it will take a long time for problems to be discovered, I
expect.

I'll toss it in there for now, let's see who breaks :(

