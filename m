Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68C6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868A820836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K0YWEry7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868A820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030391AbeFSSIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:08:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52932 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030310AbeFSSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8zA3R9bNbJ2JPrGJ1gp9JYXeNHw35yhT2jAf+2YyT/k=; b=K0YWEry7tfxqKB8BZx1KpnEi2
        0pQUZhoIplatQVj70vEsIs3szI5fYNoDPqWV5NNLvrQAsIuY5jJl+ebFoBmm5af3tKdlYmuiU88hN
        0ROxbO92y2Z6E/zI+rs5nAK2GN9UW9lUQObvi1ET7NIh3ytnS0920CgS1jKoIhs9LF25I=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:38803)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fVL3G-0002Mg-MV; Tue, 19 Jun 2018 19:08:22 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fVL3D-0004Uw-TO; Tue, 19 Jun 2018 19:08:20 +0100
Date:   Tue, 19 Jun 2018 19:08:18 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
Message-ID: <20180619180817.GK17671@n2100.armlinux.org.uk>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
 <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
 <20180619151235.GH17671@n2100.armlinux.org.uk>
 <20180619171424.GA16846@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619171424.GA16846@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:14:24AM -0700, Guenter Roeck wrote:
> On Tue, Jun 19, 2018 at 04:12:35PM +0100, Russell King - ARM Linux wrote:
> > 
> > So, I'm going to continue sitting on the fence on this, and basically
> > take the attitude that it's better that people don't use the new
> > binutils until binutils people can provide us with an officially
> > sanctioned solution that's going to work for both older and future
> > assemblers.
> > 
> I would so much love if people were working together instead of against
> each other :-(. Never mind, I'll try a toolchain with binutils 2.28.1.
> At least that is still supported with buildroot.

You could say that about the toolchain people who decided to change
the behaviour in this area that has existed before July 2009, and
broke multiple software packages in the process.

What I don't want to do is to change it in some way that breaks
existing setups, or that ends up breaking again in the future.  This
is why I want input _from the toolchain people_ before we try to fix
the problem.

That isn't "against each other" - it's a request _for_ toolchain
people to be involved in this.

The fact that this thread doesn't involve any toolchain people says
a lot about the "working together" aspect.  So, please don't try and
lump this on me being "un-cooperative".

What I'm saying is talk to the toolchain people and find a solution
in conjunction _with_ them that we can be sure will work, rather
than guessing at some obscure undocumented method that could end up
breaking again.

Remember, _you_ have the problem, _I_ don't.  It's not for me to go
off and talk to the toolchain people on your behalf.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
