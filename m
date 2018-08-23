Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A73C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F252150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F252150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHWWrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:47:20 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39165 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHWWrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:47:20 -0400
X-Originating-IP: 134.134.139.72
Received: from localhost (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A0BD560002;
        Thu, 23 Aug 2018 19:16:12 +0000 (UTC)
Date:   Thu, 23 Aug 2018 12:16:04 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        nicolas.pitre@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Message-ID: <20180823191604.GB3243@localhost>
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <20180823185417.y3ung3b553f2d24a@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823185417.y3ung3b553f2d24a@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:54:17PM +0200, Adam Borowski wrote:
> On Thu, Aug 23, 2018 at 10:43:59AM -0700, Paul E. McKenney wrote:
> > The mkinitramfs approach results in about 40MB of initrd, and dracut
> > about 10MB.  Most of this is completely useless for rcutorture, which
> > isn't interested in mounting filesystems, opening devices, and almost
> > all of the other interesting things that mkinitramfs and dracut enable.
> > 
> > Those who know me will not be at all surprised to learn that I went
> > overboard making the resulting initrd as small as possible.  I started
> > by throwing out everything not absolutely needed by the dash and sleep
> > binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> > This situation of course prompted me to create an initrd containing
> > a statically linked binary named "init" and absolutely nothing else
> > (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> > This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> > for a C-language "for" loop containing nothing more than a single call to
> > sleep()?
> 
> .globl _start
> .data
> req:    .8byte 999999999, 999999999
> .text
> _start:
>         mov     $35, %rax       # syscall: nanosleep
>         mov     $req, %rdi
>         xor     %rsi, %rsi
>         syscall
>         jmp     _start
> 
> 
> as sl.s -o sl.o
> ld sl.o -o init
> 
> 'Ere you go, no libc needed.  If your arch is not amd64, just say so.

"pause" ($34) would also suffice, and would not require an argument or a
.data section.

- Josh Triplett
