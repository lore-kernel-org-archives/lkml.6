Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23052208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gQmt+Y1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23052208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJPGvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:51:05 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48532 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPGvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LVVo2yhtZsNMoa6xptbobUCvAJzCgQ4JTayJBsNjOck=; b=gQmt+Y1ayxY6xzV5Yb8ADwFCm
        3O2OQwSW5LU6+cr22lyzpiduxH4ZPGUfXmIQ9C87g9+WdORu8eKFftWQR5j+LYpp7NUYcmVxasBzz
        uWHkedBFZhfsbuqRlQ3UKZOQFqA6ZEyVOwGuZxWujUZju+A3PO5wkOgWMvWh5o3MpgXC0=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:34285)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gCBtg-0003Ct-JG; Tue, 16 Oct 2018 00:03:36 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gCBtZ-0008DR-TO; Tue, 16 Oct 2018 00:03:30 +0100
Date:   Tue, 16 Oct 2018 00:03:27 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     raj.khem@gmail.com, ulli.kroll@googlemail.com, joel@jms.id.au,
        nico@linaro.org, arnd@arndb.de, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input
 operands list
Message-ID: <20181015230327.GD30658@n2100.armlinux.org.uk>
References: <20181015221629.13924-1-stefan@agner.ch>
 <20181015222302.GZ30658@n2100.armlinux.org.uk>
 <26d465580722c7f65b6916e96e283967@agner.ch>
 <20181015224614.GB30658@n2100.armlinux.org.uk>
 <2802c0e549149872aa58da5fb54471fc@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2802c0e549149872aa58da5fb54471fc@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 12:52:58AM +0200, Stefan Agner wrote:
> On 16.10.2018 00:46, Russell King - ARM Linux wrote:
> > On Tue, Oct 16, 2018 at 12:39:54AM +0200, Stefan Agner wrote:
> >> On 16.10.2018 00:23, Russell King - ARM Linux wrote:
> >> > On Tue, Oct 16, 2018 at 12:16:29AM +0200, Stefan Agner wrote:
> >> >> When functions incoming parameters are not in input operands list gcc
> >> >> 4.5 does not load the parameters into registers before calling this
> >> >> function but the inline assembly assumes valid addresses inside this
> >> >> function. This breaks the code because r0 and r1 are invalid when
> >> >> execution enters v4wb_copy_user_page ()
> >> >
> >> > NAK.  Naked functions must never be inlined.  Please add a "noinline"
> >> > attribute to the function rather than making things more complex.
> >> >
> >>
> >> To be honest, I did not put much thought into this commit since it is
> >> just doing to copypage-fa.c what 9a40ac86152c ("ARM: 6164/1: Add kto and
> >> kfrom to input operands list.") has been done to the other copypage
> >> implementations...
> >>
> >> [adding Khem]
> >>
> >> > The GCC manual states:
> >> >
> >> > `naked'
> >> >      Use this attribute on the ARM, AVR, MCORE, MSP430, NDS32, RL78, RX
> >> >      and SPU ports to indicate that the specified function does not
> >> >      need prologue/epilogue sequences generated by the compiler.  It is
> >> >      up to the programmer to provide these sequences. The only
> >> >                                                       ^^^^^^^^
> >> >      statements that can be safely included in naked functions are
> >> >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> >      `asm' statements that do not have operands.  All other statements,
> >> >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> >      including declarations of local variables, `if' statements, and so
> >> >      forth, should be avoided.  Naked functions should be used to
> >> >      implement the body of an assembly function, while allowing the
> >> >      compiler to construct the requisite function declaration for the
> >> >      assembler.
> >> >
> >> > The 'I' attribute is fine here because it is a constant that is not
> >> > allowed to be in a register (and hence has no code generation side
> >> > effects.)
> >> >
> >> > Adding operands for the input parameters, however, isn't going to
> >> > work around the fact that _this_ assembly is written to be out of
> >> > line and so it must never be inlined by the compiler.
> >>
> >> I briefly looked at a disassembled version after applying both patches,
> >> it indeed leads to inlining. However, the code seems to be working
> >> (thanks to asm volatile?)...
> > 
> > Apart from v4wb_copy_user_page() and mc_copy_user_page(), how is
> > Clang inlining these static functions that are only used through
> > function pointers?
> 
> I only looked at copypage-xscale.c (the mc_copy_user_page() case)...

The two I mention are different from the rest, because they are used
from other functions within the same file.  The rest are all used
through function pointers and should, therefore, never be inlined.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
