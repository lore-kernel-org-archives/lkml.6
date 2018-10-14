Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D16C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4120659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QlxpNzxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F4120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeJNVPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:15:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54434 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeJNVPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4+5BIwGkZ5fzO5Jb/ZW+HgKRlS4/jDjKt+4UtGEYqSk=; b=QlxpNzxYrDrnFczwEmitjWqiz
        wOti9c8fHhacIodmg4wyIaJV0KhST89twrFR4EZx+xCtiTUum76lq44OgTrmm2MRILa/tCkH767MT
        N4isVxJIsZDzs5ZINYJYNYMfmb4h9L1D+JR2C6WsAEw7rnpmSPlEepV32KKltASuNPbjU=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39214)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gBgWu-0003s9-82; Sun, 14 Oct 2018 14:34:00 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gBgWp-0005D9-4y; Sun, 14 Oct 2018 14:33:55 +0100
Date:   Sun, 14 Oct 2018 14:33:53 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Tianyu Lan <lantianyu1986@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
        benh@kernel.crashing.org, will.deacon@arm.com,
        christoffer.dall@arm.com, paulus@ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
        kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
        mpe@ellerman.id.au, the arch/x86 maintainers <x86@kernel.org>,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        catalin.marinas@arm.com, jhogan@kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
        haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
        liran.alon@oracle.com, Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
Message-ID: <20181014133352.GX30658@n2100.armlinux.org.uk>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <20181014092734.GV30658@n2100.armlinux.org.uk>
 <20181014093541.GW30658@n2100.armlinux.org.uk>
 <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 09:21:23PM +0800, Tianyu Lan wrote:
> Sorry to confuse your. I get from CCers from get_maintainer.pl script.

Unfortunately you seem to have made a mistake.  My email address is
'linux@armlinux.org.uk' not 'linux@armlinux.org'.  There is no
'linux@armlinux.org' in MAINTAINERS, yet your emails appear to be
copied to this address.

Consequently, if it was your intention to copy me with the entire
series, that didn't happen.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
