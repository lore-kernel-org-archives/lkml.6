Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1FAC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C520855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="mXqn10Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfAUHlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:41:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfAUHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:41:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so9383402ply.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lUq5dmEXLPCHwnDf9zu/uZyKFZ+oNDbDsnI3kWjYAeY=;
        b=mXqn10Z6B0mQYeGBqKKsc/sf+D3V9H1GMGz+y+R4uM6YvdWO5Fti33zx7H6ZNlrvnL
         0zTACm1YOa1xa5D6yMJu7YTnUu1RAAwry2hr/eRUSxywCtdJr5zmHzTTSxoKMONSfBLY
         T50XaFhoJjZn6O63a0k3fZI/trTXhF3wDTmYldBA+AMEY58EJyNLxVdxu0VBpEqVQFgI
         zDHOrYo7eW5YpFspE1gPc141fHMfqvU+NqqlwVfu+xrenSNI2br2E2yhfsk3zQuaGQme
         1mfum3nZ18k4dVAwen/rlEMa6VAdwZALn+GAzh+WaLPHretA4ebKrUbAATd4cViJEXhY
         3m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lUq5dmEXLPCHwnDf9zu/uZyKFZ+oNDbDsnI3kWjYAeY=;
        b=HOPYrzq2Knpbg138oKby6ehqU+MLVhrRvpASCkFw/itNshwEo75brE43eProTHGJCR
         GAg/rpisVVyaRHH41cOvz+MNhm31jFPrhfLXw3uKtEBNIyOWDDo60a2J4BQ573iUxbWD
         ZISFFf6acGq+fWLfNY9dhmdNtLhQyGVpxEjfMlbDX5Oe51VMuPEYY+BW0Xb5+/O7NbE3
         vKvHEnNkkP8bywJCjnw70k8Vyht54i5PTbwqatpUvizr2YsKmInKIxb1LpvYBvxl4Sa9
         j0HYRA2RjlKIob31oN1xh8quV5nIboMIJbxMK0uuMNg5xK2KbDF+QWMw9Q3YzUyYRxUt
         vi9w==
X-Gm-Message-State: AJcUukcLdRU6cOA72p2pY84weFoq3xeU1h24+tqvfSup3HAQ77hzFbFE
        LcEMo5CsV7fZcrRwRe+d5Oovcw==
X-Google-Smtp-Source: ALg8bN4u2BwQfVhrrPSQxm4DjorOaMIoLoSlt1GlDVXhXeweKOTGg4vvOWfhDeCjooTZrh3u6BVkgw==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr28235912pln.204.1548045514833;
        Sun, 20 Jan 2019 20:38:34 -0800 (PST)
