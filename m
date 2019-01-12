Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F9C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57FE21783
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547280200;
	bh=UlifJNrotj4J+PKLrPF4upR0Ci0gE96phiEoZ9mxKGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bs/91XB7hWElbYOqIzXgzVq5OLu4smhk2GxjwduefUGoAMAfCyc9dOo9Rg7S6MBSV
	 ptvGPFZyK1TzOqflpBCbzXokdxzG0804arM8oN/oTudxXATqxnV1DNUCYMUlz1h8uK
	 rKcLB8RRd0IkM3jitBawOOW4FzayWQcPNdLDCaxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfALIDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfALIDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:03:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3BC4205F4;
        Sat, 12 Jan 2019 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547280198;
        bh=UlifJNrotj4J+PKLrPF4upR0Ci0gE96phiEoZ9mxKGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLz9A8LmDLEDjLD0Vy4UYW/a98b+4m8iUdw3dRVsVB19uNAygpAuUhiqPNRpbvJyp
         RzpeOHFOH1wHfpFdEoWnxNXIct0kz1AB/B1uibxjLCq9MGpBz+WVvUnDJv4hZxzi1q
         i17TbZhSItL/9rhP45GimjCFoDjmjrWxoPeiTBqQ=
Date:   Sat, 12 Jan 2019 09:03:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.14 093/105] arm64: drop linker script hack to hide
 __efistub_ symbols
Message-ID: <20190112080315.GB17489@kroah.com>
References: <20190111131102.899065735@linuxfoundation.org>
 <20190111131110.701589602@linuxfoundation.org>
 <CAKwvOdmnpH=pCT7J44kL7ka0sRkhKCYGKxV7g4Ubeu80R98RwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmnpH=pCT7J44kL7ka0sRkhKCYGKxV7g4Ubeu80R98RwA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:02:57AM -0800, Nick Desaulniers wrote:
> On Fri, Jan 11, 2019 at 6:34 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > commit dd6846d774693bfa27d7db4dae5ea67dfe373fa1 upstream.
> >
> > Commit 1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_
> > symbols") updated the kallsyms code to filter out symbols with
> > the __efistub_ prefix explicitly, so we no longer require the
> > hack in our linker script to emit them as absolute symbols.
> 
> !!!
> Sorry, I think we should pick 1212f7a16af4 ("scripts/kallsyms: filter
> arm64's __efistub_ symbols") for 4.14 to go with this patch.
> 
> My usual gitfu to see the first tag that contained a commit `git
> describe --contains "$tag" | sed 's/~.*//'` says next-20180319 which
> isn't something I recognize or would have expected.  I see the changed
> code in 4.19.y LTS but not 4.14.y LTS.

Now added, thanks.

greg k-h
