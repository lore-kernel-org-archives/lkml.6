Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440D9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD82208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD82208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeGPCvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 22:51:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59412 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeGPCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 22:51:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fetD7-0001Cb-2L; Mon, 16 Jul 2018 02:26:01 +0000
Date:   Mon, 16 Jul 2018 03:26:01 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jann Horn <jannh@google.com>, andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
Message-ID: <20180716022600.GN30522@ZenIV.linux.org.uk>
References: <20180706215003.156702-1-jannh@google.com>
 <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
 <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com>
 <20180715220339.GA15435@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715220339.GA15435@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:03:39AM +0200, Ingo Molnar wrote:
> 
> * Jann Horn <jannh@google.com> wrote:
> 
> >  - A malicious user can pass an arbitrary file to a setuid binary as
> > stdin/stdout/stderr. When the setuid binary (expecting stdin/stdout to
> > be something normal, like a proper file or a pipe) then calls read(0,
> > <buf>, <len>), if the kernel disregards the length argument and writes
> > beyond the end of the buffer, it can corrupt adjacent userspace data,
> > potentially allowing a user to escalate their privileges; a write
> > handler is somewhat less interesting because it can probably (as in
> > this case) only leak out-of-bounds data from the caller, not corrupt
> > it, but it's still a concern in theory.
> 
> BTW., a naive question: would it make sense to simply disallow 'special'
> fds to be passed to setuid binaries, and fix any user-space that breaks?
> (i.e. only allow regular files and pipes/sockets.)

*Ugh*

You do realize that there's a lot of magical mystery shite that looks like
regular files?  And what's wrong with directories, BTW?

While we are at it, "passed" in which sense?  Via SCM_RIGHTS?  Those are
only get accepted if recepient explicitly asks for those - simple read()
or recv() will have them quietly discarded, special or not.

And if it's "inherit over execve()"...  Your definition *will* break.
Instantly.  Right as you try to run su or sudo, with stdin/stdout/stderr
all going to a character device.  Terminal, that is.

Frankly, something like
	copyin_limited(buf, len, kbuf, size)
and several similar helpers would be a lot more productive than open-coding
these checks over and over or trying to come up with definitions of "special"
that would work.

BTW, what's the point open-coding
	if (sscanf(line, "base=%ull size=%ull type=%s", &base, &size, &type) != 3)
		return -EINVAL;
        if ((base & 0xfff) || (size & 0xfff))
                return -EINVAL;
	i = match_string(mtrr_strings, MTRR_NUM_TYPES, type);
        if (i < 0)
                return i;
as
        if (strncmp(line, "base=", 5))
                return -EINVAL;

        base = simple_strtoull(line + 5, &ptr, 0);
        ptr = skip_spaces(ptr);

        if (strncmp(ptr, "size=", 5))
                return -EINVAL;

        size = simple_strtoull(ptr + 5, &ptr, 0);
        if ((base & 0xfff) || (size & 0xfff))
                return -EINVAL;
        ptr = skip_spaces(ptr);

        if (strncmp(ptr, "type=", 5))
                return -EINVAL;
        ptr = skip_spaces(ptr + 5);

        i = match_string(mtrr_strings, MTRR_NUM_TYPES, ptr);
        if (i < 0)
                return i;

Saving the copying of 'type' (which we need since '%n' is declared useless)?
