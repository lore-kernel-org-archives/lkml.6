Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F292DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0F820663
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfAIT0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:26:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:31174 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfAIT0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:26:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 11:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="265833413"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga004.jf.intel.com with ESMTP; 09 Jan 2019 11:26:37 -0800
Date:   Wed, 9 Jan 2019 11:26:37 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Adam Borowski <kilobyte@angband.pl>, kvm <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 5.0-rc1 KVM inspired "BUG: Bad page state in process" spew
Message-ID: <20190109192637.GA1697@linux.intel.com>
References: <1547012338.4926.11.camel@gmx.de>
 <20190109144257.erwh52326ucgc5tw@angband.pl>
 <1547046196.31155.1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547046196.31155.1.camel@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 04:03:16PM +0100, Mike Galbraith wrote:
> On Wed, 2019-01-09 at 15:42 +0100, Adam Borowski wrote:
> > On Wed, Jan 09, 2019 at 06:38:58AM +0100, Mike Galbraith wrote:
> > > KVM seems to be busted in master ATM.  All I have to do to have host
> > > start screaming and maybe exploding (if the guest doesn't do so first)
> > > is to try to install a (obese in this case) kernel over nfs mount of
> > > the host in a guest.
> > > 
> > > Kernel producing the spew below is 3bd6e94, config attached.
> > 
> > I get same, except that the BUGs were preceded by a bunch of warnings,
> 
> Yeah, I was in too much of a rush...
> 
> > > homer: # grep BUG: /netconsole.log
> > > [ 1531.909703] BUG: Bad page state in process X  pfn:100491
> > > [ 1531.958141] BUG: Bad page state in process systemd-journal  pfn:100412
> > > [ 1532.662359] BUG: Bad page state in process X  pfn:10043f
> > > [ 1532.664033] BUG: Bad page state in process X  pfn:10044d
> > > [ 1532.686433] BUG: Bad page state in process systemd-journal  pfn:1027b0
> > 
> > the first one being:
> > 
> > Jan  9 00:41:22 umbar kernel: [74122.790461] WARNING: CPU: 2 PID: 26769 at arch/x86/kvm/mmu.c:830 mmu_spte_clear_track_bits+0x7e/0x100
> 
> ...I also get oodles of those.

There's also a bugzilla bug that's probably the same thing:
https://bugzilla.kernel.org/show_bug.cgi?id=202189.

I'm 99.9% confident this is only manifests when reclaiming from the guest,
i.e. host is swapping out a VM's memory.  The WARNING is complaining that
KVM is trying to reclaim a page before it has been removed from KVM's MMU,
i.e. a use-after-free scenario is imminent, and the stack trace shows the
kernel is reclaming.  The bug also listed host swapping as a possible
requirement, and last but not least, I was only able to reproduce this by
forcing reclaim.

I'll try to bisect.
