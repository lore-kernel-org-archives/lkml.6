Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFDAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 04:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A5F20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 04:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeL3EF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 23:05:57 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50982 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeL3EF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 23:05:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E3FC7297F9;
        Sat, 29 Dec 2018 23:05:52 -0500 (EST)
Date:   Sun, 30 Dec 2018 15:05:49 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
In-Reply-To: <alpine.LNX.2.21.1812301051280.215@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com> <alpine.LNX.2.21.1812301051280.215@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2018, I wrote:

> 
> I'm not opposed to exported functions in place of a singleton ops 
> struct. Other things being equal I'm inclined toward the ops struct, 
> perhaps because I like encapsulation or perhaps because I don't like 
> excess generality. (That design decision was made years ago and I don't 
> remember the reasoning.)

The rationale for the ops struct was that it offers introspection.

It turns out that PPC64 device drivers don't care about byte-at-a-time 
accessors and X86 device drivers don't care about checksum validation.
But that only gets us so far.

We still needed a way to find out whether the arch has provided 
byte-at-a-time accessors (i.e. PPC32 and M68K Mac) or byte range accessors 
(i.e. PPC64 and those platforms with checksummed NVRAM like X86 and M68K 
Atari).

You can't resolve this question at build time for a multi-platform kernel 
binary, so pre-processor tricks don't help.

Device drivers tend to want to access NVRAM one byte at a time. With this 
patch series, those platforms which need checksum validation always set 
byte-at-a-time methods to NULL. (Hence the atari_scsi changes in patch 3.)

The char misc driver is quite different to the usual device drivers, 
because the struct file_operations methods always access a byte range.

The NULL methods in the ops struct allow the nvram.c misc device to avoid 
inefficient byte-at-a-time accessors where possible, just as 
arch/powerpc/kernel/nvram_64.c presently does.

-- 
