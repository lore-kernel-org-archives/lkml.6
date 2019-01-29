Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF7DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6809B214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548739629;
	bh=Ppe7apii6B7B35dto+rwNyb16avBzR9dDR9rTv+0shU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XBuuD+yTJ1+rRSWydZ4P7oF+drsL8UYgiczAvb/OavAGonm7wz+q2SDuGFc8bEAjq
	 eXwD1mrMTaUBlIgXfq39eM9o44zXFfxWetoEPpB30RvhvXNaVPUEfNWsgJarmCKRxZ
	 HjdsJSvk3X6BX5G5tX/S2QoNH3YGIgLueKgAYCac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfA2F1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfA2F1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:27:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1912175B;
        Tue, 29 Jan 2019 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548739625;
        bh=Ppe7apii6B7B35dto+rwNyb16avBzR9dDR9rTv+0shU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqYbw3/ScwS7dR21gXugL713Yv1c391LqxPhVyQHad6OtacyOWnKu3xuRYJuOfGNq
         ZJRFZr0gRHKNE68UBpaNJGioHdZRm4+hT2vb4knCFjrCoKbjKSaafjrMuWbyXVGlkW
         ISWzEG4oUIOZw3QLLXXdDzeVKFH+rOdocs6kwOqM=
Date:   Tue, 29 Jan 2019 06:27:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
Message-ID: <20190129052703.GA9753@kroah.com>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:38:42PM +0100, Thomas Gleixner wrote:
> The original MODULE_LICENSE string for kernel modules licensed under the
> GPL v2 (only / or later) was simply "GPL", which was - and still is -
> completely sufficient for the purpose of module loading and checking
> whether the module is free software or proprietary.
> 
> In January 2003 this was changed with commit 3344ea3ad4b7 ("[PATCH]
> MODULE_LICENSE and EXPORT_SYMBOL_GPL support"). This commit can be found in
> the history git repository which holds the 1:1 import of Linus' bitkeeper
> repository:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3344ea3ad4b7c302c846a680dbaeedf96ed45c02
> 
> The main intention of the patch was to refuse linking proprietary modules
> against symbols exported with EXPORT_SYMBOL_GPL() at module load time.
> 
> As a completely undocumented side effect it also introduced the distinction
> between "GPL" and "GPL v2" MODULE_LICENSE() strings:
> 
>  *      "GPL"                           [GNU Public License v2 or later]
>  *      "GPL v2"                        [GNU Public License v2]
>  *      "GPL and additional rights"     [GNU Public License v2 rights and more]
>  *      "Dual BSD/GPL"                  [GNU Public License v2
>  *                                       or BSD license choice]
>  *      "Dual MPL/GPL"                  [GNU Public License v2
>  *                                       or Mozilla license choice]
> 
> This distinction was and still is wrong in several aspects:
> 
>  1) It broke all modules which were using the "GPL" string in the
>     MODULE_LICENSE() already and were licensed under GPL v2 only.
> 
>     A quick license scan over the tree at that time shows that at least 480
>     out of 1484 modules have been affected by this change back then. The
>     number is probably way higher as this was just a quick check for
>     clearly identifiable license information.
> 
>     There was exactly ONE instance of a "GPL v2" module license string in
>     the kernel back then - drivers/net/tulip/xircom_tulip_cb.c which
>     otherwise had no license information at all. There is no indication
>     that the change above is any way related to this driver. The change
>     happend with the 2.4.11 release which was on Oct. 9 2001 - so quite
>     some time before the above commit. Unfortunately there is no trace on
>     the intertubes to any discussion of this.
> 
>  2) The dual licensed strings became ill defined as well because following
>     the "GPL" vs. "GPL v2" distinction all dual licensed (or additional
>     rights) MODULE_LICENSE strings would either require those dual licensed
>     modules to be licensed under GPL v2 or later or just be unspecified for
>     the dual licensing case. Neither choice is coherent with the GPL
>     distinction.
> 
> Due to the lack of a proper changelog and no real discussion on the patch
> submission other than a few implementation details, it's completely unclear
> why this distinction was introduced at all. Other than the comment in the
> module header file exists no documentation for this at all.
> 
> From a license compliance and license scanning POV this distinction is a
> total nightmare.

Many thanks for digging through all of this, it should help out a lot:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

