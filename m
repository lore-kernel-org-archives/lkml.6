Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722C72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="chAcDzdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfARQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:37:48 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60300 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfARQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NqdGEANMNH6dnO3JH6obgQjJ9XDpcnvBuNABoxhKWI0=; b=chAcDzdhqYh2+DZRTV362hzgI
        911aQjXCqvvUVUvLFB5yg9Xwkuz3areZJXDfcRbctDlCvuYS7cdWW9jGha+eg779t97Yv7dfHPkbR
        YhJdlqvsAv0Eo9HzTAl2nWLXWVJJO71elM5GcCfrkjrFcjVN+hYwS9p5YOSos6c6HF/lI=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:37828 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gkX9F-0000Ne-Oz; Fri, 18 Jan 2019 16:37:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gkX9F-0001iJ-38; Fri, 18 Jan 2019 16:37:37 +0000
Date:   Fri, 18 Jan 2019 16:37:36 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, rjw@rjwysocki.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Price <Steven.Price@arm.com>,
        Grant Likely <Grant.Likely@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS
 macro
Message-ID: <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:00:27PM +0000, Andrew Murray wrote:
> A common pattern found in header files is a function declaration dependent
> on a CONFIG_ option being enabled, followed by an empty function for when
> that option isn't enabled. This boilerplate code can often take up a lot
> of space and impact code readability.
> 
> This series introduces a STUB_UNLESS macro that simplifies header files as
> follows:
> 
> STUB_UNLESS(CONFIG_FOO, [body], prototype)

Can you explain the desire to make the second argument optional,
rather than having the mandatory arguments first and the optional body
last?  It will mean more lines at each site, but I don't think that's
a bad thing:

STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
void hw_breakpoint_thread_switch(struct task_struct *next));

STUB_UNLESS(CONFIG_CPU_FREQ,
struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu), return NULL);

or:

STUB_UNLESS(CONFIG_CPU_FREQ,
struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu),
	return NULL);

Seems to be more readable in terms of the flow.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
