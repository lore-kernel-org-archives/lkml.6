Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3639C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C1C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547147366;
	bh=iXg8q6MzR9ytC5PYy/ErCiygn/3Vt+ib7OUE8Hx+OpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iWk1QN4jvha1SJrU7HEbtEDS7YoLNwFvAWUkagFHBCVz6kiELdaI5wn4pBl5s5fqV
	 IAtsL5pcq8rHyHxFwvNtTEuyunRCPGF5R31nm2zodkrZfUceSFSBXlLrUBA0oP4/Jp
	 JfhHLnZ2gy2TCfOOhHSGD+wgATp0NSVCnkz3WKmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfAJTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfAJTJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:09:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3336B20879;
        Thu, 10 Jan 2019 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547147364;
        bh=iXg8q6MzR9ytC5PYy/ErCiygn/3Vt+ib7OUE8Hx+OpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeZztLgAeJzQ51FbDYcl18ethcjt6juD5AEsrcwj6UdP4G9+xYI/dDPaYjia2YVFP
         UDkemw4fJ+hc48/3q2cHQrStR2XavZdRFz9c1bdT/OCPBcQORNOZP5sp7WMleMq/Z/
         aaRNyoz/iC4MDJYJkSYaBiRH/4fRj4r91RuhOzC0=
Date:   Thu, 10 Jan 2019 20:09:21 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [4.9 PATCH] MIPS: math-emu: Write-protect delay slot emulation
 pages
Message-ID: <20190110190921.GA18221@kroah.com>
References: <154685090718637@kroah.com>
 <20190110174724.24713-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110174724.24713-1-paul.burton@mips.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:47:42PM +0000, Paul Burton wrote:
> commit adcc81f148d733b7e8e641300c5590a2cdc13bf3 upstream.
> 
> Mapping the delay slot emulation page as both writeable & executable
> presents a security risk, in that if an exploit can write to & jump into
> the page then it can be used as an easy way to execute arbitrary code.
> 
> Prevent this by mapping the page read-only for userland, and using
> access_process_vm() with the FOLL_FORCE flag to write to it from
> mips_dsemul().
> 
> This will likely be less efficient due to copy_to_user_page() performing
> cache maintenance on a whole page, rather than a single line as in the
> previous use of flush_cache_sigtramp(). However this delay slot
> emulation code ought not to be running in any performance critical paths
> anyway so this isn't really a problem, and we can probably do better in
> copy_to_user_page() anyway in future.
> 
> A major advantage of this approach is that the fix is small & simple to
> backport to stable kernels.
> 
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: 432c6bacbd0c ("MIPS: Use per-mm page to execute branch delay slot instructions")
> Cc: stable@vger.kernel.org # v4.8+
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Rich Felker <dalias@libc.org>
> Cc: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/kernel/vdso.c     |  4 ++--
>  arch/mips/math-emu/dsemul.c | 38 +++++++++++++++++++------------------
>  2 files changed, 22 insertions(+), 20 deletions(-)
> 

Thanks for the backport, now queued up.

greg k-h
