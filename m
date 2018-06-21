Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E16C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC8C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC8C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbeFUDnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:43:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48370 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeFUDnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:43:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fVqVU-0000gn-1A; Thu, 21 Jun 2018 03:43:36 +0000
Date:   Thu, 21 Jun 2018 04:43:36 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        Greg KH <gregkh@linuxfoundation.org>, tchibo@google.com,
        aryabinin@virtuozzo.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] kernel: kcov: a possible sleep-in-atomic-context bug in
 kcov_ioctl()
Message-ID: <20180621034335.GT30522@ZenIV.linux.org.uk>
References: <ca2e4f0b-dd08-8d66-51e3-05cc69e15d65@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca2e4f0b-dd08-8d66-51e3-05cc69e15d65@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:20:59AM +0800, Jia-Ju Bai wrote:
> The kernel may sleep with holding a spinlock.
> The function call path (from bottom to top) in Linux-4.16.7 is:
> 
> [FUNC] vfree --> can sleep
> kernel/kcov.c, 237: vfree in kcov_put
> kernel/kcov.c, 396: kcov_put in kcov_ioctl_locked
> kernel/kcov.c, 410: kcov_ioctl_locked in kcov_ioctl
> kernel/kcov.c, 409: spin_lock in kcov_ioctl
> 
> This bug is found by my static analysis tool (DSAC-2) and checked by my
> code review.
> 
> I do not know how to correctly fix this bug, so I just report them.

Assuming it's a bug in the first place, that is.  Note that
	* we never modify task->kcov for task != current
	* task->kcov contributes to refcount
	* opened file contributes to refcount
	* that kcov_put() of yours happens from ->ioctl() and removes
current->kcov reference; it *can't* be the last reference - the one
held by struct file used to call ->ioctl() is also there.

IOW, it's a false positive.
