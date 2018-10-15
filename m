Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C9CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6BE208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qe463r7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6BE208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJPGdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:33:49 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48296 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeJPGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UCoWwX2S9E711TzGUVIIx4f9EOPJS+c/GE06I+tcRzs=; b=Qe463r7AQXrPmPYJfhPx3JLa3
        0QP4kijFWLWbmzqwz1etaPdRtyxY8zGZut9twYwu5gdjF9t8O3eIfM8ltl9L5Xn8vcOsPjAjCO6zf
        zdtg3M2zpWH8+O42ohLaC0WoJFY5qCtPbjIjOIDPyV+eVKkjlrPqs1cSi3CJgDlmAwFHs=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:49415)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gCBd2-00037h-5f; Mon, 15 Oct 2018 23:46:24 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gCBcx-000809-0m; Mon, 15 Oct 2018 23:46:19 +0100
Date:   Mon, 15 Oct 2018 23:46:15 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     raj.khem@gmail.com, ulli.kroll@googlemail.com, joel@jms.id.au,
        nico@linaro.org, arnd@arndb.de, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input
 operands list
Message-ID: <20181015224614.GB30658@n2100.armlinux.org.uk>
References: <20181015221629.13924-1-stefan@agner.ch>
 <20181015222302.GZ30658@n2100.armlinux.org.uk>
 <26d465580722c7f65b6916e96e283967@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d465580722c7f65b6916e96e283967@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 12:39:54AM +0200, Stefan Agner wrote:
> On 16.10.2018 00:23, Russell King - ARM Linux wrote:
> > On Tue, Oct 16, 2018 at 12:16:29AM +0200, Stefan Agner wrote:
> >> When functions incoming parameters are not in input operands list gcc
> >> 4.5 does not load the parameters into registers before calling this
> >> function but the inline assembly assumes valid addresses inside this
> >> function. This breaks the code because r0 and r1 are invalid when
> >> execution enters v4wb_copy_user_page ()
> > 
> > NAK.  Naked functions must never be inlined.  Please add a "noinline"
> > attribute to the function rather than making things more complex.
> > 
> 
> To be honest, I did not put much thought into this commit since it is
> just doing to copypage-fa.c what 9a40ac86152c ("ARM: 6164/1: Add kto and
> kfrom to input operands list.") has been done to the other copypage
> implementations...
> 
> [adding Khem]
> 
> > The GCC manual states:
> > 
> > `naked'
> >      Use this attribute on the ARM, AVR, MCORE, MSP430, NDS32, RL78, RX
> >      and SPU ports to indicate that the specified function does not
> >      need prologue/epilogue sequences generated by the compiler.  It is
> >      up to the programmer to provide these sequences. The only
> >                                                       ^^^^^^^^
> >      statements that can be safely included in naked functions are
> >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >      `asm' statements that do not have operands.  All other statements,
> >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >      including declarations of local variables, `if' statements, and so
> >      forth, should be avoided.  Naked functions should be used to
> >      implement the body of an assembly function, while allowing the
> >      compiler to construct the requisite function declaration for the
> >      assembler.
> > 
> > The 'I' attribute is fine here because it is a constant that is not
> > allowed to be in a register (and hence has no code generation side
> > effects.)
> > 
> > Adding operands for the input parameters, however, isn't going to
> > work around the fact that _this_ assembly is written to be out of
> > line and so it must never be inlined by the compiler.
> 
> I briefly looked at a disassembled version after applying both patches,
> it indeed leads to inlining. However, the code seems to be working
> (thanks to asm volatile?)...

Apart from v4wb_copy_user_page() and mc_copy_user_page(), how is
Clang inlining these static functions that are only used through
function pointers?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
