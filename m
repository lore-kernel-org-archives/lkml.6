Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53126C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F9B2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F9B2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeKCEMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:12:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42802 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeKCEMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:12:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIekD-0000UD-P1; Fri, 02 Nov 2018 19:04:33 +0000
Date:   Fri, 2 Nov 2018 19:04:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iov_iter: Fix 9p virtio breakage
Message-ID: <20181102190433.GZ32577@ZenIV.linux.org.uk>
References: <20181102171651.97671-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102171651.97671-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 05:16:51PM +0000, Marc Zyngier wrote:
> When switching to the new iovec accessors, a negation got subtly
> dropped, leading to 9p being remarkably broken (here with kvmtool):
> 
> [    7.430941] VFS: Mounted root (9p filesystem) on device 0:15.
> [    7.432080] devtmpfs: mounted
> [    7.432717] Freeing unused kernel memory: 1344K
> [    7.433658] Run /virt/init as init process
>   Warning: unable to translate guest address 0x7e00902ff000 to host
>   Warning: unable to translate guest address 0x7e00902fefc0 to host
>   Warning: unable to translate guest address 0x7e00902ff000 to host
>   Warning: unable to translate guest address 0x7e008febef80 to host
>   Warning: unable to translate guest address 0x7e008febf000 to host
>   Warning: unable to translate guest address 0x7e008febef00 to host
>   Warning: unable to translate guest address 0x7e008febf000 to host
> [    7.436376] Kernel panic - not syncing: Requested init /virt/init failed (error -8).
> [    7.437554] CPU: 29 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8-02267-g00e23707442a #291
> [    7.439006] Hardware name: linux,dummy-virt (DT)
> [    7.439902] Call trace:
> [    7.440387]  dump_backtrace+0x0/0x148
> [    7.441104]  show_stack+0x14/0x20
> [    7.441768]  dump_stack+0x90/0xb4
> [    7.442425]  panic+0x120/0x27c
> [    7.443036]  kernel_init+0xa4/0x100
> [    7.443725]  ret_from_fork+0x10/0x18
> [    7.444444] SMP: stopping secondary CPUs
> [    7.445391] Kernel Offset: disabled
> [    7.446169] CPU features: 0x0,23000438
> [    7.446974] Memory Limit: none
> [    7.447645] ---[ end Kernel panic - not syncing: Requested init /virt/init failed (error -8). ]---
> 
> Restoring the missing "!" brings the guest back to life.
> 
> Fixes: 00e23707442a ("iov_iter: Use accessor function")
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

ACK.  Do you want me to take it via vfs.git?  Or might as well
send directly to Linus, with

Acked-by Al Viro <viro@zeniv.linux.org.uk>

on it.
