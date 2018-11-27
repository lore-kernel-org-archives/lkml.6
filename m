Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9829120817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4qIDpMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9829120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbeK0V2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:28:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36483 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeK0V2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:28:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so14248914qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QhI+jefUxnTJyLDvT+SRiOu9/spdAQfzk8fqnU+B7i4=;
        b=K4qIDpMrTB4PnAlCxRRcoKiypzn7rfHGfDSj14MHoIY7cK8T0z44LcCaU4eh20FwH1
         1WQrUK0tIhzB51ZZVeUJQbssh7+NoKH9+ExGjjL3u+TxoAQS81mT5rpT54Chq/rzx57s
         TpsK8D/u+m/fzqhRgQ6xW+iU2gTItGfeaDRGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QhI+jefUxnTJyLDvT+SRiOu9/spdAQfzk8fqnU+B7i4=;
        b=OLCvo8OxsHmSuA+wH3+23/ggW0Bb4WnAFbZKwdoJnFKma7qdWwABHhEqFbw8lVS5uY
         vAtOX3MuB/OzfhNR4BboqvGb3jARIDZwYAbM3yTgqA7Py0KBOvM2y0lvcuHY39bPu3oO
         ZMR2RPt/D0eMelSVgjTYv9RjrKSKnbTmguYrxtDXNxjOLwwNRLNbXpYEmGd8rooXKlne
         RGQhI9uMT9vY3ql05DX1keX/jEIuX209MVzG6xUOYUtTagFJ6SMXBnEioo+4xBcRjgTd
         BF79FUd942g8DIHVD3Z+JbtbDYpliScKYcHXK/1JfsKXzKcG2gwddZIczNzCqZRtCp8u
         tfRQ==
X-Gm-Message-State: AA+aEWaxzo2EgHiCOvzD36SVs0OJEV2ufXB7DEoyl020zCoKeN2lMmkS
        rVt8KFs76kjwTgk39TIK78qHgA==
X-Google-Smtp-Source: AFSGD/VdxLZXwlce5+fGdjSUrjC9jV8yGQwPCHkfGApUTR1w02WEhCEsSfUq1wS5sM/1ZFsrADn1jA==
X-Received: by 2002:a37:3753:: with SMTP id e80mr28273695qka.207.1543314639002;
        Tue, 27 Nov 2018 02:30:39 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id x24sm2077480qtk.70.2018.11.27.02.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:30:37 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: always update thread_info->syscall
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
Date:   Tue, 27 Nov 2018 08:30:32 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181126234456.GB30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 9:44 PM, Russell King - ARM Linux wrote:
> On Mon, Nov 26, 2018 at 11:41:11PM +0000, Russell King - ARM Linux wrote:
>> On Mon, Nov 26, 2018 at 11:33:03PM +0000, Russell King - ARM Linux wrote:
>>> On Mon, Nov 26, 2018 at 08:53:35PM -0200, Rafael David Tinoco wrote:
>>>> Right now, only way for task->thread_info->syscall to be updated is if
>>>> if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
>>>> (similar to what has_syscall_work() checks for arm64).
>>>>
>>>> This means that "->syscall" will only be updated if we are tracing the
>>>> syscalls through ptrace, for example. This is NOT the same behavior as
>>>> arm64, when pt_regs->syscallno is updated in the beginning of svc0
>>>> handler for *every* syscall entry.
>>>
>>> So when was it decided that the syscall number will always be required
>>> (we need it to know how far back this has to be backported).
>>
>> PS, I rather object to the fact that the required behaviour seems to
>> change, arch maintainers aren't told about it until... some test is
>> created at some random point in the future which then fails.
>>
>> Surely there's a better way to communicate changes in requirements
>> than discovery-by-random-bug-report ?
> 
> Final comment for tonight - the commit introducing /proc/*/syscall says:
> 
>      This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
>      These use task_current_syscall() to show the task's current system call
>      number and argument registers, stack pointer and PC.  For a task blocked
>      but not in a syscall, the file shows "-1" in place of the syscall number,
>      followed by only the SP and PC.  For a task that's not blocked, it shows
>      "running".
> 
> Please validate that a blocked task does indeed show -1 with your patch
> applied.

Will do. This is done in an upper level (collect_syscall <- 
task_current_syscall <- proc_pid_syscall):

	if (!try_get_task_stack(target)) {
		/* Task has no stack, so the task isn't in a syscall. */
		*sp = *pc = 0;
		*callno = -1;
		return 0;
	}

I think only missing part for arm was that one, but will confirm, after 
fixing usage of "r7" for obtaining "scno". Will send a v2 in this thread.

Thanks!

-- 
Rafael D. Tinoco
Linaro Kernel Validation
