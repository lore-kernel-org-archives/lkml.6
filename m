Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45036C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCBE2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCBE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeKUTjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:39:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:45398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbeKUTjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:39:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15DEFAE17;
        Wed, 21 Nov 2018 09:06:06 +0000 (UTC)
Date:   Wed, 21 Nov 2018 10:06:03 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        martin.wilck@suse.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Backed up kernels
Message-ID: <20181121100603.5afd53ed@endymion>
In-Reply-To: <CAK7LNATyF4GvvoMz0FphfBu739Qvy7L1KzdFcNyj5HhFsYK53Q@mail.gmail.com>
References: <20181120144007.016e4998@endymion>
        <CAK7LNATyF4GvvoMz0FphfBu739Qvy7L1KzdFcNyj5HhFsYK53Q@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed, 21 Nov 2018 15:59:49 +0900, Masahiro Yamada wrote:
> On Tue, Nov 20, 2018 at 10:40 PM Jean Delvare <jdelvare@suse.de> wrote:
> > Therefore I am asking, can we change "make install" so that it does NOT
> > create a backup copy of an existing kernel?  
> 
> I think your suggestion makes sense,
> but "make install" is basically implemented
> by arch-specific shell script.
> (For example, arch/x86/boot/install.sh)

Thanks for the pointer. However I have a hard time believing that the
script above is what is run when I call "make install". It looks pretty
old, doesn't support kernel files with version strings, and only knows
of lilo as a boot loader.

But I see there is a hook at the beginning for a user or distribution
provided install script:

if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi

So I guess that what I really care about is the /sbin/installkernel
script on my system, which is part of the dracut package. Which means I
must talk to the dracut package maintainer of my distribution.

> Will you talk to the maintainers
> of architecture you are interested in?
> 
> (or send it to linux-arch@vger.kernel.org)

It doesn't seem x86-specific, as apparently a lot of code was
copy-and-pasted across architectures over time. It probably doesn't
make sense to change it on one architecture and not on the others.

Also, if anyone is using these basic kernel-provided installation
scripts, then keeping a backup may actually make sense, because the
kernel files have no version strings, so a new kernel would always
overwrite the previous one, only leaving one kernel in place. If that
kernel doesn't boot for whatever reason, then game over.

So I think we should leave things as is on the kernel side.

Thanks again,
-- 
Jean Delvare
SUSE L3 Support
