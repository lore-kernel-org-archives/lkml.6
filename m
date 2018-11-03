Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECBC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B8C20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEOfLxq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B8C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeKCRw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 13:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbeKCRw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 13:52:28 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E9F2082D;
        Sat,  3 Nov 2018 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541234513;
        bh=lowefEsvEsTHi/rj2QTW9ey6zF/sRYQgh+g+axqPq/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEOfLxq2bInZ2jNc8sgbk/XGvd9TvdeLZU37OKwhjPR9Dh9/QgT2n9qv+Rjq6FRxx
         Ax/YjMCq4YtgBfKRftSTsF4dm8ox3RrEJax0fbEEzvRRWaRehr1S46lwtI728sL3ft
         THj29njXdWcxGSzS6X15GOLd7/GYE8YFc/ViMAP0=
Date:   Sat, 3 Nov 2018 09:41:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, a.p.zijlstra@chello.nl,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4.14 053/143] x86/power: Fix some ordering bugs in
 __restore_processor_context()
Message-ID: <20181103084151.GB9057@kroah.com>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182901.303280657@linuxfoundation.org>
 <CADVatmNE4VcpjoEKdXTf_d0_M27shgB+x6FiXo1-JzRf+0sw9w@mail.gmail.com>
 <20181102231734.GI194472@sasha-vm>
 <20181103084016.GA9057@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103084016.GA9057@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 09:40:16AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 02, 2018 at 07:17:34PM -0400, Sasha Levin wrote:
> > On Fri, Nov 02, 2018 at 08:19:36PM +0000, Sudip Mukherjee wrote:
> > > Hi Greg,
> > > 
> > > On Fri, Nov 2, 2018 at 6:51 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > This has been fixed by another upstream commit:
> > > 7ee18d677989 ("x86/power: Make restore_processor_context() sane")
> > > 
> > > You can not directly apply it, will need backporting.
> > 
> > It depends on the following commits:
> > 
> > 5b06bbcfc2c6 x86/power: Fix some ordering bugs in __restore_processor_context()
> > 090edbe23ff5 x86/power/64: Use struct desc_ptr for the IDT in struct saved_context
> > 896c80bef4d3 x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()
> > 7ee18d677989 x86/power: Make restore_processor_context() sane
> > 
> > Greg, any objections to pulling them all in?
> 
> No objection, but can I just drop this patch here (it's also in the 4.9
> queue) and then all of these be added to your next round of patches to
> be pulled in after this release?
> 
> That should make it easier, and more ovbious to test this all together.

I've now dropped this patch from the 4.9 and 4.14 queues as that makes
sense here.

thanks,

greg k-h
