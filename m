Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7792184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549012328;
	bh=AExOjJ/GsdlOHVVYg45f/cJkwjCu1xI95juWlcQiDIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LcaK1WTG/mNVzYECCBO4IxEkc61zHKQmHqiVKJEU6HRxmLevNE7npNrY37FL8sGrx
	 i1Ld63OZIhBws/YMGbSH93DnGVmmYqqWyJudm5+US3ijv/Taq6yFXQZsx7slwJ8QBH
	 K3GGHqCnrOgypDiVyjgiO/a4xD3dc/tNlSedDM8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfBAJMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfBAJMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:12:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EABA20869;
        Fri,  1 Feb 2019 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549012325;
        bh=AExOjJ/GsdlOHVVYg45f/cJkwjCu1xI95juWlcQiDIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUyheKYFw3IiG3je9vWSGQliBVTnBpfiSzrogQb2NUQCmXzBmdp1bn6x0WIxGqvFG
         C7wpaiNrTe82xngWopkGOMhFn6ft/JzQltHRg7NW3FlIAaFzVpverTmBLBxq1RxD2S
         /mEyvsT/W1xLU1q3KITRzT/GtTKiEjjMNv2p9IYo=
Date:   Fri, 1 Feb 2019 10:12:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] qspinlock: no need to check return value of
 debugfs_create functions
Message-ID: <20190201091203.GA30619@kroah.com>
References: <20190122152151.16139-44-gregkh@linuxfoundation.org>
 <20190123081441.GE17749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123081441.GE17749@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay, got stuck with other things...

On Wed, Jan 23, 2019 at 09:14:41AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 22, 2019 at 04:21:43PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> So I've seen you do a fair number of these patches; but I don't
> fully understand.
> 
> The existing code rolls back the created files such that we either have
> all files or none at all. Why is this wrong?

Normally you should not care if debugfs files can, or can not, be
created.  So just call the debugfs code and move on.  The worst case is
where valid kernel code aborts just because debugging files could not be
created for some reason, which is not ok.

> It for some daft reason one of the debugfs calls fails (imagine this was
> a module and we did modprobe while under memory pressure), why should we
> present a partial interface to the 'user' ?

Because it's not an interface anyone should ever depend on :)

But, for some code, that only uses debugfs, maybe it does make sense to
just abort the whole thing and keep going on.  If this code should work
that way, my mistake, let's leave it alone.

The overall goal with these patches is to make the code surrounding
using debugfs easier and simpler.  You should not need to handle any
errors from debugfs, as it should never be used for anything that
actually matters to the system, except when trying to debug it.

thanks,

greg k-h
