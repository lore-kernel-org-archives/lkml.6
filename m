Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E2C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3150420865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3150420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeIIJGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 05:06:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43028 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeIIJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 05:06:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fyr9W-0004TI-66; Sun, 09 Sep 2018 04:16:58 +0000
Date:   Sun, 9 Sep 2018 05:16:50 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 03/11] compat_ioctl: remove translation for sound ioctls
Message-ID: <20180909041632.GE19965@ZenIV.linux.org.uk>
References: <20180908142837.2819693-1-arnd@arndb.de>
 <20180908142837.2819693-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180908142837.2819693-3-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 04:28:09PM +0200, Arnd Bergmann wrote:
> The SNDCTL_* and SOUND_* commands are the old OSS user interface.
> 
> I checked all the sound ioctl commands listed in fs/compat_ioctl.c
> to see if we still need the translation handlers. Here is what I
> found:
> 
> - sound/oss/ is (almost) gone from the kernel, this is what actually
>   needed all the translations
> - The ALSA emulation for OSS correctly handles all compat_ioctl
>   commands already.
> - sound/oss/dmasound/ is the last holdout of the original OSS code,
>   this is only used on arch/m68k, which has no 64-bit mode and
>   hence needs no compat handlers
> - arch/um/drivers/hostaudio_kern.c may run in 64-bit mode with
>   32-bit x86 user space underneath it. This rare corner case is
>   the only one that still needs the compat handlers.
> 
> By adding a simple redirect of .compat_ioctl to .unlocked_ioctl in the
> UML driver, we can remove all the COMPATIBLE_IOCTL() annotations without
> a change in functionality. For completeness, I'm adding the same thing
> to the dmasound file, knowing that it makes no difference.

> diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
> index 7f9dbdbc4eb7..0278a642a622 100644
> --- a/arch/um/drivers/hostaudio_kern.c
> +++ b/arch/um/drivers/hostaudio_kern.c
> @@ -298,6 +298,7 @@ static const struct file_operations hostaudio_fops = {
>  	.write          = hostaudio_write,
>  	.poll           = hostaudio_poll,
>  	.unlocked_ioctl	= hostaudio_ioctl,
> +	.compat_ioctl	= hostaudio_ioctl,

Umm...  OK, seeing that it's not going to be used on s390...  It's still
not quite right, though, and I'm afraid that places where we have the
same ->unlocked_ioctl and ->compat_ioctl need an audit - there probably
had been other folks who'd stepped into the same.
