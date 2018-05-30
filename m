Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965225AbeE3DSA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935743AbeE3DRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:17:48 -0400
Date: Tue, 29 May 2018 21:17:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
        Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Message-ID: <20180529211746.74f1dd23@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911E59C4@SHSMSX101.ccr.corp.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <20180417131047.0a9c310f@w520.home>
        <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
        <20180420164251.5245f822@jacob-builder>
        <20180529140915.1f174689@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D1911E59C4@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 01:41:43 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, May 30, 2018 4:09 AM
> > 
> > On Fri, 20 Apr 2018 16:42:51 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > On Fri, 20 Apr 2018 19:25:34 +0100
> > > Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com> wrote:
> > >  
> > > > On Tue, Apr 17, 2018 at 08:10:47PM +0100, Alex Williamson wrote:
> > > > [...]  
> > > > > > +	/* Assign guest PASID table pointer and size order */
> > > > > > +	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
> > > > > > +		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);  
> > > > >
> > > > > Where does this IOMMU API interface define that base_ptr is 4K
> > > > > aligned or the format of the PASID table?  Are these all
> > > > > standardized or do they vary by host IOMMU?  If they're standards,
> > > > > maybe we could note that and the spec which defines them when we
> > > > > declare base_ptr.  If they're IOMMU specific then I don't
> > > > > understand how we'll match a user provided PASID table to the
> > > > > requirements and format of the host IOMMU. Thanks,  
> > > >
> > > > On SMMUv3 the minimum alignment for base_ptr is 64 bytes, so a  
> > guest  
> > > > under a vSMMU might pass a pointer that's not aligned on 4k.
> > > >  
> > > PASID table pointer for VT-d is 4K aligned.  
> > > > Maybe this information could be part of the data passed to userspace
> > > > about IOMMU table formats and features? They're not part of this
> > > > series, but I think we wanted to communicate IOMMU-specific features
> > > > via sysfs.
> > > >  
> > > Agreed, I believe Yi Liu is working on a sysfs interface such that QEMU
> > > can match IOMMU model and features.  
> > 
> > Digging this up again since v5 still has this issue.  The IOMMU API is
> > a kernel internal abstraction of the IOMMU.  sysfs is a userspace
> > interface.  Are we suggesting that the /only/ way to make use of the
> > internal IOMMU API here is to have a user provided opaque pasid table
> > that we can't even do minimal compatibility sanity testing on and we
> > simply hope that hardware covers all the fault conditions without
> > taking the host down with it?  I guess we have to assume the latter
> > since the user has full control of the table, but I have a hard time
> > getting past lack of internal ability to use the interface and no
> > ability to provide even the slimmest sanity testing.  Thanks,
> >   
> 
> checking size, alignment, ... is OK, which I think is already considered
> by vendor IOMMU driver. However sanity testing table format might 
> be difficult. The initial table provided by guest is likely just all ZEROs. 
> whatever format violation may be caught only when a PASID entry 
> is updated...

There's sanity testing the actual contents of the table, which I agree
would be difficult and would likely require some sort of shadowing at
additional overhead, but what about even basic consistency checking?
For example, is it possible that due to hardware variations a user
might generate a table which works on some systems but not others?  What
if two table formats are sufficiently similar that the IOMMU driver
puts an incompatible table in place but it continuously generates
faults, how do we debug that?  As an intermediary in this whole process
I'd really rather be able to identify that the user claims to be
providing a TypeA table but the IOMMU only supports TypeB, so clearly
this won't work.  I don't see that we have that capability.  Thanks,

Alex
