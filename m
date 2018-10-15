Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556ABC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C5B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdsNnBxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C5B20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeJOVHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeJOVHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:07:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D8B20652;
        Mon, 15 Oct 2018 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539609705;
        bh=EttJNjnWWnV+ufDqT2ujCAxPFwgir9Vg0eBdXGB7+eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdsNnBxwDgotfB26ilBmrmDyAmpEvY35+wl3rlvDaJl0Mps1erPA+PDpxBAvOTIk0
         uAMrsUGeKi8HDQiVSD1TNr/FOtrssXOF20LZO27LELwxbqHb+YMbUW0ZFrrLfml7Pz
         OtJVtDryBtHI6V9UlMlGpaA+IqAmQQxmru/Csfvw=
Date:   Mon, 15 Oct 2018 15:21:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel+linux-scsi@molgen.mpg.de>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+linux-scsi@molgen.mpg.de,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        linux-scsi@vger.kernel.org,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>
Subject: Re: [PATCH] Revert "genirq/affinity: assign vectors to all possible
 CPUs"
Message-ID: <20181015132142.GA389@kroah.com>
References: <f5c57bf7-b8c1-a560-d13a-d74e0f27adbb@molgen.mpg.de>
 <20180811135021.GA2186@kroah.com>
 <20180813033157.GA18254@ming.t460p>
 <89f2b622-3d2a-04ce-a6d1-ffb5d9612763@molgen.mpg.de>
 <cbd7cb64-dbfe-e085-e80b-67dad4084d69@molgen.mpg.de>
 <7c51fe1d-d591-90f2-8fb5-81990f8db0fe@molgen.mpg.de>
 <20181001123508.GA3415@lst.de>
 <f5dde120-2d14-a7e5-8402-401f117b8c38@molgen.mpg.de>
 <3480086a-1a3e-adc2-e127-8e34178da101@molgen.mpg.de>
 <6b7555c7-8796-eae9-6bd2-b698ccf9559d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b7555c7-8796-eae9-6bd2-b698ccf9559d@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:17:11PM +0200, Paul Menzel wrote:
> Dear Greg, dear Linux folks,
> 
> 
> On 10/01/18 17:59, Paul Menzel wrote:
> 
> > On 10/01/18 14:43, Paul Menzel wrote:
> > 
> >> On 10/01/18 14:35, Christoph Hellwig wrote:
> >>> On Mon, Oct 01, 2018 at 02:33:07PM +0200, Paul Menzel wrote:
> >>>> Date: Wed, 29 Aug 2018 17:28:45 +0200
> >>>>
> >>>> This reverts commit ef86f3a72adb8a7931f67335560740a7ad696d1d.
> >>>
> >>> This seems rather odd.  If at all you'd revert the patch adding the
> >>> PCI_IRQ_AFFINITY to aacraid, not core infrastructure.
> >>
> >> Thank you for the suggestion, but that flag was added in 2016
> >> to the aacraid driver.
> >>
> >>> commit 0910d8bbdd99856af1394d3d8830955abdefee4a
> >>> Author: Hannes Reinecke <hare@suse.de>
> >>> Date:   Tue Nov 8 08:11:30 2016 +0100
> >>>
> >>>     scsi: aacraid: switch to pci_alloc_irq_vectors
> >>>     
> >>>     Use pci_alloc_irq_vectors and drop the hand-crafted interrupt affinity
> >>>     routines.
> >>
> >> So what would happen, if `PCI_IRQ_AFFINITY` was removed? Will the
> >> system still work with the same performance?
> >>
> >> As far as I understood, the no regression policy is there for
> >> exactly that reason, and it shouldn’t matter if it’s core
> >> infrastructure or not. As written, I have no idea, and just know
> >> reverting the commit in question fixes the problem here. So I’ll
> >> gladly test other solutions to fix this issue.
> > 
> > Just as another datapoint, with `PCI_IRQ_AFFINITY` removed from
> > `drivers/scsi/aacraid/comminit.c` in Linux 4.14.73, the driver
> > initializes correctly. I have no idea regarding the performance.
> 
> This commit has not been picked up yet. I guess, you are busy, but
> in case there are still objections, it’d be great if the two
> questions below were answered.
> 
> 1.  What bug is fixed in the LTS series by backporting the commit
>     causing the regression?

I can't remember anymore, but unwinding this mess is going to be a pain :(

> 2.  Why does the *no regression* policy *not* apply in this case?

It does, but also we are following the "stick to what mainline does",
and the fact that this is not showing up in mainline seems just to be a
lucky accident at the moment.  My real worry is that suddenly you are
going to have problems there and that this is just the early-warning
system happening...

thanks,

greg k-h
