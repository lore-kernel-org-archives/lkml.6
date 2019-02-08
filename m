Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06340C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C940A20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfBHRBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:01:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:48620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727139AbfBHRBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:01:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32F09AF1B;
        Fri,  8 Feb 2019 17:01:49 +0000 (UTC)
Date:   Fri, 8 Feb 2019 09:01:37 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch V2 0/2] genirq, proc: Speedup /proc/stat interrupt
 statistics
Message-ID: <20190208170137.7w63kmg56ltjomsj@linux-r8p5>
References: <20190208134802.218483159@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190208134802.218483159@linutronix.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Feb 2019, Thomas Gleixner wrote:

>Waiman reported that on large systems with a large amount of interrupts the
>readout of /proc/stat takes a long time to sum up the interrupt
>statistics. In principle this is not a problem. but for unknown reasons
>some enterprise quality software reads /proc/stat with a high frequency.

:)

>
>The reason for this is that interrupt statistics are accounted per cpu. So
>the /proc/stat logic has to sum up the interrupt stats for each interrupt.
>
>The following series addresses this by making the interrupt statitics code
>in the core generate the sum directly and by making the loop in the
>/proc/stat read function smarter.
>
>V1 -> V2: Address review feedback: undo struct layout changes, make
>      	  variables unsigned and add test results to the changelog.
>
>Thanks,
>
>        tglx
>
>8<----------------
> fs/proc/stat.c          |   29 ++++++++++++++++++++++++++---
> include/linux/irqdesc.h |    1 +
> kernel/irq/chip.c       |   12 ++++++++++--
> kernel/irq/internals.h  |    8 +++++++-
> kernel/irq/irqdesc.c    |    7 ++++++-
> 5 files changed, 50 insertions(+), 7 deletions(-)

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
