Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966588AbeE2UJS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:09:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40227 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966179AbeE2UJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:09:17 -0400
Date: Tue, 29 May 2018 14:09:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Message-ID: <20180529140915.1f174689@w520.home>
In-Reply-To: <20180420164251.5245f822@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <20180417131047.0a9c310f@w520.home>
        <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
        <20180420164251.5245f822@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 16:42:51 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> On Fri, 20 Apr 2018 19:25:34 +0100
> Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com> wrote:
> 
> > On Tue, Apr 17, 2018 at 08:10:47PM +0100, Alex Williamson wrote:
> > [...]  
> > > > +	/* Assign guest PASID table pointer and size order */
> > > > +	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
> > > > +		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);    
> > > 
> > > Where does this IOMMU API interface define that base_ptr is 4K
> > > aligned or the format of the PASID table?  Are these all
> > > standardized or do they vary by host IOMMU?  If they're standards,
> > > maybe we could note that and the spec which defines them when we
> > > declare base_ptr.  If they're IOMMU specific then I don't
> > > understand how we'll match a user provided PASID table to the
> > > requirements and format of the host IOMMU. Thanks,    
> > 
> > On SMMUv3 the minimum alignment for base_ptr is 64 bytes, so a guest
> > under a vSMMU might pass a pointer that's not aligned on 4k.
> >   
> PASID table pointer for VT-d is 4K aligned. 
> > Maybe this information could be part of the data passed to userspace
> > about IOMMU table formats and features? They're not part of this
> > series, but I think we wanted to communicate IOMMU-specific features
> > via sysfs.
> >   
> Agreed, I believe Yi Liu is working on a sysfs interface such that QEMU
> can match IOMMU model and features.

Digging this up again since v5 still has this issue.  The IOMMU API is
a kernel internal abstraction of the IOMMU.  sysfs is a userspace
interface.  Are we suggesting that the /only/ way to make use of the
internal IOMMU API here is to have a user provided opaque pasid table
that we can't even do minimal compatibility sanity testing on and we
simply hope that hardware covers all the fault conditions without
taking the host down with it?  I guess we have to assume the latter
since the user has full control of the table, but I have a hard time
getting past lack of internal ability to use the interface and no
ability to provide even the slimmest sanity testing.  Thanks,

Alex
