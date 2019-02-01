Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD59C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0D0218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549032336;
	bh=NnY8OucV9nx22rI1SRHal/rMUrXT7aIyxqrp2rygDBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oSlDvPgFiCKevGwTAekZcfO5+N88WIy+K+FpigvsIBVuhm8WDkoXzxdbl/o7lRGES
	 bCq2qz0pZB/80slIvDGGYfRLXZmoOrA6VDPhC6/Ykn8bMzSk7R3b2/UWhbUaOcgib2
	 nsshNkYw/kOqoOIQHYD+W23GqcWL0h3PBnFfBGdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfBAOpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfBAOpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:45:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74FD520870;
        Fri,  1 Feb 2019 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549032334;
        bh=NnY8OucV9nx22rI1SRHal/rMUrXT7aIyxqrp2rygDBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Chmjp798bVsillRuhyaoAijjP5oZk2pdu5/bs4K14kpyKQf67djnwpnPmSETA4w/S
         KM7H7qNyUAb8wV3ejcqBV6VowAZRcGNaTewfYsdhcCElA97TOxOa00L2sB9biG9CdG
         qXN78+1ycnqF1J/FUPO9Jl8cKE/0roHRd4SWlmfc=
Date:   Fri, 1 Feb 2019 15:45:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 095/103] bpf: prevent out of bounds speculation on
 pointer arithmetic
Message-ID: <20190201144531.GB9864@kroah.com>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129113207.223846678@linuxfoundation.org>
 <CAG48ez2KSRFkRCHdvOhZSsNkdWw=jq8yu9OvUPswsA3i6mq73g@mail.gmail.com>
 <20190201140852.GA20335@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201140852.GA20335@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:08:52PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 01, 2019 at 03:00:18PM +0100, Jann Horn wrote:
> > On Tue, Jan 29, 2019 at 12:47 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > [ commit 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 upstream ]
> > >
> > > Jann reported that the original commit back in b2157399cc98
> > > ("bpf: prevent out-of-bounds speculation") was not sufficient
> > > to stop CPU from speculating out of bounds memory access:
> > > While b2157399cc98 only focussed on masking array map access
> > > for unprivileged users for tail calls and data access such
> > > that the user provided index gets sanitized from BPF program
> > > and syscall side, there is still a more generic form affected
> > > from BPF programs that applies to most maps that hold user
> > > data in relation to dynamic map access when dealing with
> > > unknown scalars or "slow" known scalars as access offset, for
> > > example:
> > 
> > Is this also going into 4.14 and 4.9? I don't see anything related in
> > the stable queue or in stable-rc.
> 
> Ah, the original submitter did not send backported patches, but you are
> right, it should go further back.  I'll see how hard it would be to do
> the backport, thanks for letting me know.

Ok, no, there's no way I can do this backport.  It didn't apply cleanly,
and trying to take the patches prior to this resulted in a huge mess.

So, it would be wonderful if someone who knows the bpf code stack could
do this and send it in.

thanks,

greg k-h
