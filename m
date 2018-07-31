Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4852083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUtvH8Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4852083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeGaCG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:06:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42205 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbeGaCG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:06:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so5265457pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOEEzw6l0oxuJRtKoHZWTGuWWPrgJkNGEW0hNGZO7EU=;
        b=RUtvH8ZelUucGqhKCV5IInr/pxCtefoPGZYinY006SyBz//4HKfhr/jXcxNJRv+Hp+
         9z5osLajceLY87+1qali79Rx3llu1xb1S6ANYU5WXYPT9Sj4bYdZKC32/Ve8Hy86V+Oj
         OgpKZ+yzc1X29n802oD+CPmNFwPOZv6GWKgG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WOEEzw6l0oxuJRtKoHZWTGuWWPrgJkNGEW0hNGZO7EU=;
        b=pFMUxZcdwYTiyrGfX7ogCW8zyXrNdcWmAl/8C2ngUzXPpiWpJJp6chtRP/T8+wBx7J
         FvMQwa/x+ek+KQVXZMc7xtOyfdtzEQ/UU4iG1k6R4qvvCNlE4lQXbiwy7i25EhNZqHqa
         pRvz63uF8Z2L9zPVeOFkRf0OJNvhkwXETmjHWu1uUFCJ6/lC3YrqtjF7Nkm2j25k50Po
         wnsc78hiPNKCz0SxNwTe6rdKUsgCEffpYlGiUCTQ0ZFSY5tgkyUZqF1dqR0Py1m4GbvO
         aMeatmA/yUYCy8EC3sG5sEY/3x8bKq9TzuY9PnQVVSruRTv2//28d1wjb9KFZI8dsmbM
         zQhQ==
X-Gm-Message-State: AOUpUlGbBOJU1VNDY4ZBh+AMHMjnySP0jPtbSUiV+DgLn0jQ2sODEkdk
        nVxZsZ3QuMiCGqPFppHi19cB7g==
X-Google-Smtp-Source: AAOMgpcKT3Qzt86dUVMBUk+fFSiF89dfDwYbwjq5XUEDl/d2WER1zZAy6lIGuk3KK2VzCkbtK75m9w==
X-Received: by 2002:a63:e116:: with SMTP id z22-v6mr17620246pgh.89.1532996937654;
        Mon, 30 Jul 2018 17:28:57 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id v4-v6sm13709038pgr.36.2018.07.30.17.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 17:28:57 -0700 (PDT)
Date:   Tue, 31 Jul 2018 09:28:31 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
Message-ID: <20180731002830.GJ11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
 <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
 <20180730162235.GC4276@arm.com>
 <2651847f-79ea-fe2a-c1d7-efe4d11702b4@oracle.com>
 <20180730165757.GF4276@arm.com>
 <d9bac115-794c-4225-bcaa-91b6847604a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bac115-794c-4225-bcaa-91b6847604a2@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:36:28PM -0500, Dave Kleikamp wrote:
> On 07/30/2018 11:57 AM, Will Deacon wrote:
> > On Mon, Jul 30, 2018 at 11:46:24AM -0500, Dave Kleikamp wrote:
> >> On 07/30/2018 11:22 AM, Will Deacon wrote:
> >>> On Mon, Jul 30, 2018 at 05:16:42PM +0100, Catalin Marinas wrote:
> >>>> On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
> >>>>> machine_kexec flushes the reboot_code_buffer from the icache
> >>>>> after stopping the other cpus.
> >>>>>
> >>>>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
> >>>>> for kernel mappings") added an IPI call to flush_icache_range, which
> >>>>> causes a hang here, so replace the call with __flush_icache_range
> >>>>
> >>>> While machine_kexec() may be called with interrupts disabled (IIUC) and
> >>>> we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
> >>>> there any other CPUs online at this point?
> >>>
> >>> The BUG_ON and WARN_ON at the start of machine_kexec() suggest to me that
> >>> this should only happen if we're kexec'ing a crash kernel and
> >>> smp_crash_stop_failed(). Is that something we need to care about?
> >>
> >> I observed the hang trying to kexec a crash kernel and I did not see the
> >> warning that smp_crash_stop_failed(). I'm not exactly sure why
> >> flush_icache_range() hung (but it did), but I think that
> >> __flush_icache_range() makes more sense here anyway.
> > 
> > Yeah, I'll pick the patch up, but it would be nice to understand the
> > failure case you observed.
> 
> I see why it failed. ipi_cpu_crash_stop() does not call
> set_cpu_online(cpu, false) the way ipi_cpu_stop() does. So
> cpu_online_mask is still populated with the stopped cpus.
> 
> Any reason why it isn't called there?

Because I wanted that saved cpu-related state be as close to as it was
at panic.
If cpus go offline, the core dump would show that all the cores but
a panicked one be offline whether or not they actually were.

Thanks,
-Takahiro AKASHI

> Thanks,
> Dave
> 
> > 
> > Will
> > 
