Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A5DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F07F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cF/FvmTl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h/jCjWE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F07F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeGQUIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:08:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeGQUIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:08:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0AB396063A; Tue, 17 Jul 2018 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531856075;
        bh=wp+DXpmCNUDdSt/saUxden3kTeprGvOgqYqiZmJZI10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cF/FvmTlUoqwsgou1UbdHKH2MsXPZjr5KdjiHuoPuDn7MWQ4Ozlhv6Ue+xvQoxwTc
         UwF8XFOH3tF5qp+Taf2T7IujETA7W4uuDBoawLd4gGFhv5PEEwWUMfr6WJaCTZPNJf
         rCYW/9uuWrIP2rXEbEvRtlInnxMQsCGaOJaTGIrw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 56FA46063A;
        Tue, 17 Jul 2018 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531856074;
        bh=wp+DXpmCNUDdSt/saUxden3kTeprGvOgqYqiZmJZI10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h/jCjWE2Bnc2ktG0Txeqa2D3w2sUBtOmt/fYj4/Ccugp4qzXPKvbkB7Mrs481TR+C
         LtZppkLoJjQhkWzBIVqr9LnNgrsHWsFL9s79BIWqTTlE4E15cvN9b+hfChxUCuUltS
         Bd5PIEcZMmZgftd6cRRIsiRzxI0prtdP7lMNyeUU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Jul 2018 12:34:34 -0700
From:   isaacm@codeaurora.org
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     matt@codeblueprint.co.uk, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, gregkh@linuxfoundation.org,
        pkondeti@codeaurora.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] stop_machine: Disable preemption after queueing
 stopper threads
In-Reply-To: <20180717183450.GL2494@hirez.programming.kicks-ass.net>
References: <1531845017-19935-1-git-send-email-isaacm@codeaurora.org>
 <20180717183450.GL2494@hirez.programming.kicks-ass.net>
Message-ID: <df84aa9229cf0789fd4f729b06161be9@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, we will make a new patch for this. Thanks for the feedback.

Thanks,
Isaac Manjarres
On 2018-07-17 11:34, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 09:30:17AM -0700, Isaac J. Manjarres wrote:
>> After cpu_stop_queue_two_works() queues the cpu_stop works
>> for the stopper threads, it releases the locks held for
>> both threads, which enables preemption, which allows the
>> following race condition to occur:
> 
> 
> Does not apply because an earlier version is already applied.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/kernel/stop_machine.c?id=9fb8d5dc4b649dd190e1af4ead670753e71bf907
> 
> if there still is a problem, please send a new patch that describes the
> remaining problem.
