Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C103ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C4E21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HESfaEMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C4E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJQRaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:30:23 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43728 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeJQRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WhAI12FYVQO85QMw5kdYqnfbPICaeS7nkOFB1jG8r6U=; b=HESfaEMVhnVfAIgaISv4skLDt
        2wc5L8Q+qTACjtMXRclcJ+MQfQ8yS4k8KBn9JmbFX9LGsFuclphvoOXJ5C+WfR6TiDbWALwbJC/kc
        uDDpdPLvsgQHWh5C6VnX/B/u5zxfS7BUF3A34dLApDrwjAYjJWcc+IdWU7h87l3T5f2iI=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:45701)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gCiEZ-0003IK-OK; Wed, 17 Oct 2018 10:35:19 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gCiER-0003JT-Qd; Wed, 17 Oct 2018 10:35:13 +0100
Date:   Wed, 17 Oct 2018 10:35:08 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        stefan@agner.ch, ulli.kroll@googlemail.com, joel@jms.id.au,
        linux-kernel@vger.kernel.org, roman@advem.lv
Subject: Re: [PATCH] [ALTERNATIVE] ARM: fix copypage functions for clang
Message-ID: <20181017093508.GG30658@n2100.armlinux.org.uk>
References: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
 <20181017090417.833924-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017090417.833924-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:04:17AM +0200, Arnd Bergmann wrote:
> The constraints were originally added in commit 9a40ac86152c ("ARM:
> 6164/1: Add kto and kfrom to input operands list.") as a gcc-4.5
> workaround. Another workaround for the same problem was added in commit
> 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone and noinline
> on __naked functions") and should have obsoleted the first one.

That is an incorrect statement - please read the discussion back then,
particularly Mikael Pettersson's reply:

"I've tested and verified that this bit enables a gcc-4.5 compiled kernel
to boot on TS-119 (Kirkwood) when combined with my fix for __naked.
With neither or only one of the patches applied, the kernel oopses hard
in copy_user_page() as it tries to start /sbin/init."

That is very clear that it is not "one or the other" patch, and it's
certainly not true that one patch obsoletes the other.

Mikael is also very clear in the effects that are going on - to re-quote
what I've already quoted (and clearly you missed):

"- the asm() bodies of these __naked functions have inadequate input
  parameter constraints, in particular they fail to declare any
  dependencies on the functions' formal parameters; gcc-4.5 sees this
  and skips the parameter setup before calling these functions, causing
  runtime crashes"

This description makes it clear that it's not the naked function that
is wrong, but the function that _calls_ the naked function - stating
that GCC fails to setup the parameters _for_ _the_ _called_ _naked_
_function_.

So, there are two issues here:

1. gcc-4.5 has been observed to clone and inline naked functions, which
   you claim has been fixed.
2. gcc-4.5 fails to setup parameters for naked functions, which we have
   no idea whether it's been fixed.

> I've used this on my randconfig build setup, and it makes all
> configurations build without warnings, but I have not done
> any runtime testing on it.

Since the problem has always been a runtime issue, a build-only test is
insufficient.

Sorry, but no, this is way too risky in its current form.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
