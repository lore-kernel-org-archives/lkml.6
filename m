Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E40DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D0E21557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D0E21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeHWWZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:25:26 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:42810 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeHWWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:25:26 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fsukM-0001yn-1X; Thu, 23 Aug 2018 20:54:18 +0200
Date:   Thu, 23 Aug 2018 20:54:17 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Message-ID: <20180823185417.y3ung3b553f2d24a@angband.pl>
References: <20180823174359.GA13033@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180823174359.GA13033@linux.vnet.ibm.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:43:59AM -0700, Paul E. McKenney wrote:
> The mkinitramfs approach results in about 40MB of initrd, and dracut
> about 10MB.  Most of this is completely useless for rcutorture, which
> isn't interested in mounting filesystems, opening devices, and almost
> all of the other interesting things that mkinitramfs and dracut enable.
> 
> Those who know me will not be at all surprised to learn that I went
> overboard making the resulting initrd as small as possible.  I started
> by throwing out everything not absolutely needed by the dash and sleep
> binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> This situation of course prompted me to create an initrd containing
> a statically linked binary named "init" and absolutely nothing else
> (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> for a C-language "for" loop containing nothing more than a single call to
> sleep()?

.globl _start
.data
req:    .8byte 999999999, 999999999
.text
_start:
        mov     $35, %rax       # syscall: nanosleep
        mov     $req, %rdi
        xor     %rsi, %rsi
        syscall
        jmp     _start


as sl.s -o sl.o
ld sl.o -o init

'Ere you go, no libc needed.  If your arch is not amd64, just say so.

If you want to do anything more complex, though -- you really want musl
or another lightweight libc instead.  Glibc is utterly unfit for static
linking.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ .globl _start↵.data↵rc: .ascii "/etc/init.d/rcS\0"↵.text↵_start
⣾⠁⢰⠒⠀⣿⡁ mov $57,%rax↵syscall↵cmp $0,%rax↵jne child↵parent:↵mov $61,%rax
⢿⡄⠘⠷⠚⠋⠀ mov $-1,%rdi↵xor %rsi,%rsi↵xor %rdx,%rdx↵syscall↵jmp parent↵child:
⠈⠳⣄⠀⠀⠀⠀ mov $59,%rax↵mov $rc,%rdi↵xor %rsi,%rsi↵xor %rdx,%rdx↵syscall
