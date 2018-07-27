Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F155C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558EF20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558EF20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeG0GEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:04:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48672 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeG0GEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:04:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 45D1F29532;
        Fri, 27 Jul 2018 00:44:06 -0400 (EDT)
Date:   Fri, 27 Jul 2018 14:44:17 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: m68k allmodconfig build errors
In-Reply-To: <761399f0-0b10-716c-1e80-cfb19c06e455@infradead.org>
Message-ID: <alpine.LNX.2.21.1807271428300.65@nippy.intranet>
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org> <878t66idai.fsf@igel.home> <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org> <alpine.LNX.2.21.1807241423000.8@nippy.intranet> <761399f0-0b10-716c-1e80-cfb19c06e455@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018, Randy Dunlap wrote:

> > 
> > The untested patch below may work. It seems that it may be relevant to 
> > both arc and m68k:
> 
> 
> I got back to looking at the build errors.  I agree with Andreas that 
> all of the fields in question are null-terminated, so Finn's patch looks 
> good to me.
> 
> 

That patch is insufficient:

ERROR: "strcmp" [fs/hfsplus/hfsplus.ko] undefined!

And I haven't even attempted "make ARCH=m68k ... allyesconfig" let alone 
"make ARCH=arc ... allyesconfig".

And we have to anticipate an ongoing game of whack-a-mole here, as new 
library calls get added to linux and new optimizations get added to gcc.

The real problem here seems to be a compiler bug: converting strncmp to 
strcmp is bogus. Some implicit assumptions in that code transformation: 
1. that strcmp is equivalient to strncmp in this case
2. that strcmp is faster than strncmp in this case
3. that strcmp is actually available to the linker

Why doesn't gcc convert strncmp to __builtin_strcmp? That would require 
fewer assumptions, and it would actually link, and we wouldn't have to 
keep patching things...

-- 
