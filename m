Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF22C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04D82086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550816756;
	bh=EwsQ6jfPGwWFXO3GdFKenTnMSbXqaGVo+el3yUt0tpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kZchPmebkaPmMNMAelVvzlcztrWcdpJtSKTvr1Dxy7vv1SqNT8F0nWqmkt9CgJPeW
	 z7qMaQtkG+vlRsDANmc/DkwK0ffg3erDWTBkXceMs5Thehc7VWJtFWqnGa7D9mLs5i
	 cBysFWrV/0COttOkvfFsLsvbwNJQaktdqfByefxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfBVGZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfBVGZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:25:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD1C207E0;
        Fri, 22 Feb 2019 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550816753;
        bh=EwsQ6jfPGwWFXO3GdFKenTnMSbXqaGVo+el3yUt0tpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsnCtAIt4TgTNziJtE8F8FpnSutz7p5WeAZdPs6NPGUfmhRKYKBdzFmEM85A7fFEF
         hjhV2L/nh8g38KiTw7IWlIBqEiWoEm10GwZRMaTtmFvWw5zhTrV/afrmHWPsElCWIP
         uZbAc2fyOBBMPF2gUPHn1CvlC/ObajpTaWRUrVng=
Date:   Fri, 22 Feb 2019 07:25:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        William Cohen <wcohen@redhat.com>,
        stable <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng <lttng@reliableembeddedsystems.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
Message-ID: <20190222062550.GA3780@kroah.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
 <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
 <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org>
 <20190218122631.GE30260@kroah.com>
 <843587666.153.1550501735273.JavaMail.zimbra@efficios.com>
 <1829800918.4014.1550779377803.JavaMail.zimbra@efficios.com>
 <20190222001042.hm6j5h4hmfpwarzr@shell.armlinux.org.uk>
 <622813157.4561.1550794631564.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622813157.4561.1550794631564.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 07:17:11PM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 21, 2019, at 7:10 PM, Russell King, ARM Linux linux@armlinux.org.uk wrote:
> 
> > On Thu, Feb 21, 2019 at 03:02:57PM -0500, Mathieu Desnoyers wrote:
> >> Hi Arnd, Russell, Linus,
> >> 
> >> Can we ensure the arm32 kprobes fix I submitted gets upstream before 5.0 final ?
> >> It takes care of an illegal instruction issue with optimized kprobes on arm32.
> >> 
> >> Here is the current state of default kprobes configuration on arm32:
> >> using them will trigger illegal instruction OOPS on v5.0-rc7, 4.19.24,
> >> v4.14.102.
> >> 
> >> My fix is in "accepted" state in the arm patch tracking system:
> >> 
> >> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1
> >> 
> >> Should I send it directly to Linus as well ?
> > 
> > Accepted means it's in my tree pending to be sent to Linus.  It should
> > now be in mainline.  Have you checked?
> 
> Hrm, why did I not see it earlier today... it's embarrassing.
> 
> It's there indeed, all is good!
> 
> Greg, you should be able to pick it into the stable kernels now.

What is the git commit id of it?

thanks,

greg k-h
