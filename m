Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE838C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FF020842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551289869;
	bh=7YN4063YmBiMhJ/Damj47iX05J9RqIMMgLrL0EwSvrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ztC1pApWuI/wn1ifCl1kDGzGAEqUK2QDvt3sI6btPtKxNoIXuJkINr/bpG42xcpty
	 Do6PFqtgHcrKhq3yHtoo9xcTrPyxkdC/cmb6z3mnx+53E4QY/izJr5Z5JzxYRt/vet
	 xF0MQaXNSbvw0ZjdiCfAPce9rt9O5aw54U27PhqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfB0RvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:51:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:15949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfB0RvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:51:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="136770312"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2019 09:51:06 -0800
Date:   Wed, 27 Feb 2019 10:51:20 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Alex_Gagniuc@Dellteam.com
Cc:     torvalds@linux-foundation.org, axboe@fb.com, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, mr.nuke.me@gmail.com, hch@lst.de,
        jonathan.derrick@intel.com
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Message-ID: <20190227175119.GB19455@localhost.localdomain>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 04:42:05PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 2/26/19 7:02 PM, Linus Torvalds wrote:
> > On Tue, Feb 26, 2019 at 2:37 PM <Alex_Gagniuc@dellteam.com> wrote:
> >>
> >> Then nobody gets the (error) message. You can go a bit further and try
> >> 'pcie_ports=native". Again, nobody gets the memo. ):
> > 
> > So? The error was bogus to begin with. Why would we care?
> 
> Of course nobody cares about that. We care about actual errors that we 
> now know we won't be notified of. Imagine if we didn't get the memo that 
> a piece of data is corrupt, and imagine the reaction of RAS folk.
> 
> And I know the counter to that is a panic() is much more likely to cause 
> data corruption, and we're trading one piece of crap for an even 
> stinkier one. Whatever we end up doing, we have to do better than 
> silence errors and pretend nothing happened.
> 
> 
> > Yes, yes, PCI bridges have the ability to return errors in accesses to
> > non-existent devices. But that was always bogus, and is never useful.
> > The whole "you get an interrupt or NMI on a bad access" is simply a
> > horribly broken model. It's not useful.
> > 
> > We already have long depended on hotplug drivers noticing the "oh, I'm
> > getting all-ff returns, the device may be gone". It's usually trivial,
> > and works a whole lot better.
> 
> And that's been working great, hasn't it? I think you're thinking 
> strictly about hotplug. There are other situations where things are all 
> F'd, but the hardware isn't sending all F's. (example: ECRC errors)
> 
> 
> > It's not an error. Trying to force it to be an NMI or SCI or machine
> > check is bogus. It causes horrendous pain, because asynchronous
> > reporting doesn't work reliably anyway, and *synchronous* reporting is
> > impossible to sanely handle without crazy problems.
> > 
> > So the only sane model for hotplug devices is "IO still works, and
> > returns all ones". Maybe with an async one-time and *recoverable*
> > machine check or other reporting the access after the fact.
> 
> Exactly!!! A notification (not calling it an 'error') that something 
> unusual has happened is good. Treating these things like errors is so 
> obvious, even a caveman wouldn't do it.
> In a world with FFS, we don't always get to have that model. Oh, FFS!
> 
> 
> > Anything else is simply broken. It would be broken even if firmware
> > wasn't involved, but obviously firmware people tend to often make a
> > bad situation even worse.
> 
> Linus, be nice to firmware people. I've met a few, and I can vouch that 
> they're very kind and nice. They're also very scared, especially when OS 
> people want to ask them a few questions.
> 
> I think FFS should get out of the way when OS advertises it's capable of 
> handling XYZ. There are some good arguments why this hasn't happened, 
> but I won't get into details. I do think it's unlikely that machines 
> will be moving back to an OS-controlled model.
> 
> And Linus, keep in mind, when these machines were developed, OSes 
> couldn't handle recovery properly. None of this was ever an issue. It's 
> our fault that we've changed the OS after the machines are on the market.
> 
> Alex

I can't tell where you're going with this. It doesn't sound like you're
talking about hotplug anymore, at least.
