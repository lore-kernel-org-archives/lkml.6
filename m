Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F08BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B668214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="W5h32lTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B668214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeLCSCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:02:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44283 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLCSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:02:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so6044152pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eqqP54wabPUX+OmiVWkeTn8AzREjJ55DW8J3hKtKwhI=;
        b=W5h32lTwRYgQIQ1ZOyQYXyOHs8RoAWB0LKhQ3AbL0a87TwgjlJuHD+o5gSfRqyqMUB
         jpDP0X+MiX2Kt16A5jsesYZBdX8IwgDFFLYsTcGZhPUMsgQvaH4zzLWdW+OC3JdLNfdm
         ovrgEN2JuFnZFpzu68a/V13FrPg65u2fm53TImoI4colerThlYGZ6wdo+a35v2Ho7RIr
         ChiydNymMsg9IZpgbrJMlFvxPNZzvq4bl7aCAizr66lauNJWEBHxYIjEbPQYn28xX559
         aOYQlVnshR6KPFZC0HBdpp8E6fGe1U1rdXj1Irrj60gr9lyaBDe2CECSGZ1UdOPmzv7l
         YTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eqqP54wabPUX+OmiVWkeTn8AzREjJ55DW8J3hKtKwhI=;
        b=bggYu5nHHcHKjN/btiDAa16qLJUgAajteQI1Kzn82A6CFJ9qJx1prL7sqK0ch8CVb8
         JhCPdWr/oIT8qnEH61tFzHTIDDxyikEwRr77USzFI/mUjfS3lXvJDTADSGeqVpiNIKGy
         Sl5ohII2HKyC4LRSbnx3oM8homeXWPMU9B0ET/Z6YINN51Ac7LNyPg0QgYaz9AXx6GZG
         Fs92XH2ApuJcPr0u8xKtLgITfksf92J3/krOe++A9zutIWP4BRgGX20dnt/KSEMcUr5g
         P84Ic25to8GZjdT2P1mmfkpOT6Jwt95g0up8uuJfpH9AiZK0Uv2+qvkS1EBimrPFH/9I
         VZyA==
X-Gm-Message-State: AA+aEWYHaXt1YtRLrhNkS7zOih3wqQMDEbLH717VjMk9IDqsMjlHM4gB
        TER0wXZOD4zhhQsr9DVru1XQuw==
X-Google-Smtp-Source: AFSGD/UYKlpt5mzi1ya/mhmvT8IpYbG1v0AJZAwXS428v34WUFhv9tdXyGdM5nmjNlPrYsEsuXQiDw==
X-Received: by 2002:a63:8742:: with SMTP id i63mr13871700pge.298.1543860159208;
        Mon, 03 Dec 2018 10:02:39 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id 4sm23625479pfq.10.2018.12.03.10.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:02:38 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:02:29 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
Message-ID: <20181203180224.fkvw4kajtbvru2ku@brauner.io>
References: <20181120105124.14733-1-christian@brauner.io>
 <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io>
 <20181202100304.labt63mzrlr5utdl@brauner.io>
 <8736rebl9s.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736rebl9s.fsf@oldenburg.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:57:51PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > Ok, I finally have access to source code again. Scratch what I said above!
> > I looked at the code and tested it. If the process has exited but not
> > yet waited upon aka is a zombie procfd_send_signal() will return 0. This
> > is identical to kill(2) behavior. It should've been sort-of obvious
> > since when a process is in zombie state /proc/<pid> will still be around
> > which means that struct pid must still be around.
> 
> Should we make this state more accessible, by providing a different
> error code?

No, I don't think we want that. Imho, It's not really helpful. Signals
are still delivered to zombies. If zombie state were to always mean that
no-one is going to wait on this thread anymore then it would make sense
to me. But given that zombie can also mean that someone put a
sleep(1000) right before their wait() call in the parent it seems odd to
report back that it is a zombie.

> 
> Will the system call ever return ESRCH, given that you have a handle for
> the process?

Yes, whenever you signal a process that has already been waited upon:
- get procfd handle referring to <proc>
- <proc> exits and is waited upon
- procfd_send_signal(procfd, ...) returns -1 with errno == ESRCH

> 
> >> >Looking at the rt_tgsigqueueinfo interface, is there a way to implement
> >> >the “tg” part with the current procfd_signal interface?  Would you use
> >> >openat to retrieve the Tgid: line from "status"?
> > 
> > Yes, the tg part can be implemented.
> 
> I meant on top of the existing interface.

See below.

> 
> > As I pointed out in another mail my I is to make this work by using
> > file descriptors for /proc/<pid>/task/<tid>.  I don't want this in the
> > initial patchset though.  I prefer to slowly add those features once
> > we have gotten the basic functionality in.
> 
> Do you want to land all this in one kernel release?  I wonder how
> applications are supposed to discover kernel support if functionality is
> split across several kernel releases.  If you get EINVAL or EBADF, it
> may not be obvious what is going on.

Sigh, I get that but I really don't want to have to land this in one big
chunk. I want this syscall to go in in a as soon as we can to fulfill
the most basic need: having a way that guarantees us that we signal the
process that we intended to signal.

The thread case is easy to implement on top of it. But I suspect we will
quibble about the exact semantics for a long time. Even now we have been
on multiple - justified - detrous. That's all pefectly fine and
expected. But if we have the basic functionality in we have time to do
all of that. We might even land it in the same kernel release still. I
really don't want to come of as tea-party-kernel-conservative here but I
have time-and-time again seen that making something fancy and cover ever
interesting feature in one patchset takes a very very long time.

If you care about userspace being able to detect that case I can return
EOPNOTSUPP when a tid descriptor is passed.

> 
> What happens if you use the new interface with an O_PATH descriptor?

You get EINVAL. When an O_PATH file descriptor is created the kernel
will set file->f_op = &empty_fops at which point the check I added 
        if (!proc_is_tgid_procfd(f.file))
                goto err;
will fail. Imho this is correct behavior since technically signaling a
struct pid is the equivalent of writing to a file and hence doesn't
purely operate on the file descriptor level.

Christian
