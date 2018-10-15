Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA7F21476
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guo05MiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA7F21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJPCpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJPCpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:45:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55CDA208D9;
        Mon, 15 Oct 2018 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539629912;
        bh=7sOuwo1+TNhImtTS9IhQydVrf04W9XcBz+9u8pA9v0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Guo05MiVbi0mdTcINxWuUhb2xVsjdBgeglQ29DHgiJKp9kgNbQNjkaDc6QPGbNStV
         SaPqeJOXUTk0gx4siBdIsLG4+w7gd927Ee4hNAQhP6B0lzMEr5yomfgzwCJgHnCLOZ
         +4QwHZ9lGAita6udIkGO7ZhF1UG20tMSfEZAHGww=
Date:   Mon, 15 Oct 2018 20:58:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enke Chen <enkechen@cisco.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Message-ID: <20181015185829.GA6397@kroah.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181013064023.GA28177@kroah.com>
 <37401cea-5a37-2cd9-8595-8b07dfc4de7d@cisco.com>
 <20181015184358.GA12153@kroah.com>
 <614dad0f-97e3-91b4-0c29-c052d01922eb@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614dad0f-97e3-91b4-0c29-c052d01922eb@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:49:11AM -0700, Enke Chen wrote:
> Hi, Greg:
> 
> On 10/15/18 11:43 AM, Greg Kroah-Hartman wrote:
> > On Mon, Oct 15, 2018 at 11:16:36AM -0700, Enke Chen wrote:
> >> Hi, Greg:
> >>
> >>> Shouldn't there also be a manpage update, and a kselftest added for this
> >>> new user/kernel api that is being created?
> >>>
> >>
> >> I will submit a patch for manpage update once the code is accepted.
> > 
> > Writing a manpage update is key to see if what you are describing
> > actually matches the code you have submitted.  You should do both at the
> > same time so that they can be reviewed together.
> 
> Ok, will do at the same time. But should I submit it as a separate patch?

Yes please.

> >> Regarding the kselftest, I am not sure.  Once the prctl() is limited to
> >> self (which I will do), the logic would be pretty straightforward. Not
> >> sure if the selftest would add much value.
> > 
> > If you do not have a test for this feature, how do you know it even
> > works at all?  How will you know if it breaks in a future kernel
> > release?  Have you tested this?  If so, how?
> 
> I have the test code. I am just not sure whether I should submit and check
> it in to the kselftest?

Of course you should, why wouldn't you?  Do you want to be the only
person in the world responsible for ensuring that this feature does not
break for the next 20+ years?  :)

thanks,

greg k-h
