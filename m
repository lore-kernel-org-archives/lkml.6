Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47072190C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545396369;
	bh=deWRzNU18S8g1coh0jYQgdD4LM5SnVcb09KpKyW+Oj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=icZ08GOB5cvnJI+DA7q9AcDj+ul3rD1gI4dYMa2TBZuA/I/ss6gS+yyk3fhveMUu0
	 /aciFagFqC6RR0NzJaDkSUlJywlm7zew9tZVycyZd676qGDD4LenJo9HZsnNvDL3Tw
	 tmB4kTT4IEZH2am7UkAYurNf5KPKY99X1nTHnBvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbeLUMqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390384AbeLUMqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:46:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67224218FD;
        Fri, 21 Dec 2018 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545396365;
        bh=deWRzNU18S8g1coh0jYQgdD4LM5SnVcb09KpKyW+Oj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bK/oYBkzQiGIfIknAkMmXrRL1py33/lLM2iEk4M2wTRFEPCOMPhtULtOs/W4TqQop
         +Z26bR70oS0ntheg80FmHwfG8wCUfxhajkvOSpl3lHYrpviWbH1IKrdfKY8Eh3OTPu
         RzD6k5sM0BKliSG1XnCM0B/Jsz7XPOMZ6LC5ZkO0=
Date:   Fri, 21 Dec 2018 13:46:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Buland Singh <bsingh@redhat.com>
Cc:     clemens@ladisch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] hpet: Fix missing '=' character in the __setup() code
 of hpet_mmap_enable
Message-ID: <20181221124603.GA7723@kroah.com>
References: <20181220120524.30732-1-bsingh@redhat.com>
 <20181220122932.GB17138@kroah.com>
 <a9704df4-53ee-5b12-2ab1-477fb7e8f083@redhat.com>
 <20181220140951.GB8621@kroah.com>
 <04420337-0df1-73ee-69d7-aa39232f495a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04420337-0df1-73ee-69d7-aa39232f495a@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 05:48:38PM +0530, Buland Singh wrote:
> On 12/20/18 7:39 PM, Greg KH wrote:
> > On Thu, Dec 20, 2018 at 07:12:55PM +0530, Buland Singh wrote:
> > > On 12/20/18 5:59 PM, Greg KH wrote:
> > > > On Thu, Dec 20, 2018 at 05:35:24PM +0530, Buland Singh wrote:
> > > > > Commit '3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for
> > > > > user processes")' introduced a new kernel command line parameter hpet_mmap,
> > > > > that is required to expose the memory map of the HPET registers to
> > > > > user-space. Unfortunately the kernel command line parameter 'hpet_mmap' is
> > > > > broken and never takes effect due to missing '=' character in the __setup()
> > > > > code of hpet_mmap_enable.
> > > > > 
> > > > > Before this patch:
> > > > > 
> > > > > dmesg output with the kernel command line parameter hpet_mmap=1
> > > > > 
> > > > > [    0.204152] HPET mmap disabled
> > > > > 
> > > > > dmesg output with the kernel command line parameter hpet_mmap=0
> > > > > 
> > > > > [    0.204192] HPET mmap disabled
> > > > > 
> > > > > After this patch:
> > > > > 
> > > > > dmesg output with the kernel command line parameter hpet_mmap=1
> > > > > 
> > > > > [    0.203945] HPET mmap enabled
> > > > > 
> > > > > dmesg output with the kernel command line parameter hpet_mmap=0
> > > > > 
> > > > > [    0.204652] HPET mmap disabled
> > > > > 
> > > > > Fixes: 3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for user processes")
> > > > > Signed-off-by: Buland Singh <bsingh@redhat.com>
> > > > > ---
> > > > >    drivers/char/hpet.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> > > > > index 4a22b4b41aef..9bffcd37cc7b 100644
> > > > > --- a/drivers/char/hpet.c
> > > > > +++ b/drivers/char/hpet.c
> > > > > @@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
> > > > >    	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
> > > > >    	return 1;
> > > > >    }
> > > > > -__setup("hpet_mmap", hpet_mmap_enable);
> > > > > +__setup("hpet_mmap=", hpet_mmap_enable);
> > > 
> > > Hello Greag,
> > > 
> > > > This has _never_ worked?  Since 3.13?
> > > 
> > > Yes, that's true :)
> > > 
> > > > Why not just remove the thing as it is obvious no one actually has ever used it.  > That would make the code even simpler :)
> > > 
> > > Data Plane Development Kit (DPDK)[1] provides API that requires the CONFIG_HPET_MMAP
> > > kernel configuration option to be enabled[2]. Some end users might want to use the
> > > HPET MMAP functionality within the application.
> > 
> > But, obviously, they really don't need to do that from the kernel
> > command line as no one has ever noticed this didn't work :)
> > 
> > Also, that page:
> > 
> > > [2] https://doc.dpdk.org/guides-18.08/linux_gsg/enable_func.html
> > 
> > Does not say to use this command line option either.  So if no one has
> > ever used it, please, let us just delete it.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Hello Greg,
> It is better to allow a user to 'enable/disable' the HPET mmap from the
> kernel command line as per the requirement rather than recompiling the
> kernel to 'enable/disable' this functionality.

It might be "nice" but given that no one has noticed that this has never
worked, for all of the years that this has been present, that means to
me that no one has ever tried it because they really do not "need" it.

> Also as per the description in the initial patch (commit 3d035f58), the
> 'CONFIG_HPET_MMAP' Kconfig option has a security risk involved. Hence,
> keeping the CONFIG_HPET_MMAP_DEFAULT (disabled) and allowing a user to
> alter the default behavior using the kernel command line parameter
> hpet_mmap is a better solution.

Again, because no one has ever noticed that this was not working, why
not just rip it out until someone speaks up as to why they have to have
this feature and the other alternatives do not work for them?

thanks,

greg k-h