Received: from localhost (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id p2sm14593359pfb.28.2019.01.20.20.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 20:38:34 -0800 (PST)
Date:   Sun, 20 Jan 2019 20:38:32 -0800
From:   Sandeep Patil <sspatil@android.com>
To:     hpa@zytor.com
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20190121043832.GA70794@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119102800.GB17723@infradead.org>
 <20190119103606.GA17400@kroah.com>
 <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com>
 <20190120161003.GB23827@google.com>
 <A40C22DF-B43F-44BA-8148-FC0881087315@zytor.com>
 <20190121014553.GD23827@google.com>
 <BC774ED4-C0FC-4AA6-9BAF-36930A661D9B@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC774ED4-C0FC-4AA6-9BAF-36930A661D9B@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 06:49:56PM -0800, hpa@zytor.com wrote:
> On January 20, 2019 5:45:53 PM PST, Joel Fernandes <joel@joelfernandes.org> wrote:
> >On Sun, Jan 20, 2019 at 01:58:15PM -0800, hpa@zytor.com wrote:
> >> On January 20, 2019 8:10:03 AM PST, Joel Fernandes
> ><joel@joelfernandes.org> wrote:
> >> >On Sat, Jan 19, 2019 at 11:01:13PM -0800, hpa@zytor.com wrote:
> >> >> On January 19, 2019 2:36:06 AM PST, Greg KH
> >> ><gregkh@linuxfoundation.org> wrote:
> >> >> >On Sat, Jan 19, 2019 at 02:28:00AM -0800, Christoph Hellwig
> >wrote:
> >> >> >> This seems like a pretty horrible idea and waste of kernel
> >memory.
> >> >> >
> >> >> >It's only a waste if you want it to be a waste, i.e. if you load
> >the
> >> >> >kernel module.
> >> >> >
> >> >> >This really isn't any different from how /proc/config.gz works.
> >> >> >
> >> >> >> Just add support to kbuild to store a compressed archive in
> >> >initramfs
> >> >> >> and unpack it in the right place.
> >> >> >
> >> >> >I think the issue is that some devices do not use initramfs, or
> >> >switch
> >> >> >away from it after init happens or something like that.  Joel has
> >> >all
> >> >> >of
> >> >> >the looney details that he can provide.
> >> >> >
> >> >> >thanks,
> >> >> >
> >> >> >greg k-h
> >> >> 
> >> >> Yeah, well... but it is kind of a losing game... the more
> >in-kernel
> >> >stuff there is the less smiley are things to actually be supported.
> >> >
> >> >It is better than nothing, and if this makes things a bit easier and
> >> >solves
> >> >real-world issues people have been having, and is optional, then I
> >> >don't see
> >> >why not.
> >> >
> >> >> Modularizing is it in some ways even crazier in the sense that at
> >> >that point you are relying on the filesystem containing the module,
> >> >which has to be loaded into the kernel by a root user. One could
> >even
> >> >wonder if a better way to do this would be to have "make
> >> >modules_install" park an archive file – or even a directory as
> >opposed
> >> >to a symlink – with this stuff in /lib/modules. We could even
> >provide a
> >> >tmpfs shim which autoloads such an archive via the firmware loader;
> >> >this might even be generically useful, who knows.
> >> >
> >> >All this seems to assume where the modules are located. In Android,
> >we
> >> >don't
> >> >have /lib/modules. This patch generically fits into the grand scheme
> >> >things
> >> >and I think is just better made a part of the kernel since it is not
> >> >that
> >> >huge once compressed, as Dan also pointed. The more complex, and the
> >> >more
> >> >assumptions we make, the less likely people writing tools will get
> >it
> >> >right
> >> >and be able to easily use it.
> >> >
> >> >> 
> >> >> Note also that initramfs contents can be built into the kernel.
> >> >Extracting such content into a single-instance tmpfs would again be
> >a
> >> >possibility
> >> >
> >> >Such an approach would bloat the kernel image size though, which may
> >> >not work
> >> >for everyone. The module based approach, on the other hand, gives an
> >> >option
> >> >to the user to enable the feature, but not have it loaded into
> >memory
> >> >or used
> >> >until it is really needed.
> >> >
> >> >thanks,
> >> >
> >> > - Joel
> >> 
> >> Well, where are the modules? They must exist in the filesystem.
> >
> >The scheme of loading a module doesn't depend on _where_ the module is
> >on the
> >filesystem. As long as a distro knows how to load a module in its own
> >way (by
> >looking into whichever paths it cares about), that's all that matters. 
> >And
> >the module contains compressed headers which saves space, vs storing it
> >uncompressed on the file system.
> >
> >To remove complete reliance on the filesystem, there is an option of
> >not
> >building it as a module, and making it as a built-in.
> >
> >I think I see your point now - you're saying if its built-in, then it
> >becomes kernel memory that is lost and unswappable. Did I get that
> >right?
> >I am saying that if that's a major concern, then:
> >1. Don't make it a built-in, make it a module.
> >2. Don't enable it at for your distro, and use a linux-headers package
> >or
> >whatever else you have been using so far that works for you.
> >
> >thanks,
> >
> > - Joel
> 
> My point is that if we're going to actually solve a problem, we need to make it so that the distro won't just disable it anyway, and it ought to be something scalable; otherwise nothing is gained.
> 
> I am *not* disagreeing with the problem statement!
> 
> Now, /proc isn't something that will autoload modules. A filesystem *will*, although you need to be able to mount it; furthermore, it makes it trivially to extend it (and the firmware interface provides an . easy way to feed the data to such a filesystem without having to muck with anything magic.)
> 
> Heck, we could even make it a squashfs image that can just be mounted.
> 
> So, first of all, where does Android keep its modules, and what is actually included? Is /sbin/modprobe used to load the modules, as is normal? We might even be able to address this with some fairly trivial enhancements to modprobe; specifically to search in the module paths for something that isn't a module per se.
> 

FWIW, 'modprobe' does exist on Android. Although most of the times,
Init's builtin insmod function[1] gets used.

The module locations are /{system, vendor,odm}/lib/modules and yes,
modprobe can be made to load modules from there too. [2]

- ssp

> The best scenario would be if we could simply have the tools find the location equivalent of /lib/modules/$version/source...


[1] https://android.googlesource.com/platform/system/core/+/master/init/builtins.cpp#230
[2] https://source.android.com/devices/architecture/kernel/modular-kernels

> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> 
> 
