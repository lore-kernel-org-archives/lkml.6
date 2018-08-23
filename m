Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955D9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F49208E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F49208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeHWWiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:38:12 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32904 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeHWWiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:38:12 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w7NJ6vIk012063;
        Thu, 23 Aug 2018 21:06:57 +0200
Date:   Thu, 23 Aug 2018 21:06:57 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Message-ID: <20180823190657.GA12057@1wt.eu>
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <20180823185417.y3ung3b553f2d24a@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823185417.y3ung3b553f2d24a@angband.pl>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:54:17PM +0200, Adam Borowski wrote:
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
> 
> If you want to do anything more complex, though -- you really want musl
> or another lightweight libc instead.  Glibc is utterly unfit for static
> linking.

Since there seems to be some interest about this, I'll repost this
here. I've developed a "nolibc" include file which implements most
common syscalls and string functions (those I use in early boot)
as static inlines so the resulting executable only contains the
code you really use :

    http://git.formilux.org/?p=people/willy/nolibc.git;a=tree

Example :

  $ echo "int main() { return sleep(3);}" | gcc -Os -nostdlib -include ../nolibc/nolibc.h -s -fno-exceptions -fno-asynchronous-unwind-tables -fno-unwind-tables  -lgcc -o sleep -xc -
  $ ls -l sleep
  -rwxr-xr-x 1 willy users 664 Aug 23 20:37 sleep

It's actually used by my pre-init loader that is embedded into the
initramfs of all my kernels, to untar the modules and switch to the
initrd or rootfs. This way all my modules are contained into the
kernel image and I can easily use many different kernels with rootfs
without having to install modules.

Just in case someone curious would want to know more about it, the
(old and horrible) preinit is here :

  http://git.formilux.org/?p=dist/src/flxutils.git;a=tree;f=init;h=9dc8fbae6383d9b4d56d34cc6c3d59585318bef8;hb=HEAD

And the (old and ugly) build script is here :

  http://git.formilux.org/?p=dist/techno.git;a=tree;f=scripts/kernel;hb=HEAD

Yes it's aging a lot now but it's still very convenient ;-)

Willy
