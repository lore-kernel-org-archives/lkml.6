Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45771C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEBC2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550490064;
	bh=zWmFgIQKw0FVyX1dbFQvF5dxRdUyo7WVWoRRNaYxDd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P2E8NmIhkKvEn9HPzRDmTsg1v3c0nY8RUjOYyXDVsbN+GRHJdNoS5DW+qctMzmm/k
	 +3f/VJZyDsvf3IBrgZNEGjteQeWUEWvaRjqrimk6/LJyDRnTL62mwhqSihT0IH3Vz3
	 QHdK0CTW/vC1gH8u5922bAC3/ezL3ZNkp6lmOEJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfBRLlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:41:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbfBRLlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:41:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A8220C01;
        Mon, 18 Feb 2019 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550490060;
        bh=zWmFgIQKw0FVyX1dbFQvF5dxRdUyo7WVWoRRNaYxDd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AARcTHs6uUeI/sLySy4ytX7UPReX/2DbgCnQZ0toCP5jNwAttlZVK3ljYhwypIFZP
         LMW+elBNz3DMg7UKXA0dB7Igld+AeN6R6BQxpBpXolNRPGUjjjZwdEpG/cWd0sEUur
         vU7bnCFDqvX2iCrg4I73MB8hTnKhCuydSiR6nwUY=
Date:   Mon, 18 Feb 2019 12:40:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel+linux-scsi@molgen.mpg.de>
Cc:     Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+linux-scsi@molgen.mpg.de,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        linux-scsi@vger.kernel.org,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>
Subject: Re: aacraid: Regression in 4.14.56 with *genirq/affinity: assign
 vectors to all possible CPUs*
Message-ID: <20190218114057.GB27643@kroah.com>
References: <06ee23fe-ec9e-d67b-b533-d5151be74a11@molgen.mpg.de>
 <20180810133628.GA4131@kroah.com>
 <29b5f3ce-2c23-bf5e-fe50-29bedd4833e1@molgen.mpg.de>
 <20180810155511.GA17092@kroah.com>
 <f5c57bf7-b8c1-a560-d13a-d74e0f27adbb@molgen.mpg.de>
 <20180811135021.GA2186@kroah.com>
 <20180813033157.GA18254@ming.t460p>
 <89f2b622-3d2a-04ce-a6d1-ffb5d9612763@molgen.mpg.de>
 <cbd7cb64-dbfe-e085-e80b-67dad4084d69@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbd7cb64-dbfe-e085-e80b-67dad4084d69@molgen.mpg.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:53:54PM +0200, Paul Menzel wrote:
