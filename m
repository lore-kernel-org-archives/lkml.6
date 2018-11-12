Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20882C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACAE22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpSlFNyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACAE22504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbeKMDrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeKMDrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:47:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F151E2241E;
        Mon, 12 Nov 2018 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542045186;
        bh=dgAWDaBwAhrIbpZFvyOERugOJQsrGQw6OT3I8v+Y3ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpSlFNyohRc3fl8DyfjAhBbfahknUrTFwxo8ftmvkO4JjwxG13fQtwb4uvn93e/rB
         80Ra1joNWabm8Y5AXLiF7HJd6UowrTkDdCjETZVBYEbFOPowsQ4MvOCdiIbSokZ/IV
         WUZWmFWN7uqbjmAOGir89ktmZTntol1QHZdZjRZI=
Date:   Mon, 12 Nov 2018 09:53:05 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181112175305.GB15484@kroah.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <20181111081725.GA30248@1wt.eu>
 <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
 <20181111111143.GB4189@1wt.eu>
 <87zhufvntw.fsf@oldenburg.str.redhat.com>
 <20181111120910.GA4425@1wt.eu>
 <alpine.DEB.2.21.1811121723210.6607@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811121723210.6607@digraph.polyomino.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:36:11PM +0000, Joseph Myers wrote:
> What *is*, in my view, a bug in the uapi headers is that some of them 
> don't work when included on their own.  I'd expect #include 
> <linux/whatever.h> or #include <asm/whatever.h>, for any such header 
> installed by make headers_install, to compile on its own in userspace 
> without needing any other headers to be included first, unless some header 
> is specifically defined as being an internal part of another header which 
> is the one that should be included.

Yes, that is a bug, and people have been working on fixing that.  We now
have a new build target:
	make headers_check
to keep this all working properly.

Right now on Linus's latest tree I only see one failure when running
this:
	./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64} type without #include <linux/types.h>
so we are getting better.

If there are still problems with this, please let us know and we will be
glad to resolve them.

thanks,

greg k-h
