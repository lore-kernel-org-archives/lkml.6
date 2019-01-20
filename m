Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE18C7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FAE2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="beePmekC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfATQKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:10:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44180 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfATQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:10:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so20534362qte.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gJLe9NCacgEEA/W4lTVsKxupjgEOAu7y//ExpgweGGQ=;
        b=beePmekC5ybj6xweHrQRBJOocc00LddL5ESR8RnA0m0vIJacHdoxDo7u4C8fJvnGws
         jnWtnziu/4VRu/dl7BRtZuHJbhftt+kmxXRB6qSizh9pkpDzEH/5vbUqhZ6PaYKVGeVb
         txaZJIlgqQkfQRfL6aEdZQ4jAp3neAfv+oxvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gJLe9NCacgEEA/W4lTVsKxupjgEOAu7y//ExpgweGGQ=;
        b=s2PUUrE8QPnjqh+ri6e3ISr1Iths+8W7hhEYAAtz+2CidSnGISYHiiAbO4rKfuF+MD
         Te0Cs41R5Jn8fu1T9y7hjq5OLCZ9zPslRUw9G0Qil7Eo5zD18WxpiVxNwRxnb3safb+E
         LfRsmqDHSunj7N5csb7hnjrKTtR472EjBbbzlV7bDoHTKQpduRy+XLRd8u13lEkZbhfz
         D4CpDQ08R462L9d1fHgQxRz8K6r84FKRUPUdhySOXCeZTpvjTG49XcxkIRmffkGxDWNh
         OCPbK9dghPrpAkjR8G2LNzgB6zuOU8EARQNdPRV5NBTdi6fFVn9Qc9VBXb9E9OW6OXN6
         AsQQ==
X-Gm-Message-State: AJcUukcrUxmT3YjBsnrOvtDfdprkApBuAZEjr5XC4gFJ3hgCgPGm1TvQ
        SgM6EpJkE5yq6VBqMInQ6LG8kA==
X-Google-Smtp-Source: ALg8bN6KJE00o/malmqZdmRdZvOb/jUIiOlw7+4LQSyoLHCmTbEuruu9Uw2zLVo3FVtldY8C/ppHEQ==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr23699498qtn.78.1548000605188;
        Sun, 20 Jan 2019 08:10:05 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id a17sm55260394qth.93.2019.01.20.08.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 08:10:04 -0800 (PST)
Date:   Sun, 20 Jan 2019 11:10:03 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     hpa@zytor.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        dancol@google.com, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190120161003.GB23827@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119102800.GB17723@infradead.org>
 <20190119103606.GA17400@kroah.com>
 <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:01:13PM -0800, hpa@zytor.com wrote:
> On January 19, 2019 2:36:06 AM PST, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Sat, Jan 19, 2019 at 02:28:00AM -0800, Christoph Hellwig wrote:
> >> This seems like a pretty horrible idea and waste of kernel memory.
> >
> >It's only a waste if you want it to be a waste, i.e. if you load the
> >kernel module.
> >
> >This really isn't any different from how /proc/config.gz works.
> >
> >> Just add support to kbuild to store a compressed archive in initramfs
> >> and unpack it in the right place.
> >
> >I think the issue is that some devices do not use initramfs, or switch
> >away from it after init happens or something like that.  Joel has all
> >of
> >the looney details that he can provide.
> >
> >thanks,
> >
> >greg k-h
> 
> Yeah, well... but it is kind of a losing game... the more in-kernel stuff there is the less smiley are things to actually be supported.

It is better than nothing, and if this makes things a bit easier and solves
real-world issues people have been having, and is optional, then I don't see
why not.

> Modularizing is it in some ways even crazier in the sense that at that point you are relying on the filesystem containing the module, which has to be loaded into the kernel by a root user. One could even wonder if a better way to do this would be to have "make modules_install" park an archive file – or even a directory as opposed to a symlink – with this stuff in /lib/modules. We could even provide a tmpfs shim which autoloads such an archive via the firmware loader; this might even be generically useful, who knows.

All this seems to assume where the modules are located. In Android, we don't
have /lib/modules. This patch generically fits into the grand scheme things
and I think is just better made a part of the kernel since it is not that
huge once compressed, as Dan also pointed. The more complex, and the more
assumptions we make, the less likely people writing tools will get it right
and be able to easily use it.

> 
> Note also that initramfs contents can be built into the kernel. Extracting such content into a single-instance tmpfs would again be a possibility

Such an approach would bloat the kernel image size though, which may not work
for everyone. The module based approach, on the other hand, gives an option
to the user to enable the feature, but not have it loaded into memory or used
until it is really needed.

thanks,

 - Joel