> Dear Ming, dear Raghava, dear Dave,
> 
> 
> On 08/16/18 19:09, Paul Menzel wrote:
> 
> > On 08/13/18 05:32, Ming Lei wrote:
> >> On Sat, Aug 11, 2018 at 03:50:21PM +0200, Greg Kroah-Hartman wrote:
> >>> On Sat, Aug 11, 2018 at 10:14:18AM +0200, Paul Menzel wrote:
> > 
> >>>> Am 10.08.2018 um 17:55 schrieb Greg Kroah-Hartman:
> >>>>> On Fri, Aug 10, 2018 at 04:11:23PM +0200, Paul Menzel wrote:
> >>>>
> >>>>>> On 08/10/18 15:36, Greg Kroah-Hartman wrote:
> >>>>>>> On Fri, Aug 10, 2018 at 03:21:52PM +0200, Paul Menzel wrote:
> > 
> >>>>>>>> Commit ef86f3a7 (genirq/affinity: assign vectors to all possible CPUs) added
> >>>>>>>> for Linux 4.14.56 causes the aacraid module to not detect the attached devices
> >>>>>>>> anymore on a Dell PowerEdge R720 with two six core 24x E5-2630 @ 2.30GHz.
> >>>>>>>>
> >>>>>>>> ```
> >>>>>>>> $ dmesg | grep raid
> >>>>>>>> [    0.269768] raid6: sse2x1   gen()  7179 MB/s
> >>>>>>>> [    0.290069] raid6: sse2x1   xor()  5636 MB/s
> >>>>>>>> [    0.311068] raid6: sse2x2   gen()  9160 MB/s
> >>>>>>>> [    0.332076] raid6: sse2x2   xor()  6375 MB/s
> >>>>>>>> [    0.353075] raid6: sse2x4   gen() 11164 MB/s
> >>>>>>>> [    0.374064] raid6: sse2x4   xor()  7429 MB/s
> >>>>>>>> [    0.379001] raid6: using algorithm sse2x4 gen() 11164 MB/s
> >>>>>>>> [    0.386001] raid6: .... xor() 7429 MB/s, rmw enabled
> >>>>>>>> [    0.391008] raid6: using ssse3x2 recovery algorithm
> >>>>>>>> [    3.559682] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
> >>>>>>>> [    3.570061] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
> >>>>>>>> [   10.725767] Adaptec aacraid driver 1.2.1[50834]-custom
> >>>>>>>> [   10.731724] aacraid 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
> >>>>>>>> [   10.743295] aacraid: Comm Interface type3 enabled
> >>>>>>>> $ lspci -nn | grep Adaptec
> >>>>>>>> 04:00.0 Serial Attached SCSI controller [0107]: Adaptec Series 8 12G SAS/PCIe 3 [9005:028d] (rev 01)
> >>>>>>>> 42:00.0 Serial Attached SCSI controller [0107]: Adaptec Smart Storage PQI 12G SAS/PCIe 3 [9005:028f] (rev 01)
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>> But, it still works with a Dell PowerEdge R715 with two eight core AMD
> >>>>>>>> Opteron 6136, the card below.
> >>>>>>>>
> >>>>>>>> ```
> >>>>>>>> $ lspci -nn | grep Adaptec
> >>>>>>>> 22:00.0 Serial Attached SCSI controller [0107]: Adaptec Series 8 12G SAS/PCIe 3 [9005:028d] (rev 01)
> >>>>>>>> ```
> >>>>>>>>
> >>>>>>>> Reverting the commit fixes the issue.
> >>>>>>>>
> >>>>>>>> commit ef86f3a72adb8a7931f67335560740a7ad696d1d
> >>>>>>>> Author: Christoph Hellwig <hch@lst.de>
> >>>>>>>> Date:   Fri Jan 12 10:53:05 2018 +0800
> >>>>>>>>
> >>>>>>>>      genirq/affinity: assign vectors to all possible CPUs
> >>>>>>>>      commit 84676c1f21e8ff54befe985f4f14dc1edc10046b upstream.
> >>>>>>>>      Currently we assign managed interrupt vectors to all present CPUs.  This
> >>>>>>>>      works fine for systems were we only online/offline CPUs.  But in case of
> >>>>>>>>      systems that support physical CPU hotplug (or the virtualized version of
> >>>>>>>>      it) this means the additional CPUs covered for in the ACPI tables or on
> >>>>>>>>      the command line are not catered for.  To fix this we'd either need to
> >>>>>>>>      introduce new hotplug CPU states just for this case, or we can start
> >>>>>>>>      assining vectors to possible but not present CPUs.
> >>>>>>>>      Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>>>>>>      Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>>>>>>      Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
> >>>>>>>>      Fixes: 4b855ad37194 ("blk-mq: Create hctx for each present CPU")
> >>>>>>>>      Cc: linux-kernel@vger.kernel.org
> >>>>>>>>      Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>>>>>>      Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>>>>>>>      Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>>>>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>>>>
> >>>>>>>> The problem doesn’t happen with Linux 4.17.11, so there are commits in
> >>>>>>>> Linux master fixing this. Unfortunately, my attempts to find out failed.
> >>>>>>>>
> >>>>>>>> I was able to cherry-pick the three commits below on top of 4.14.62,
> >>>>>>>> but the problem persists.
> >>>>>>>>
> >>>>>>>> 6aba81b5a2f5 genirq/affinity: Don't return with empty affinity masks on error
> >>>>>>>> 355d7ecdea35 scsi: hpsa: fix selection of reply queue
> >>>>>>>> e944e9615741 scsi: virtio_scsi: fix IO hang caused by automatic irq vector affinity
> >>>>>>>>
> >>>>>>>> Trying to cherry-pick the commits below, referencing the commit
> >>>>>>>> in question, gave conflicts.
> >>>>>>>>
> >>>>>>>> 1. adbe552349f2 scsi: megaraid_sas: fix selection of reply queue
> >>>>>>>> 2. d3056812e7df genirq/affinity: Spread irq vectors among present CPUs as far as possible
> >>>>>>>>
> >>>>>>>> To avoid further trial and error with the server with a slow firmware,
> >>>>>>>> do you know what commits should fix the issue?
> >>>>>>>
> >>>>>>> Look at the email on the stable mailing list:
> >>>>>>> 	Subject: Re: Fix for 84676c1f (b5b6e8c8) missing in 4.14.y
> >>>>>>> it should help you out here.
> >>>>>>
> >>>>>> Ah, I didn’t see that [1] yet. Also I can’t find the original message, and a
> >>>>>> way to reply to that thread. Therefore, here is my reply.
> >>>>>>
> >>>>>>> Can you try the patches listed there?
> >>>>>>
> >>>>>> I tried some of these already without success.
> >>>>>>
> >>>>>> b5b6e8c8d3b4 scsi: virtio_scsi: fix IO hang caused by automatic irq vector affinity
> >>>>>> 2f31115e940c scsi: core: introduce force_blk_mq
> >>>>>> adbe552349f2 scsi: megaraid_sas: fix selection of reply queue
> >>>>>>
> >>>>>> The commit above is already in v4.14.56.
> >>>>>>
> >>>>>> 8b834bff1b73 scsi: hpsa: fix selection of reply queue
> >>>>>>
> >>>>>> The problem persists.
> >>>>>>
> >>>>>> The problem also persists with the state below.
> >>>>>>
> >>>>>> 3528f73a4e5d scsi: core: introduce force_blk_mq
> >>>>>> 16dc4d8215f3 scsi: hpsa: fix selection of reply queue
> >>>>>> f0a7ab12232d scsi: virtio_scsi: fix IO hang caused by automatic irq vector affinity
> >>>>>> 6aba81b5a2f5 genirq/affinity: Don't return with empty affinity masks on error
> >>>>>> 1aa1166eface (tag: v4.14.62, stable/linux-4.14.y) Linux 4.14.62
> >>>>>>
> >>>>>> So, some more commits are necessary.
> >>>>>
> >>>>> Or I revert the original patch here, and the follow-on ones that were
> >>>>> added to "fix" this issue.  I think that might be the better thing
> >>>>> overall here, right?  Have you tried that?
> >>>>
> >>>> Yes, reverting the commit fixed the issue for us. If Christoph or Ming do
> >>>> not have another suggestion for a commit, that would be the way to go.
> >>>
> >>> Christoph or Ming, any ideas here?
> >>>
> >>> In looking at the aacraid code, I don't see anywhere that this is using
> >>> a specific cpu number for queues or anything, but I could be wrong.
> >>> Ideally this should also be failing in 4.17 or 4.18-rc right now as well
> >>> as I don't see anything that would have "fixed" this recently.  Unless
> >>> I'm missing something here?
> >>
> >> From both aac_fib_vector_assign() and aac_src_deliver_message(), looks
> >> every msix vector is used inside driver, so causes this trouble.
> >>
> >> From 84676c1f21e8ff54b (genirq/affinity: assign vectors to all possible CPUs),
> >> actually it should have been since 9a0ef98e18 (genirq/affinity: Assign vectors
> >> to all present CPUs), it isn't guaranteed that one vector can be mapped to
> >> at least one online CPU.
> >>
> >> So it should be fixed in driver by similar approach taken in the
> >> following patches:
> >> 	scsi: hpsa: fix selection of reply queue
> >> 	scsi: megaraid_sas: fix selection of reply queue
> >>
> >> And the reason this issue won't be observed is that the following
> >> patches(merged to v4.17) may avoid this issue, but in theory, the issue
> >> won't be avoided completely by these patches:
> >>
> >> d3056812e7df genirq/affinity: Spread irq vectors among present CPUs as far as possible
> >> 1a2d0914e23a genirq/affinity: Allow irq spreading from a given starting point
> >> b3e6aaa8d94d genirq/affinity: Move actual irq vector spreading into a helper function
> >> 47778f33dcba genirq/affinity: Rename *node_to_possible_cpumask as *node_to_cpumask
> >> 0211e12dd0a5 genirq/affinity: Don't return with empty affinity masks on error
> >>
> >> In short, this issue should have been fixed in upstream aacraid, and the idea
> >> is simple, use the current CPU id to retrieve the msix vector offset, this
> >> way will make sure that the msix vector can be mapped from one online
> >> CPU.
> > 
> > AACRAID folks, are you going to work on that? I looked at the code a bit,
> > and it’ll take me some days to understand it and to fix it.
> 
> Unfortunately, there was no reply yet and I won’t be able to fix it any
> time soon. The aacraid driver is still broken in 4.14.68. Reverting the
> *one* mentioned commit fixes the issue.
> 
> Raghava, Dave, are you aware of the issue.

I'm pretty sure this should now be fixed, have you tested this recently?

thanks,

greg k-h
