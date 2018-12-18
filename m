Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37033C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ACC2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D8uioB4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeLRR17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:27:59 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45054 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeLRR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S6vVp4p5VJRi7FiPm/Wm3kO9MzkbRcP5S+MOMBuvwzE=; b=D8uioB4qAd8/hm5qDgSspv4yX
        /5/tcNWreTzu/GhWZhFNFcoIoOfRWqsWJRSs16zcg3z27ySCP+hX64PGF6qzAaKGn7pq0ObVUpVM8
        Obu8Ae/X2x6ezO1GSf3SQwPrRy810Udt0nMTPSl89T7azts+VMpTV9uzYyGRKkj5mJAjg=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:48184)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZJ9t-0007M7-9g; Tue, 18 Dec 2018 17:27:53 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZJ9q-0002E2-Ih; Tue, 18 Dec 2018 17:27:50 +0000
Date:   Tue, 18 Dec 2018 17:27:48 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Message-ID: <20181218172748.GQ26090@n2100.armlinux.org.uk>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
 <20181218155239.GP26090@n2100.armlinux.org.uk>
 <b26902d8-79d6-2b09-6e35-9e8823f9181e@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26902d8-79d6-2b09-6e35-9e8823f9181e@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:05:18PM +0000, Patrice CHOTARD wrote:
> Hi Russell
> 
> On 12/18/18 4:52 PM, Russell King - ARM Linux wrote:
> > On Tue, Dec 18, 2018 at 03:48:13PM +0100, patrice.chotard@st.com wrote:
> >> From: Patrice Chotard <patrice.chotard@st.com>
> >>
> >> Due to pen_release and boot_lock removal, secondary CPU's bringup
> >> was broken. Restore CPU's bringup by reworking properly
> >> .smp_prepare_cpus and .smp_boot_secondary STi callbacks.
> > 
> > Sorry, maybe I don't understand your commit message, but you seem to be
> > saying that removal of the pen_release and boot_lock broke STi's secondary
> > CPU bring up?  Please clarify, and explain how that happened.
> 
> Correct, CPU1 failed to come online.
> 
> It seems that writing secondary_startup address at cpu-release-addr in
> .smp_prepare_cpus callback was too early.
> 
> Doing it in .smp_boot_secondary callback, insures that secondary_data
> struct is populated in __cpu_up() (stack, pgdir and swapper_pg_dir fields).

Ah, you're saying that it causes the CPU to jump to secondary_startup
while the boot CPU is in smp_prepare_cpus()?  What triggers the CPU
to jump to the address written to cpu_strt_ptr?  What you're saying
seems to suggest that it's the write to that address, rather than the
IPI that's sent in sti_boot_secondary().

If the IPI in sti_boot_secondary() isn't doing anything, it ought to
be removed.  It'd also be a good idea to document what's going on as
comments in the code for future maintanence.

> If you are ok, i will pick up your patch [1] and this one to prepare a
> STi pull-request.

Yes, although I'll have to delay patch 9 as a result.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
