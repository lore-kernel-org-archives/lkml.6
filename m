Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeFER34 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:29:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:16179 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbeFER3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:29:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="64534862"
Date: Tue, 5 Jun 2018 10:32:53 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Message-ID: <20180605103253.634ef8fd@jacob-builder>
In-Reply-To: <1c1094e8-ecbb-7731-910c-59e4de1e5c70@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <20180417131047.0a9c310f@w520.home>
        <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
        <20180420164251.5245f822@jacob-builder>
        <20180529140915.1f174689@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D1911E59C4@SHSMSX101.ccr.corp.intel.com>
        <20180529211746.74f1dd23@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D1911E5F06@SHSMSX101.ccr.corp.intel.com>
        <a07a0a0a-ebdd-c81a-7ed6-cff19e6078d7@arm.com>
        <20180530125240.34e0e80c@jacob-builder>
        <1c1094e8-ecbb-7731-910c-59e4de1e5c70@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 10:09:46 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 30/05/18 20:52, Jacob Pan wrote:
> >> However I think the model number should be added to
> >> pasid_table_config. For one thing it gives us a simple
> >> sanity-check, but it also tells which other fields are valid in
> >> pasid_table_config. Arm-smmu-v3 needs at least two additional
> >> 8-bit fields describing the PASID table format (number of levels
> >> and PASID0 behaviour), which are written to device context tables
> >> when installing the PASID table pointer.
> >>  
> > We had model number field in v2 of this patchset. My thought was
> > that since the config info is meant to be generic, we shouldn't
> > include model info. But I also think a simple sanity check can be
> > useful, would that be sufficient to address Alex's concern? Of
> > course we still need sysfs for more specific IOMMU features.
> > 
> > Would this work?
> > enum pasid_table_model {
> > 	PASID_TABLE_FORMAT_HOST,
> > 	PASID_TABLE_FORMAT_ARM_1LVL,
> > 	PASID_TABLE_FORMAT_ARM_2LVL,  
> 
> I'd rather use a single PASID_TABLE_FORMAT_ARM, because "2LVL" may be
> further split into 2LVL_4k or 2LVL_64k leaf tables... I think it's
> best if I add an arch-specific field in pasid_table_config for that,
> and for the PASID0 configuration, when adding FORMAT_ARM in a future
> patch
> 
sounds good. will only use PASID_TABLE_FORMAT_ARM.
> > 	PASID_TABLE_FORMAT_AMD,
> > 	PASID_TABLE_FORMAT_INTEL,
> > };
> > 
> > /**
> >  * PASID table data used to bind guest PASID table to the host
> > IOMMU. This will
> >  * enable guest managed first level page tables.
> >  * @version: for future extensions and identification of the data
> > format
> >  * @bytes: size of this structure
> >  * @model: PASID table format for different IOMMU models
> >  * @base_ptr:	PASID table pointer
> >  * @pasid_bits:	number of bits supported in the guest PASID
> > table, must be less
> >  *		or equal than the host supported PASID size.
> >  */
> > struct pasid_table_config {
> > 	__u32 version;
> > #define PASID_TABLE_CFG_VERSION_1 1
> > 	__u32 bytes;  
> 
> "bytes" could be passed by VFIO as argument to bind_pasid_table, since
> it can deduce it from argsz
> 
Are you suggesting we wrap this struct in a vfio struct with argsz? or
we directly use this struct?

I need to clarify how vfio will use this.
- User program:
struct pasid_table_config ptc = { .bytes = sizeof(ptc) };
ptc.version = 1;
ioctl(device, VFIO_DEVICE_BIND_PASID_TABLE, &ptc);

- Kernel:
minsz = offsetofend(struct pasid_table_config, pasid_bits);
if (ptc.bytes < minsz)
	return -EINVAL;
