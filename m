Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA66AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872E721726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548174822;
	bh=KrqiZ7eaLk6N9ZRrNc+4aLvnPl8tPoB9qjEZK7JEJAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=scKjEk0w8tCkupTZcQEITrBqDoJ+KW9YtbSqGUJWMmeT/UjBiCLdxDiRgTlBNrQXa
	 5htRaUT/pN3OorxfRkmzMvu1J+DQ2oQJM8QBmyJZhNcVgGKD8ZtJlwMl6lfE5bCyv/
	 rgQTbw5KsXUyJtY3V4iSo9pEoN3Ku3ZWuVwGeHsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfAVQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbfAVQdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:33:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F5B2085A;
        Tue, 22 Jan 2019 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548174819;
        bh=KrqiZ7eaLk6N9ZRrNc+4aLvnPl8tPoB9qjEZK7JEJAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDtJRck8Zp8t0vRwdDLmSnBWcQYQnGqstKWITdYUJO1s8jv3828tbZBDuvXPoElLS
         /3kBF6d53G/0wWLdBjNp6EfQ2qsbJqn5htRJtjOxLREUloQl8q+n1TpmHnzwPT5C00
         TBxpEFuymt+kPYZDo2XcbhG4Wuq6Sdc3ob4tuX4M=
Date:   Tue, 22 Jan 2019 17:33:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: kernel: no need to check return value of
 debugfs_create functions
Message-ID: <20190122163337.GB23510@kroah.com>
References: <20190122152151.16139-3-gregkh@linuxfoundation.org>
 <20190122162454.GA31034@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122162454.GA31034@osiris>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:24:54PM +0100, Heiko Carstens wrote:
> On Tue, Jan 22, 2019 at 04:21:02PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/s390/kernel/debug.c    | 6 ------
> >  arch/s390/kernel/kdebugfs.c | 2 --
> >  arch/s390/kernel/sysinfo.c  | 2 --
> >  3 files changed, 10 deletions(-)
> > diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> > index 12f80d1f0415..2ac3c9b56a13 100644
> > --- a/arch/s390/kernel/sysinfo.c
> > +++ b/arch/s390/kernel/sysinfo.c
> > @@ -545,8 +545,6 @@ static __init int stsi_init_debugfs(void)
> >  	int lvl, i;
> > 
> >  	stsi_root = debugfs_create_dir("stsi", arch_debugfs_dir);
> > -	if (IS_ERR_OR_NULL(stsi_root))
> > -		return 0;
> 
> No objections, however will you also change the odd behaviour that
> e.g. debugfs_create_file() returns -ENODEV instead of (the expected)
> NULL pointer if CONFIG_DEBUGFS is disabled?

Nope.  That is intentional.

> I do remember this since it caused at least one crash ;)

Which is why you shouldn't care about the return value of these
functions :)

> 19cdd08ba155 ("[S390] qdio: fix broken pointer in case of CONFIG_DEBUG_FS is disabled").

Odd, what crashes when passed an error pointer?  What was someone trying
to do with those pointers?  The only thing you can do with a return
value from a debugfs function is to pass it back into another debugfs
call.  Sounds like someone wasn't doing that :(

Given that that patch was from 2.6.29, I think we are safe...

thanks,

greg k-h
