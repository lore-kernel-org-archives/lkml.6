Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeDRIbs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:31:48 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:39373
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753178AbeDRIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:31:47 -0400
X-ASG-Debug-ID: 1524040303-093b7e10b3b9fa0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "ghook@amd.com" <ghook@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Topic: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
X-ASG-Orig-Subj: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Index: AQHT1tpRJAZW59A4ZEqPfHlYD/OogKQFmZcAgAAR5AA=
Date: Wed, 18 Apr 2018 08:31:36 +0000
Message-ID: <1524040290.4031.25.camel@hxt-semitech.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
         <1523664612.2747.13.camel@intel.com>
         <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
         <1524031122.4031.5.camel@hxt-semitech.com>
         <1524036520.2747.31.camel@intel.com>
In-Reply-To: <1524036520.2747.31.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.80]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <1C2E6DF8FCA0C8448B44B1E023EB6DEE@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1524040303
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5345 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.50013
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sohil

On Wed, 2018-04-18 at 07:27 +0000, Mehta, Sohil wrote:
> On Wed, 2018-04-18 at 05:58 +0000, Yang, Shunyong wrote:
> > 
> > Hi, Gary and Sohil,
> > 
> > On Tue, 2018-04-17 at 13:38 -0400, Hook, Gary wrote:
> > > 
> > > On 4/13/2018 8:08 PM, Mehta, Sohil wrote:
> > > > 
> > > >  
> > > > On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
> > > > > 
> > > > >  
> > > > >   
> > > > > +
> > > > > +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> > > > > +{
> > > > > + char name[MAX_NAME_LEN + 1];
> > > > > + struct dentry *d_top;
> > > > > +
> > > > > + if (!debugfs_initialized())
> > > > Probably not needed.
> > > Right.
> > When will this check is needed?
> > IMO, this function is to check debugfs ready status before we want
> > to
> > use debugfs. I just want to understand when we should use
> > debugfs_initialized();
> > 
> You are right debugfs_initialized() can be used to check if debugfs
> is
> ready. However in this case we can also rely on debugfs_create_dir()
> which is called in iommu_debufs_setup().
> 
> debugfs_create_dir() says:
> 
>  * If debugfs is not enabled in the kernel, the value -%ENODEV will
> be
>  * returned.

It seems "If debugfs is not enabled in the kernel"
means CONFIG_DEBUG_FS is not configured. Following is the code of no
such config.

  static inline struct dentry *debugfs_create_dir(const char *name,
						struct dentry *parent)
  {
	return ERR_PTR(-ENODEV);
  }

Looking into the code, debugfs_initialized() return the value of
debugfs_registered. debugfs_registered is set to true after
debugfs_init() has been called.
However, debugfs_create_dir() doesn't call debugfs_initialized() or
check debugfs_registered value.
So, there is tiny different of checking status by debugfs_create_dir()
and debugfs_initialized(). Although it can achieve functionality here.

Maybe the original design is to call debugfs_initialized() before
calling debugfs_create_xxx()?

Thanks.
Shunyong.

> 
> Sohil
> 
> > 
> > Thanks.
> > Shunyong.
> > 
> > > 
> > >  
> > > > 
> > > >  
> > > >  
> > > > > 
> > > > >  
> > > > > +         return;
> > > > > +
> > > > > + mutex_lock(&amd_iommu_debugfs_lock);
> > > > > + if (!amd_iommu_debugfs) {
> > > > > +         d_top = iommu_debugfs_setup();
> > > > > +         if (d_top)
> > > > > +                 amd_iommu_debugfs =
> > > > > debugfs_create_dir("amd", d_top);
> > > > > + }
> > > > > + mutex_unlock(&amd_iommu_debugfs_lock);
