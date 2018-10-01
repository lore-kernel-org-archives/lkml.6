Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B500EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62123208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SjxGBCx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62123208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeJBAf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:35:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47912 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeJBAf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ya/C5fVXcJAQGG0zxT2+ZLbdshs05hMdROJ40WShiKA=; b=SjxGBCx3Ez7dHgQRN8qWLTuij
        d5oToCw+/QWLihMtH2SJLbwCidq0DO7HdK9RMkrkPpHgtGrvSKwU2bJc4lU28xQ58YcNgpM1jFSFb
        lM6eHQgUjKil2PWMqZQntsAsRg7XHV3QH6iVWIb4TjGU0+/ar9hWz0jZJjw82cdXiPOZg=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:47940)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g72Ql-00072c-LQ; Mon, 01 Oct 2018 18:56:27 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g72Qi-00086g-TP; Mon, 01 Oct 2018 18:56:25 +0100
Date:   Mon, 1 Oct 2018 18:56:22 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
Message-ID: <20181001175622.GT30658@n2100.armlinux.org.uk>
References: <20180930024904.14240-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930024904.14240-1-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 04:49:04AM +0200, Jason A. Donenfeld wrote:
> Per the discussion about half-way down in [1], the kernel doesn't
> actually support the ARMv3 ISA, but selects it for some ARMv4 ISA
> hardware that benefits from ARMv3 code generation.

The issue is to do with the half-word stores in the ARMv4 ISA, which
need to be avoided on StrongARM RiscPC - the bus from the processor
card (which was designed for ARM610 and ARM710) does not support
anything except 8-bit and 32-bit accesses, so the 16-bit load/store
instructions don't work correctly.

Obviously, the reason for having the compiler use ARMv3 is to avoid
those instructions which we have no other way to prevent - however,
the use of ARMv3 with the assembler ensures that ldrh/strh are not
accidentally used.

We could argue that the ARMv3 assembly files are now stable, so the
chances of ldrh/strh being introduced is low, which would make this
change tolerable, but the commit message needs to spell out that
we lose this protection.

> Such a consideration,
> then, only applies to the compiler but not to the assembler. This commit
> passes -march=armv4 to the assembler in those cases, so that code
> written for ARMv4 will continue to compile and run fine, without needing
> module-specific asflags-y overrides.

Note that "code written for ARMv4" will not be usable on this platform
if it makes use of ldrh/strh, so depending on which instructions the
assembler is complaining about, it could very well be a real "you're
doing something wrong" case.

The side effect of this patch is that such cases will now be hidden
rather than evaluated on a case-by-case basis.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 14.8Mbps down 650kbps up
According to speedtest.net: 13Mbps down 490kbps up
