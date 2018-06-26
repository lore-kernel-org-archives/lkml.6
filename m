Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D37C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB9226E1A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfO4rF8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB9226E1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeFZRGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:06:48 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37462 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeFZRGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:06:46 -0400
Received: by mail-ua0-f194.google.com with SMTP id c2-v6so11391866uae.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1F0BeIQpefA85zjy6xELJQgZVCG6eUhSCkdCOy8goGY=;
        b=FfO4rF8m6ONV/ST4m62pYvLzvtWafetKCcXOmBKKg4yMwGw7yK7OTh37geNmoolTqX
         mArBDmDqXUmKE0QXXMMsa61AlDYcRbGDBuMvSY0F+iZxVR+wedd+AZt3TCFc54jggNF0
         mf0mBtIO0s9NVKwT6pXuxGFIxW4T4mlEAOKwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1F0BeIQpefA85zjy6xELJQgZVCG6eUhSCkdCOy8goGY=;
        b=OoYr7ww2DFCvS2C3FPg8nslpKrQ++S6wyZKF1zLklJGCG/JLYeIiONbN0d3OA9wjEY
         hS0RmlpydQ8VPMcBR2mg9sqZY4x2JjrIoct2PY1JbKhKeOa4zfeQJyPWNy17kPT97ozw
         fMo1Q3S5Y+d6to/yx3v7fylYvFn2SFjovHHbhhV9qLabOCxvI6W9jo/aKOkUSHyialof
         dzwUreXdJL6jPFPjKGkzeUNTg2yUJ8XYo9AffmEJbgzJQlHLIMNKn4z5gn9Zb4AyOmPf
         Cqv371Ze8WCOmj5bLtklUgk7PkeTcnBcuR6ikRWvKN9uxVFXUO5ynDnPcgCm9mqBDRhP
         hJgQ==
X-Gm-Message-State: APt69E1WhnZF7NLYY1lXLgyHiORcfTEuGJaBpx2ygRc/db9HqBjb5635
        H32HHso0tppASSkmEj3+fvkdRA==
X-Google-Smtp-Source: AAOMgpcFzKgEMjYJhoOIlZe7OXA50EDnIReSg70lsL5F/RXpgLjz2BFBmq59EGXRJNU18FNct6Er8Q==
X-Received: by 2002:ab0:4eef:: with SMTP id x47-v6mr1531944uah.23.1530032805662;
        Tue, 26 Jun 2018 10:06:45 -0700 (PDT)
Received: from localhost ([201.191.143.207])
        by smtp.gmail.com with ESMTPSA id a10-v6sm476842uap.37.2018.06.26.10.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:06:44 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:06:43 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, rafael.tinoco@linaro.org,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: qemu-system-x86_64: mov_ss_trap_64 PANIC: double fault,
 error_code: 0x0
Message-ID: <20180626170643.r2znwqmc57gxep7p@xps>
References: <CA+G9fYu0E0fM+WaFim1WKup5BZvjtGZ_4ii5FhTUjNZEqaAuwA@mail.gmail.com>
 <CALCETrWZ=sipwoVic16LM08+-FKV5knO7Cv3pSM_5w=KLCqTKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWZ=sipwoVic16LM08+-FKV5knO7Cv3pSM_5w=KLCqTKw@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:47:40AM -0700, Andy Lutomirski wrote:
> On Sun, Jun 24, 2018 at 10:41 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Kselftest test case mov_ss_trap_64 is causing kernel panic on
> > qemu-system-x86_64 and PASS on real x86_64 hardware.
> >
> > Test code snippet,
> > main() {
> > <>
> >       printf("[RUN]\tMOV SS; CS CS INT3\n");
> >       asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss));
> > <>
> > }
> >
> 
> This smells like CVE-2018-1087.  Can you confirm that your *host*
> kernel is patched?
> 
> CVE-2018-1087 is extremely severe, and if your host kernel is not
> patched, I think you need to apply some serious pressure on your
> vendor to get with the program.

Thanks Andy - that was exactly it. We updated our host running debian
stretch to the latest kernel (per
https://security-tracker.debian.org/tracker/CVE-2018-1087), and the
symptom was no longer seen. Thanks for the pointer.

Dan

-- 
Linux Kernel Functional Testing (LKFT)
https://lkft.linaro.org/
