Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4403C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7C520A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7C520A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeHYCmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:42:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36244 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeHYCmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:42:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ftL9J-0008Vs-7t; Fri, 24 Aug 2018 23:05:49 +0000
Date:   Sat, 25 Aug 2018 00:05:49 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Eric Wong <normalperson@yhbt.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] pipe: prevent compiler reordering in pipe_poll
Message-ID: <20180824230549.GP6515@ZenIV.linux.org.uk>
References: <20180824225431.tpaxuck7idgnj3b7@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824225431.tpaxuck7idgnj3b7@dcvr>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:54:31PM +0000, Eric Wong wrote:
> The pipe_poll function does not use locks, and adding an entry
> to the waitqueue is not guaranteed to happen before pipe->nrbufs
> (or other fields) are read, leading to missed wakeups.
> 
> Looking at Ruby CI build logs and backtraces, I've noticed
> occasional instances where processes are stuck in select(2) or
> ppoll(2) with a pipe.
> 
> I don't have access to the systems where this is happening to
> test/reproduce the problem, and haven't been able to reproduce
> it locally on less-powerful hardware, either.  However, it seems
> like a problem based on similar comments in
> fs/eventfd.c::eventfd_poll made by Paolo.

You are misinterpreting those comments.  That load *can't* migrate
to anything earlier than taking queue lock, since that acts as
an acquire barrier.  READ_ONCE in eventfd_poll() is not to prevent
compiler reordering - it's to prevent insane compiler doing multiple
loads on possibly changing variable (ctx->count there).
