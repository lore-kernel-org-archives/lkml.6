Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE9C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EDD25B21
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EDD25B21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeF1CKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:10:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbeF1CKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:10:43 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CABB9CA1;
        Thu, 28 Jun 2018 02:10:42 +0000 (UTC)
Date:   Wed, 27 Jun 2018 19:10:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ufo19890607@gmail.com
Cc:     mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v10 2/2] Refactor part of the oom report in dump_header
Message-Id: <20180627191041.509893a3b43f95a27df32266@linux-foundation.org>
In-Reply-To: <1529763171-29240-2-git-send-email-ufo19890607@gmail.com>
References: <1529763171-29240-1-git-send-email-ufo19890607@gmail.com>
        <1529763171-29240-2-git-send-email-ufo19890607@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 22:12:51 +0800 ufo19890607@gmail.com wrote:

> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The current system wide oom report prints information about the victim
> and the allocation context and restrictions. It, however, doesn't
> provide any information about memory cgroup the victim belongs to. This
> information can be interesting for container users because they can find
> the victim's container much more easily.
> 
> I follow the advices of David Rientjes and Michal Hocko, and refactor
> part of the oom report. After this patch, users can get the memcg's
> path from the oom report and check the certain container more quickly.
> 
> The oom print info after this patch:
> oom-kill:constraint=<constraint>,nodemask=<nodemask>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<commm>,pid=<pid>,uid=<uid>
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
> Below is the part of the oom report in the dmesg
> ...
> [  134.873392] panic invoked oom-killer: gfp_mask=0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), nodemask=(null), order=0, oom_score_adj=0
>
> ...
>
> [  134.873480] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),task_memcg=/test/test1/test2,task=panic,pid= 8669,  uid=    0

We're displaying nodemask twice there.  Avoidable?

Also, the spaces after pid= and uid= don't seem useful.  Why not use
plain old %d?


