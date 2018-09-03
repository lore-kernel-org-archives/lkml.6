Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FEDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6C520856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6C520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeIDDoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:44:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIDDoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:44:39 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD68DBBD;
        Mon,  3 Sep 2018 23:22:16 +0000 (UTC)
Date:   Mon, 3 Sep 2018 16:22:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ktsanaktsidis@zendesk.com
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Michal Hocko <mhocko@suse.cz>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] fork: report pid exhaustion correctly
Message-Id: <20180903162215.3069867de3ed953ae1484e06@linux-foundation.org>
In-Reply-To: <20180903111016.46461-1-ktsanaktsidis@zendesk.com>
References: <20180903111016.46461-1-ktsanaktsidis@zendesk.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Sep 2018 04:10:16 -0700 ktsanaktsidis@zendesk.com wrote:

> From: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
> 
> Make the clone and fork syscalls return EAGAIN when the limit on the
> number of pids /proc/sys/kernel/pid_max is exceeded.
> 
> Currently, when the pid_max limit is exceeded, the kernel will return
> ENOSPC from the fork and clone syscalls. This is contrary to the
> documented behaviour, which explicitly calls out the pid_max case as one
> where EAGAIN should be returned. It also leads to really confusing error
> messages in userspace programs which will complain about a lack of disk
> space when they fail to create processes/threads for this reason.
> 
> This error is being returned because the alloc_pid function uses the idr
> api to find a new pid; when there are none available, idr_alloc_cyclic
> is returns -ENOSPC, and this is being propagated back into userspace.
> 
> This behaviour has been broken before, and was explicitly fixed in
> commit 35f71bc0a09a ("fork: report pid reservation failure properly"),
> so I think -EAGAIN is definitely the right thing to return in this case.
> The current behaviour change dates from commit 95846ecf9dac ("pid:
> replace pid bitmap implementation with IDR AIP") and was I believe
> unintentional.
> 
> This patch has no impact on the case where allocating a pid fails
> because the child reaper for the namespace is dead; that case will still
> return -ENOMEM.

Thanks.  First ever kernel patch?  It was a damn good one!

> Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR AIP")
> Signed-off-by: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>

I'll add cc:stable here so the fix gets backported into earlier kernels

