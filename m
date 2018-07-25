Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ABAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8483920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GT1qhwA1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FChmCGjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8483920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeGYFYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:24:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeGYFYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:24:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1317B605A4; Wed, 25 Jul 2018 04:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532492106;
        bh=evyLnhQsqTF5OXSZplcP1S0wcZft0uhpp5xUS2tMANY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GT1qhwA16oRNf6+vcWQgSS0G1hQb2U2GJMRf3OfrINmPOpHJQSESE5c4Nzw/wNvFI
         2rV9YTUNPHfBC/njC77BiB/rhIVobDjWQGK2tJCM1bZD3KnYUrgHcMTtIGNMKJpQyL
         maACA4LOEzlg4p9zQls0iHWEGnK/VTDtyxYaoqLo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2EB69605A4;
        Wed, 25 Jul 2018 04:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532492105;
        bh=evyLnhQsqTF5OXSZplcP1S0wcZft0uhpp5xUS2tMANY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FChmCGjDVvdcCaj+0g0Xrmk45alQSFG9wu+KpzCwko2KaW38y/uGiyXFo29YyFHFF
         F4lWSgLWRZHS06+XI1yh48ibCrKAlfZX07vqAwXyQBiJiXT0n695IMHsKPyDMszpfv
         C2sOBlfhMMdCRpejbRTfY7XJWwjz59cPjhx+Tf+c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Jul 2018 21:15:05 -0700
From:   isaacm@codeaurora.org
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, gregkh@linuxfoundation.org,
        pkondeti@codeaurora.org, stable@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Disable preemption after queueing stopper
 threads
In-Reply-To: <20180724062350.nlem2suuy5wlxpts@linutronix.de>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
 <a30d1e147d3181fc7b294262e380a10c@codeaurora.org>
 <20180724062350.nlem2suuy5wlxpts@linutronix.de>
Message-ID: <9d89ec1c84546e7b8044b3d2b24fc175@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thanks for the response.

"I haven't look in detail at this but your new preempt_disable() makes
things unbalanced for the err != 0 case."

This cannot happen. The only possible return values of this function
are -ENOENT or 0.

In the case where we return -ENOENT, we'll go
straight to "unlock," which releases the two locks being held, but
doesn't disable preemption, and since err != we won't call
preemption_enable.

In the case where we return 0, then that means the works were queued
successfully, and preemption was disabled, and we'll fall into the
if branch, after releasing the locks, and enable preemption, which is
correct.

In either case, there is no imbalance between the 
preemption_[disable/enable]
calls.

Thanks,
Isaac Manjarres

On 2018-07-23 23:23, Sebastian Andrzej Siewior wrote:
> On 2018-07-23 18:13:48 [-0700], isaacm@codeaurora.org wrote:
>> Hi all,
> Hi,
> 
>> Are there any comments about this patch?
> 
> I haven't look in detail at this but your new preempt_disable() makes
> things unbalanced for the err != 0 case.
> 
>> Thanks,
>> Isaac Manjarres
> 
> Sebastian
