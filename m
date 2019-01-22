Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B4921736
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548148932;
	bh=CGEj8ssaPrjaS+pJehSNpdfo8oHKAsYjYvXUgxzo+p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P6YiyvURUY8RhY2RcnWaI1/stb+HgrkhHJzz9/n1FIr6BYPgzdK9SjwWCyAAI947W
	 FtHvt6s7R3ZI0CjC12euF3CBKJGMuiYMnFWLiUoTZVFsTRWS/AS5JZJdaTzXr7PbQM
	 D8qhD6uDfwrHKOlD/cZLR/os7HE7/FOlemsQES5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfAVJWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:22:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfAVJWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:22:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9004E21019;
        Tue, 22 Jan 2019 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548148930;
        bh=CGEj8ssaPrjaS+pJehSNpdfo8oHKAsYjYvXUgxzo+p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyju2ZUqv06bhqbgTIgJFGn4fJiJl1ePLsaLDOw4SI7rxG+BHUgy8IGk9u3VErCqT
         0YpFMMre/oEgCKOi5+wyJhY5WnHGpYpaRjM504GpxxmvNPdtbD07lfHl5GqjiO9Nf0
         2mu3AF9or1Rt+IZzBKNDE+JjEcHqRBoyXbSFhzqI=
Date:   Tue, 22 Jan 2019 10:22:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 15/22] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
Message-ID: <20190122092207.GA339@kroah.com>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
 <fc5f13c7e60b846f533de41b179d904a95f58aea.1547525936.git.fthain@telegraphics.com.au>
 <20190122091917.GA16612@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122091917.GA16612@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:19:17AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 03:18:56PM +1100, Finn Thain wrote:
> > A multi-platform kernel binary has to decide at run-time how to dispatch
> > the arch_nvram_ops calls. Add a platform-independent arch_nvram_ops
> > struct for this, to replace the atari-specific one.
> > 
> > Enable CONFIG_HAVE_ARCH_NVRAM_OPS for Macs.
> > 
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> > Changed since v8:
> >  - Adopted nvram_read_bytes() and nvram_write_bytes() where possible.
> 
> This patch fails to apply to my tree, what did you make it against?
> 
> I tried against 5.0-rc1 :(
> 
> Can you rebase this series against the char-misc-next branch of my
> char-misc.git tree and resend so that I can apply the whole series?

Oops, nope, my fault, I missed some patches in this series, nevermind...

greg k-h
