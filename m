Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31929FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C271120861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C271120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeINM1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:27:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbeINM1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CE25AE1D;
        Fri, 14 Sep 2018 07:14:35 +0000 (UTC)
Date:   Fri, 14 Sep 2018 09:14:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pingfan Liu <kernelfans@gmail.com>, jnwang@suse.com, tiwai@suse.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
Message-ID: <20180914071434.GB4747@zn.tnic>
References: <s5hk1ns1m8n.wl-tiwai@suse.de>
 <2551848.SakgYeHO72@aspire.rjw.lan>
 <CAFgQCTuNb4XOg6LaY=m92zbhDTNmYkh11Dxy4OGbXtY09oXb9A@mail.gmail.com>
 <1606736.qIHCQIUCDK@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1606736.qIHCQIUCDK@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jörg.

On Fri, Sep 14, 2018 at 08:26:07AM +0200, Rafael J. Wysocki wrote:
> On Friday, September 14, 2018 4:29:46 AM CEST Pingfan Liu wrote:
> > On Thu, Sep 13, 2018 at 10:15 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Thursday, September 13, 2018 12:03:36 PM CEST James Wang wrote:
> > > >  This is a multi-part message in MIME format.
> > > > --------------F5519E624D0AD1E3F7DDA019
> > > > Content-Type: text/plain; charset=utf-8
> > > > Content-Transfer-Encoding: 8bit
> > > >
> > > >
> > > >
> > > > On 09/11/2018 02:15 PM, Takashi Iwai wrote:
> > > > > On Tue, 11 Sep 2018 14:11:30 +0200,
> > > > > James Wang wrote:
> > > > >> I did try it from kernel : head
> > > > > OK, then the bug is present with 4.19-rc2, at least.
> > > > > Please check my test kernel later (it's still being built).
> > > > Hi folks,  I attach two log about 4.19-rc3 and 4.19-rc3+Rafeal suggestion.
> > >
> > > OK, no difference AFAICS.
> > >
> > > This means that the commit turned up by bisection simply uncovered an existing
> > > ordering issue, apparently between an IOMMU and its client (ie. it appears that
> > > the client is shut down after the IOMMU).
> > >
> > > This isn't limited to shutdown and you'd see the same issue on system-wide
> > > suspend/resume (in fact, the Pingfan Liu's patches make shutdown use the
> > > same device list that is used for system-wide PM).
> > >
> > > One way to mitigate such issues is to add a device link between the two
> > > devices in question to enforce the correct suspend/resume/shutdown ordering
> > > between them.
> > >
> > I found the iommu was at  " 0000:00:00.2", while  ohci-pci is at
> > 0000:00:13.1. Hence ohci-pci should be shutdown before iommu. Not
> > familiar with AMD's iommu code, but I think there is no shutdown
> > interface exported to drivers/base. It is shutdown by platform code in
> > arch/x86. So I think there should be someone teared down the iotbl,
> > e.g. by invalidating pages, before the shutdown of ohci-pci. I wonder
> > whether adding a device link can fix this bug or not. (Forgive me if I
> > made a mistake, since I am ignorant in this field)
> 
> Adding a device link should help, as it effectively causes dpm_list to
> be reordered in accordance with the link direction, but it also takes
> care of the other children and linked devices as appropriate.
> 
> The difficulty is that whoever wants to add a device link between two
> devices needs to have pointers to the device objects in question upfront.
> 
> Thanks,
> Rafael
> 

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
