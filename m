Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933915AbeEILaY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:30:24 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:48886 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755965AbeEILaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:30:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,381,1520899200";
   d="scan'208";a="72823579"
Date: Wed, 9 May 2018 12:30:16 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 1/3] xen/pvh: enable and set default MTRR
 type
Message-ID: <20180509113016.tavac64ba5fu3tob@MacBook-Pro-de-Roger.local>
References: <20180509102129.14832-1-roger.pau@citrix.com>
 <20180509102129.14832-2-roger.pau@citrix.com>
 <fbe18be3-0e2e-723f-a625-015c6aad89a3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbe18be3-0e2e-723f-a625-015c6aad89a3@citrix.com>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:56:40AM +0100, Andrew Cooper wrote:
> On 09/05/18 11:21, Roger Pau Monne wrote:
> > On PVH MTRR is not initialized by the firmware (because there's no
> > firmware), so the kernel is started with MTRR disabled which means all
> > memory accesses are UC.
> >
> > So far there have been no issues (ie: slowdowns) caused by this
> > because PVH only supported DomU mode without passed-through devices,
> > so Xen was using WB as the default memory type instead of UC.
> >
> > Fix this by enabling MTRR and setting the default type to WB. Linux
> > will use PAT to set the actual memory cache attributes.
> >
> > Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> I'd argue that this is a bug in PVH starting state.

Do you mean that MTRR should be setup before starting the guest?

> Do you know what mechanism is used to bodge things to WB in the first
> place?

If you mean when passthorugh is not used (ie: no IOMMU), then it's at
epte_get_entry_emt, grep for need_iommu(d) (line ~801).

> I'm not sure that setting the default MTRR type is going to be a
> clever idea in hindsight when we come to doing PCI Passthrough support.

Setting the default type to WB is also set by hvmloader, it's just
that hvmloader also sets some of the fixed and variable ranges to UC
in order to cover the iomem areas.

The expectations when doing pci-passthrough is that the guest will
always use paging and PAT in order to set the appropriate cache
attributes, or else the guest itself will have to program the UC MTRR
ranges, I admit that's not very nice however.

What about enabling the default MTRR type and setting it to WB in the
toolstack for PVH? IMO doing it Xen itself would be wrong.

Thanks, Roger.
