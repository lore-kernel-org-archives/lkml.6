Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeDRH1c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:27:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:24374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbeDRH1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:27:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="47859825"
From: "Mehta, Sohil" <sohil.mehta@intel.com>
To: "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "ghook@amd.com" <ghook@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Topic: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Index: AQHT04THDyVaDNNW7k6hYyQjJLsxvaQFs/wAgADO9QCAABkcAA==
Date: Wed, 18 Apr 2018 07:27:28 +0000
Message-ID: <1524036520.2747.31.camel@intel.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
         <1523664612.2747.13.camel@intel.com>
         <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
         <1524031122.4031.5.camel@hxt-semitech.com>
In-Reply-To: <1524031122.4031.5.camel@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D07B9325DA45C4BAB58AB717D0D9AC3@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3I7Rljc010564

On Wed, 2018-04-18 at 05:58 +0000, Yang, Shunyong wrote:
> Hi, Gary and Sohil,
> 
> On Tue, 2018-04-17 at 13:38 -0400, Hook, Gary wrote:
> > On 4/13/2018 8:08 PM, Mehta, Sohil wrote:
> > > 
> > > On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
> > > > 
> > > >   
> > > > +
> > > > +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> > > > +{
> > > > + char name[MAX_NAME_LEN + 1];
> > > > + struct dentry *d_top;
> > > > +
> > > > + if (!debugfs_initialized())
> > > Probably not needed.
> > Right.
> 
> When will this check is needed?
> IMO, this function is to check debugfs ready status before we want to
> use debugfs. I just want to understand when we should use
> debugfs_initialized();
> 

You are right debugfs_initialized() can be used to check if debugfs is
ready. However in this case we can also rely on debugfs_create_dir()
which is called in iommu_debufs_setup().

debugfs_create_dir() says:

 * If debugfs is not enabled in the kernel, the value -%ENODEV will be
 * returned.

Sohil

> Thanks.
> Shunyong.
> 
> > 
> > > 
> > > 
> > > > 
> > > > +         return;
> > > > +
> > > > + mutex_lock(&amd_iommu_debugfs_lock);
> > > > + if (!amd_iommu_debugfs) {
> > > > +         d_top = iommu_debugfs_setup();
> > > > +         if (d_top)
> > > > +                 amd_iommu_debugfs =
> > > > debugfs_create_dir("amd", d_top);
> > > > + }
> > > > + mutex_unlock(&amd_iommu_debugfs_lock);
