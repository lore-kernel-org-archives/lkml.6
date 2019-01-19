Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD70C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D2A2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547894170;
	bh=3U4PIQl/PrnKDmY+bpECiFyQLnpE3k13kHJ+S61pFJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yecZu7SikPqBwvNdoCU0R11ob6KBcx9HXK+6H93l5BSUZmugGCVzOSzSg1TsEqOyu
	 TmrOpvlnJNhIwtvbxrSE1AseKoDUmNzyoASaqkrxFd1rWpzw2stH4HjHXugqD2HLoZ
	 zcYkGxM8QX9s+5AhDYyZKza2uWjTV/HIR47Z4WbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfASKgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfASKgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:36:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01192086D;
        Sat, 19 Jan 2019 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547894168;
        bh=3U4PIQl/PrnKDmY+bpECiFyQLnpE3k13kHJ+S61pFJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqFZanZIO5CuU3U3KzpVqStPJXT+j3N2Jw8jHp0cX9G50DtfQuqnwphW69TP3WoXV
         N4JxTJS4Zhl4W1kvZLP483X+PFIvylo996ydL0zNZOzdDWYQA16yeRqCtVURYk1U9F
         Cp+Kp1omBKfy3Pkr5Sme9U11jhVd3aTrNVAjjE0E=
Date:   Sat, 19 Jan 2019 11:36:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        dancol@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190119103606.GA17400@kroah.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119102800.GB17723@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119102800.GB17723@infradead.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 02:28:00AM -0800, Christoph Hellwig wrote:
> This seems like a pretty horrible idea and waste of kernel memory.

It's only a waste if you want it to be a waste, i.e. if you load the
kernel module.

This really isn't any different from how /proc/config.gz works.

> Just add support to kbuild to store a compressed archive in initramfs
> and unpack it in the right place.

I think the issue is that some devices do not use initramfs, or switch
away from it after init happens or something like that.  Joel has all of
the looney details that he can provide.

thanks,

greg k-h

