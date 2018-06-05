Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeFERJp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:09:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34919 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752039AbeFERJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:09:42 -0400
X-ME-Proxy: <xmx:1sMWW9tNxHAPZVasUMK8m_9PUjFoCa7LBg8V4OMdVZB1q2E1SknQgA>
X-ME-Proxy: <xmx:1sMWWwQw14RD_2k7pcQTJCTShOTX7Zq8j4nLOVU59cPfEp9vGBkVyA>
X-ME-Proxy: <xmx:1sMWW_n0G6Y2Bn1Ly3M34doprm95coMe78y15BoS7GPtI14b7lJezA>
X-ME-Proxy: <xmx:1sMWW_kt8DmMGgT9C6mafTol0cibDsMjIWtCGcaApSZBm5B8DZBFGg>
X-ME-Proxy: <xmx:1sMWW1MTP4wAcUhmho79wuqP9gJm8x3SqZuQJkv6j6XCBrr-0n54NQ>
X-ME-Proxy: <xmx:1sMWWyGx6wi8XJfq7-rtughDPfF5zQmCx57NV9F50tr6GZe7LGSnVw>
X-ME-Sender: <xms:1sMWW2SBbF_iSGoczDB8ckr4zdcxPcvM5tcxZheFmzeKUrCXCSNkww>
Date: Tue, 5 Jun 2018 19:06:24 +0200
From: Greg KH <greg@kroah.com>
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Message-ID: <20180605170624.GB10834@kroah.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
 <20180529183917.GA10618@kroah.com>
 <f0780139-5322-a028-0091-3255e0596eff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0780139-5322-a028-0091-3255e0596eff@amd.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:58:13AM -0500, Gary R Hook wrote:
> On 05/29/2018 01:39 PM, Greg KH wrote:
> > On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
> > > Implement a skeleton framework for debugfs support in the
> > > AMD IOMMU. Add a hidden boolean to Kconfig that is defined
> > > for the AMD IOMMU when general IOMMY DebugFS support is
> > > enabled.
> > > 
> > > Signed-off-by: Gary R Hook <gary.hook@amd.com>
> > > ---
> > >   drivers/iommu/Kconfig             |    4 ++++
> > >   drivers/iommu/Makefile            |    1 +
> > >   drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
> > >   drivers/iommu/amd_iommu_init.c    |    6 ++++--
> > >   drivers/iommu/amd_iommu_proto.h   |    6 ++++++
> > >   drivers/iommu/amd_iommu_types.h   |    5 +++++
> > >   6 files changed, 59 insertions(+), 2 deletions(-)
> > >   create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> > > 
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index f9af25ac409f..ec223f6f4ad4 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -137,6 +137,10 @@ config AMD_IOMMU
> > >   	  your BIOS for an option to enable it or if you have an IVRS ACPI
> > >   	  table.
> > > +config AMD_IOMMU_DEBUGFS
> > > +	def_bool y
> > 
> > Why default y?  Can you not boot a box without this?  If not, it should
> > not be Y.
> 
> Again, apologies for not seeing this sooner.
> 
> Yes, the system can boot without this. The idea of a hidden option was
> surfaced by Robin, and after my first approach was shot down, I tried this.
> 
> Logic: If the over-arching IOMMU debugfs option is enabled, then
> AMD_IOMMU_DEBUGFS gets defined, and AMD IOMMU code gets included.
> 
> This issue was discussed a few weeks ago. No single approach appears to
> satisfy everyone. I like this because it depends upon one switch: Do you
> want DebugFS support enabled in the IOMMU driver, period? Vendor-specific
> code can then choose to implement support or not, and a builder doesn't have
> to worry about enabling/disabling multiple Kconfig options.
> 
> At least, that was my line of reasoning.
> 
> I'm not married to any approach, and I don't find clever use of Kconfig
> options too terribly challenging. And I'm not defending, I'm just
> explaining.

The issue is, no one sets Kconfig options except a very tiny subset of
kernel developers.  Distros allways enable everything, as they have to
do that.

If you are creating something here that is so dangerous that you spam
the kernel log with big warning messages, you should not be making it
easy to enable, let alone be enabled by default :)

Just make it an option, have it rely on the kernel debugging option, and
say "DO NOT ENABLE THIS UNLESS YOU REALLY REALLY REALLY KNOW WHAT YOU
ARE DOING!"

thanks,

greg k-h
