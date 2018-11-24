Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA104C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C44205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="qmqhAm1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C44205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeKYGEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:04:54 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:37914 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeKYGEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:04:53 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D560F47A67C;
        Sat, 24 Nov 2018 20:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1543086945;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qU36QWKxefo84ZnAJ7PbSAPL4RuwqtNYWsDCd3cnAZ4=;
        b=qmqhAm1YTsSgzjUfbTnxDLo27rkWl4ytpv4pQ//eviWCYjNfKywD2pCRMh6lc3klJEzjMz
        ypBznQoT1hfFenC0SMJsG0MTmIsI7Okw8bx0bjpHLXiAWQIV6D/VZ/eQnf4XwQSRpuMGi0
        1IRlU+b2p2YX2VDokYxnNZ7y3y1AsRY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 24 Nov 2018 20:15:45 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Subject: Re: WARN_ON() in netconsole with PREEMPT_RT
In-Reply-To: <20181111210105.7f376c35@vmware.local.home>
References: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
 <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
 <20181111210105.7f376c35@vmware.local.home>
Message-ID: <f479ed5153809ad643cbcf988d76585b@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1543086945;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qU36QWKxefo84ZnAJ7PbSAPL4RuwqtNYWsDCd3cnAZ4=;
        b=QhdfbK6/KTDx8ma2SQFqFUzTXOohMoA1hctWC29n7DDo+aTFlUhb9+wQwEfvV/Gt6FaoSh
        uLusfjthqbbRQAW5+bQaKspEqmZE10sHdFyWEDP2n/Z17WTCcy0S2Ky7A3qKlyHjt5kQSl
        Xhm+Gpkfz2qW/BBxKohxG2GtyaXZXwU=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1543086945; a=rsa-sha256;
        cv=none;
        b=A/qJelJEaQwKxOvfZ75US1x2lzBcHITKicLnYTP71/M5h6/7gG0qEtvZAaKTzGnCfxYkpV
        o6FDbeJzYGgU8wOhZpfVh1EA7iF6VdECxCuZqbKfe+uMmn1mA9mE6kQ73mVKA3iEFKKocD
        Es90VkqqJALbHrKv30UJR4vQXQsow20=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 12.11.2018 03:01, Steven Rostedt wrote:
> On Sun, 11 Nov 2018 21:16:00 +0100
> Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
>> Oh, I see that write_msg() calls netpoll_send_udp() under
>> spin_lock_irqsave(), but in PREEMPT_RT this, AFAIK, does not disable
>> interrupts.
>> 
>> So, the real question here is whether the interrupts should be indeed
>> disabled. And if so, -rt should replace spin_lock_irqsave() call there
>> with what? local_irq_save()? and get rid of the warning?
>> 
> 
> Why do we care if interrupts are disabled with PREEMPT_RT here?

I don't know, if you ask me. But the check was added intentionally with 
c9fd56b34efd0, so the author had definitely something on his mind. 
Cc'ing him.

> printk() itself has a lot of issues with PREEMPT_RT that we are working
> on dealing with. Right now netconsole is actually at the end of that
> todo list.

OK, I see.

-- 
   Oleksandr Natalenko (post-factum)
