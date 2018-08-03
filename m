Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C24C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3312178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eM/fxtgO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cAfwhetZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3312178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeHCUy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:54:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHCUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:54:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 69A92606AC; Fri,  3 Aug 2018 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533322644;
        bh=H9RBKus/Nz9f9wTR4WXVqIPEF4TzraGWqCzhFdHYC7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eM/fxtgOq5mCw3AT2RpmtHtFy0WDXFyGnvSptMJj7k72KyyKS9RFzwvJW26T6GPOr
         M8HP85VruDgo4nOmtgmWvz+WwQZ8U4ZUjjFbHlmcAkwYrJriutQx6hoptinuP6/13P
         N3Ndi9VkqRVYjBWvHCmqW5PNhXpYQtYJsbDM1hG0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BCC4E60224;
        Fri,  3 Aug 2018 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533322643;
        bh=H9RBKus/Nz9f9wTR4WXVqIPEF4TzraGWqCzhFdHYC7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cAfwhetZe8C63fxWJpkJCGNusAhpdcUgmqJYYKTvpUY7iQNsuRrERhSR732siHxxX
         H7coPRaM9h+T98ppz3e3G9RFEOumfx+zm8WxxUJZu1dddlgZeoVEfO4jBiHvYxnk/r
         loQ3neQNNR+IZHgoJKgcUjjafxBbM/n/H+uMOjMk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Aug 2018 11:57:23 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        isaacm@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: cpu stopper threads and setaffinity leads to deadlock
In-Reply-To: <alpine.DEB.2.21.1808031340500.1745@nanos.tec.linutronix.de>
References: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
 <20180802094908.GK2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1808031340500.1745@nanos.tec.linutronix.de>
Message-ID: <712493a7926b0f58543be052ced95db9@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 04:41, Thomas Gleixner wrote:
> Prasad.
> 
> On Thu, 2 Aug 2018, Peter Zijlstra wrote:
>> 
>> So why didn't you do the 'obvious' parallel to what you did for
>> cpu_stop_queue_two_works(), namely:
> 
> Is that patch fixing the issue for you?
<Prasad> Hi Thomas and Peter,

Yes. Tested both versions of patches and both variants are working on 
Qualcomm devices
with stress testing of set affinity and tasks cross-migration, which 
were previously leading to the deadlock.

-Thanks, Prasad
> 
>> --- a/kernel/stop_machine.c
>> +++ b/kernel/stop_machine.c
>> @@ -81,6 +81,7 @@ static bool cpu_stop_queue_work(unsigned
>>  	unsigned long flags;
>>  	bool enabled;
>> 
>> +	preempt_disable();
>>  	raw_spin_lock_irqsave(&stopper->lock, flags);
>>  	enabled = stopper->enabled;
>>  	if (enabled)
>> @@ -90,6 +91,7 @@ static bool cpu_stop_queue_work(unsigned
>>  	raw_spin_unlock_irqrestore(&stopper->lock, flags);
>> 
>>  	wake_up_q(&wakeq);
>> +	preempt_enable();
>> 
>>  	return enabled;
>>  }
>> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
