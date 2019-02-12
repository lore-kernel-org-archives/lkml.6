Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D085C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01865222C8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfBLU4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:56:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfBLU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:56:37 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2EB90E5C0;
        Tue, 12 Feb 2019 20:56:36 +0000 (UTC)
Date:   Tue, 12 Feb 2019 12:56:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] proc, oom: do not report alien mms when setting
 oom_score_adj
Message-Id: <20190212125635.27742b5741e92a0d47690c53@linux-foundation.org>
In-Reply-To: <20190212102129.26288-1-mhocko@kernel.org>
References: <20190212102129.26288-1-mhocko@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 11:21:29 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> Tetsuo has reported that creating a thousands of processes sharing MM
> without SIGHAND (aka alien threads) and setting
> /proc/<pid>/oom_score_adj will swamp the kernel log and takes ages [1]
> to finish. This is especially worrisome that all that printing is done
> under RCU lock and this can potentially trigger RCU stall or softlockup
> detector.
> 
> The primary reason for the printk was to catch potential users who might
> depend on the behavior prior to 44a70adec910 ("mm, oom_adj: make sure
> processes sharing mm have same view of oom_score_adj") but after more
> than 2 years without a single report I guess it is safe to simply remove
> the printk altogether.
> 
> The next step should be moving oom_score_adj over to the mm struct and
> remove all the tasks crawling as suggested by [2]
> 
> [1] http://lkml.kernel.org/r/97fce864-6f75-bca5-14bc-12c9f890e740@i-love.sakura.ne.jp
> [2] http://lkml.kernel.org/r/20190117155159.GA4087@dhcp22.suse.cz

I think I'll put a cc:stable on this.  Deleting a might-trigger debug
printk is safe and welcome.
