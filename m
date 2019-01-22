Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69098C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3766E21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfAVOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:42:22 -0500
Received: from foss.arm.com ([217.140.101.70]:54672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfAVOmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2268A78;
        Tue, 22 Jan 2019 06:42:21 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8788B3F589;
        Tue, 22 Jan 2019 06:42:20 -0800 (PST)
Subject: Re: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     'Mark Rutland' <mark.rutland@arm.com>,
        "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
From:   James Morse <james.morse@arm.com>
Message-ID: <d8a8107c-cd31-2517-79df-2ebfbbedb7da@arm.com>
Date:   Tue, 22 Jan 2019 14:42:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 22/01/2019 02:05, Zhang, Lei wrote:
> Mark Rutland wrote:
>> * How often does this fault occur?
> In my test, this fault occurs once every several times
> in the OS boot sequence, and after the completion of OS boot,
> this fault have never occurred.
> In my opinion, this fault rarely occurs
> after the completion of OS boot.

Can you share anything about why this is? You mention a hardware-condition
that is reset at exception entry....


>> I'm a bit surprised by the single retry. Is there any guarantee that a
>> thread will eventually stop delivering this fault code?

> I guarantee that a thread will stop delivering this 
> fault code by the this patch.
> The hardware condition which cause this fault is 
> reset at exception entry, therefore execution of at 
> least one instruction is guaranteed by this single retry.

... so its possible to take this fault during kernel_entry when we've taken an irq?

This will overwrite the ELR and SPSR, (and possibly the FAR and ESR), meaning we've
 lost that information and can't return to the point in the kernel that took the
irq.

If we try, we might end up spinning through the irq handler, as the ELR might
now point
to el1_irq's kernel_entry.

We can spot we took an exception from the entry text ... but all we can do then
is panic().
I'm not sure its worth working around this if its just a matter of time before this
happens. (you mention its less likely after boot, it would be good to know why...)


Thanks,

James
