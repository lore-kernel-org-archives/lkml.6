Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeC0NQp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:16:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752841AbeC0NQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:16:40 -0400
Date: Tue, 27 Mar 2018 09:16:37 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: yael.chemla@foss.arm.com
Cc: "'Alasdair Kergon'" <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, ofir.drang@gmail.com,
        "'Yael Chemla'" <yael.chemla@arm.com>,
        "'Eric Biggers'" <ebiggers3@gmail.com>
Subject: Re: [PATCH 2/2] md: dm-verity: allow parallel processing of bio
 blocks
Message-ID: <20180327131636.GA26832@redhat.com>
References: <1522003290-27243-1-git-send-email-yael.chemla@foss.arm.com>
 <1522003290-27243-2-git-send-email-yael.chemla@foss.arm.com>
 <20180327010633.GB23487@redhat.com>
 <001201d3c5a9$529b4a10$f7d1de30$@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201d3c5a9$529b4a10$f7d1de30$@foss.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27 2018 at  4:55am -0400,
yael.chemla@foss.arm.com <yael.chemla@foss.arm.com> wrote:

> Hi Mike
> I need to rewrite these patches according to issues you and Eric Biggers mentioned.
> please drop this v1 patch.

They've been dropped.  BUT please do note that the patches I pushed to
linux-dm.git were rebased ontop of the 'check_at_most_once' patch.

I never did get an answer about how the sg array is free'd in certain
error paths (see "FIXME:" in the 2nd patch).

Also, I fixed some issues I saw in error paths, and lots of formatting.

I'll be pretty frustrated if you submit v2 that is blind to the kinds of
changes I made.

I'll send you a private copy of the patches just so you have them for
your reference.

Thanks,
Mike


> -----Original Message-----
> From: Mike Snitzer <snitzer@redhat.com> 
> Sent: Tuesday, 27 March 2018 4:07
> To: Yael Chemla <yael.chemla@foss.arm.com>
> Cc: Alasdair Kergon <agk@redhat.com>; dm-devel@redhat.com; linux-kernel@vger.kernel.org; ofir.drang@gmail.com; Yael Chemla <yael.chemla@arm.com>
> Subject: Re: [PATCH 2/2] md: dm-verity: allow parallel processing of bio blocks
> 
> On Sun, Mar 25 2018 at  2:41pm -0400,
> Yael Chemla <yael.chemla@foss.arm.com> wrote:
> 
> >  Allow parallel processing of bio blocks by moving to async. 
> > completion  handling. This allows for better resource utilization of 
> > both HW and  software based hash tfm and therefore better performance 
> > in many cases,  depending on the specific tfm in use.
> >  
> >  Tested on ARM32 (zynq board) and ARM64 (Juno board).
> >  Time of cat command was measured on a filesystem with various file sizes.
> >  12% performance improvement when HW based hash was used (ccree driver).
> >  SW based hash showed less than 1% improvement.
> >  CPU utilization when HW based hash was used presented 10% less 
> > context  switch, 4% less cycles and 7% less instructions. No 
> > difference in  CPU utilization noticed with SW based hash.
> >  
> > Signed-off-by: Yael Chemla <yael.chemla@foss.arm.com>
> 
> This one had various issues.  I've fixed most of what I saw and staged in linux-next (purely for build test coverage purposes).  I may drop this patch if others disagree with it (or my sg deallocation in the error path question isn't answered).
> 
> I've staged the changes here (and in linux-next via 'for-next'):
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-4.17
> 
> I switched all the new GFP_KERNEL uses to GFP_NOIO.  The fact that you're doing allocations at all (per IO) is bad enough.  Using GFP_KERNEL is a serious liability (risk of deadlock if dm-verity were to be used for something like.. swap.. weird setup but possible).
> 
> But the gfp flags aside, the need for additional memory and the expectation of scalable async parallel IO is potentially at odds with changes like this (that I just staged, and had to rebase your 2 patches ontop of):
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.17&id=a89f6a2cfec86fba7a115642ff082cb4e9450ea6
> 
> So I'm particulalry interested to hear from google folks to understand if they are OK with your proposed verity async crypto API use.
> 
> Mike
> 
