Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228D21019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7228D21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeK2KjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:39:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeK2KjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:39:20 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8EDAB4A;
        Wed, 28 Nov 2018 23:36:00 +0000 (UTC)
Date:   Wed, 28 Nov 2018 15:35:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 5/7] zram: support idle/huge page writeback
Message-Id: <20181128153559.f6645b98a7033b6f6f6b0fbc@linux-foundation.org>
In-Reply-To: <20181127055429.251614-6-minchan@kernel.org>
References: <20181127055429.251614-1-minchan@kernel.org>
        <20181127055429.251614-6-minchan@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 14:54:27 +0900 Minchan Kim <minchan@kernel.org> wrote:

> This patch supports new feature "zram idle/huge page writeback".
> On zram-swap usecase, zram has usually many idle/huge swap pages.
> It's pointless to keep in memory(ie, zram).
> 
> To solve the problem, this feature introduces idle/huge page
> writeback to backing device so the goal is to save more memory
> space on embedded system.
> 
> Normal sequence to use idle/huge page writeback feature is as follows,
> 
> while (1) {
>         # mark allocated zram slot to idle
>         echo all > /sys/block/zram0/idle
>         # leave system working for several hours
>         # Unless there is no access for some blocks on zram,
> 	# they are still IDLE marked pages.
> 
>         echo "idle" > /sys/block/zram0/writeback
> 	or/and
> 	echo "huge" > /sys/block/zram0/writeback
>         # write the IDLE or/and huge marked slot into backing device
> 	# and free the memory.
> }
> 
> By per discussion:
> https://lore.kernel.org/lkml/20181122065926.GG3441@jagdpanzerIV/T/#u,
> 
> This patch removes direct incommpressibe page writeback feature
> (d2afd25114f4, zram: write incompressible pages to backing device)
> so we could regard it as regression because incompressible pages
> doesn't go to backing storage automatically. Instead, usre should
> do it via "echo huge" > /sys/block/zram/writeback" manually.

I'm not in any position to determine the regression risk here.

Why is that feature being removed, anyway?

> If we hear some regression, we could restore the function.

Why not do that now?


