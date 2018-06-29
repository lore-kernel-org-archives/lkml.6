Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E18C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A4D27C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A4D27C7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeF2Jhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:37:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58294 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeF2Jho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:37:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908BA18A;
        Fri, 29 Jun 2018 02:37:44 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3888D3F266;
        Fri, 29 Jun 2018 02:37:42 -0700 (PDT)
Date:   Fri, 29 Jun 2018 10:39:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Message-ID: <20180629093927.GA9576@red-moon>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
 <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180613221509.GB12463@bjorn-Precision-5520>
 <KL1P15301MB0006CAB372940BA3C42F1C58BF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1P15301MB0006CAB372940BA3C42F1C58BF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:50:05PM +0000, Dexuan Cui wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, June 13, 2018 15:15
> > > ...
> > > It looks Lorenzo's pci.git tree has not been updated for 3+ weeks.
> > > I guess Lorenzo may be on vacation.
> > >
> > > @Bjorn, can this patch go through your tree?
> > > Should I resubmit it?
> > 
> > No need to resubmit it, Lorenzo has been out for a bit, but I'm sure
> > he'll pick this up as he catches up.
> OK, I see. Thanks!
>  
> > You might, however, fix the commit log:
> > 
> >   This is not an issue because hv_pci_onchannelcallback() is not slow,
> >   and it not a hot path.
> > 
> > This has at least one typo (I think you mean "and *is* not a hot
> > path").
> Sorry -- yes, it's a typo. I hope Lorenzo can help to fix this, or I can
> resubmit it if Lorenzo or you want me to do it.
>  
> > I also don't understand the sentence as a whole because the
> > hv_pci_onchannelcallback() comment says it's called whenever the host
> > sends a packet to this channel, and that *does* sound like a hot path.
> Sorry for not making it clear.
> The host only sends a packet into the channel of the guest when there
> is a change of device configuration (i.e. hot add or remove a device), or
> the host is responding to the guest's request.
> 
> The change of device configuration is only triggered on-demand by the
> administrator on the host, and the guest's requests are one-off when
> the device is probed.
> 
> So IMO the callback is not a hot path.
> 
> > I also don't understand the "hv_pci_onchannelcallback() is not slow"
> > part.  In other words, you're saying hv_pci_onchannelcallback() is
> > fast and it's not a hot path.  And apparently this has something to do
> > with the difference between local_bh_disable() and local_irq_save()?
> > 
> > Bjorn
> Actually in my original internal version of the patch, I did use 
> local_irq_save/restore().
> 
> hv_pci_onchannelcallback() itself runs fast, but here since it's in a
> loop (i.e. the while (!try_wait_for_completion(&comp.comp_pkt.host_event)
> loop), IIRC I was asked if I really need local_irq_save/restore(),
> and I answered "not really", so later I switched to local_bh_disable()/enable().
> 
> However, recently I found that if we enable CONFIG_PROVE_LOCKING=y,
> the local_bh_enable() can trigger a warning because the function 
> hv_compose_msi_msg() can be called with local IRQs disabled (BTW,
> hv_compose_msi_msg() can also be called with local IRQS enabled in
> another code path):
> 
> IRQs not enabled as expected
>   WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip
> 
> Despite the warning, the code itself can still work correctly, but IMO we'd
> better switch back to local_irq_save/restore(), and hence I made the patch.
> 
> I hope the explanation sounds reasonable. :-)

Sorry for the delay in replying. I need to understand if you are
preventing a spurious lockdep warning or you are fixing a kernel
bug. From your commit log, I assume the former option but I do
not think that's what you are really doing.

Apart from the commit log typos fixes I would like a log that
explains *why* this is not a kernel bug fix rather than a harmless
lockdep warning prevention.

Thanks,
Lorenzo
