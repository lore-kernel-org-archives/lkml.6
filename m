Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E18C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E8323F83
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="STdbxpQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E8323F83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeFVJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:23:38 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39186 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeFVJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aHbubk1ywRvwkjiwlVwgUCWNTRXNHPTNOmD4iCImC2U=; b=STdbxpQ6PYInAvtfDnI6oqG+C
        lvT80hq6U9R3J+3q7E8HRqUYMDAzbhS+FAQpEMfEi5Jwv+XTqY10x6gvw/2t0SCvu6q4TsUUGRM+j
        wuzAgy2dMwWMF/G3Jnan1lHPCUuqkgoeDnlNzAK/jqzBdBP0roIwnvaO73x0rM5F2mSEU=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:37945)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fWIHk-0000hH-EH; Fri, 22 Jun 2018 10:23:16 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fWIHd-0000qw-Tg; Fri, 22 Jun 2018 10:23:11 +0100
Date:   Fri, 22 Jun 2018 10:23:05 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
Message-ID: <20180622092305.GS17671@n2100.armlinux.org.uk>
References: <20180621155906.12821-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180621155906.12821-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:59:06PM +0200, Geert Uytterhoeven wrote:
> "ARM multiplatform" has actually two meanings:
>   1. It groups platforms that follow the "ARM multiplatform" software
>      framework,
>   2. It allows to build a single kernel that can be booted on multiple
>      platforms.
> 
> Currently support for XIP and/or NOMMU cannot be enabled on platforms
> that follow the "ARM multiplatform" framework, without duplicating their
> machine selection logic under a new Kconfig symbol.  As (in theory) all
> platforms can be used with XIP and/or NOMMU, this is not sustainable.

The reason for that has nothing to do with the way this option is named,
and even after reading your commit message, I can't come up with any
reason for this change other than "personally don't like the existing
wording" which IMHO is not a good enough reason to randomly go around
rewording stuff in the kernel.

The reason that XIP and NOMMU can't be enabled with a multi-platform
kernel is that there are often issues with different layouts of the
physical memory space which can not be taken into account.

Multi-platform works around that by (a) using the MMU to abstract
away the differences on RAM, and (b) modifying the kernel text to
adjust the virtual to physical translations.  The latter is not
possible with XIP, and the former should not be used with NOMMU.
That means the kernel must be built to accomodate the physical
layout on the target platform, and so building a kernel supporting
multiple platforms with differing memory layouts makes no sense.

This is exactly why I really don't like the idea of ARCH_MULTIPLATFORM
being hijacked for NOMMU/XIP support.

We've worked around the issues with "multi-platform" XIP/NOMMU by
using things such as "ARM_SINGLE_V7M" to cover all V7M platforms
(which must, by definition) have compatible physical layouts.
Exactly the same approach should be adopted for other XIP/NOMMU
platforms, and _not_ reusing ARCH_MULTIPLATFORM, which will lead
to lots of non-bootable kernels.

Another problems for NOMMU is that the kernel has to be linked for
a specific _physical_ address.  When you have ARCH_MULTIPLATFORM
enabled, there is no facility to select that address.

Sorry, but reusing ARCH_MULTIPLATFORM is really a non-starter and
is confusing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
