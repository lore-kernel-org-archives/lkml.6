Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeCGA6o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 19:58:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:53680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932888AbeCGA6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 19:58:43 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,433,1515484800";
   d="scan'208";a="23093504"
Date: Tue, 6 Mar 2018 17:58:42 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: remove redundant __func__ in dev_dbg
Message-ID: <20180307005842.GA30822@linux.intel.com>
References: <152029856149.39547.12704338925946035297.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180306035434.GC15227@linux.intel.com>
 <CAPcyv4g1Mc5yF1somk94Ogthvc7GVwLSAG_J=K_DCWWXGcL_zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g1Mc5yF1somk94Ogthvc7GVwLSAG_J=K_DCWWXGcL_zw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 08:59:11AM -0800, Dan Williams wrote:
> On Mon, Mar 5, 2018 at 7:54 PM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > On Mon, Mar 05, 2018 at 05:09:21PM -0800, Dan Williams wrote:
> >> Dynamic debug can be instructed to add the function name to the debug
> >> output using the +f switch, so there is no need for the libnvdimm
> >> modules to do it again. If a user decides to add the +f switch for
> >> libnvdimm's dynamic debug this results in double prints of the function
> >> name.
> >>
> >> Reported-by: Johannes Thumshirn <jthumshirn@suse.de>
> >> Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> ---
> >>  drivers/nvdimm/badrange.c       |    3 +-
> >>  drivers/nvdimm/btt_devs.c       |   21 ++++++++--------
> >>  drivers/nvdimm/bus.c            |   13 +++++-----
> >>  drivers/nvdimm/claim.c          |    2 +-
> >>  drivers/nvdimm/core.c           |    4 ++-
> >>  drivers/nvdimm/dax_devs.c       |    5 ++--
> >>  drivers/nvdimm/dimm_devs.c      |    7 ++---
> >>  drivers/nvdimm/label.c          |   51 ++++++++++++++++++---------------------
> >>  drivers/nvdimm/namespace_devs.c |   38 ++++++++++++-----------------
> >>  drivers/nvdimm/pfn_devs.c       |   25 +++++++++----------
> >>  drivers/nvdimm/pmem.c           |    2 +-
> >>  11 files changed, 77 insertions(+), 94 deletions(-)
> >>
> >> diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
> >> index e068d72b4357..df17f1cd696d 100644
> >> --- a/drivers/nvdimm/badrange.c
> >> +++ b/drivers/nvdimm/badrange.c
> >> @@ -176,8 +176,7 @@ static void set_badblock(struct badblocks *bb, sector_t s, int num)
> >>                       (u64) s * 512, (u64) num * 512);
> >>       /* this isn't an error as the hardware will still throw an exception */
> >>       if (badblocks_set(bb, s, num, 1))
> >> -             dev_info_once(bb->dev, "%s: failed for sector %llx\n",
> >> -                             __func__, (u64) s);
> >> +             dev_info_once(bb->dev, "failed for sector %llx\n", (u64) s);
> >
> > I don't think you should remove this one.  dev_info_once() is just a printk(),
> > and doesn't inherit the +f flag from the dynamic debugging code. The __func__
> > here does add value.
> >
> > The rest of these look correct, though I think you missed one in each of
> > nvdimm_map_release()
> 
> This one is now fixed.
> 
> > and validate_dimm().  (I made these changes as well, but
> > you sent out your patch first. :)
> 
> The validate_dimm() one is printing the callee function one level up
> in the call chain, so it's fine as is.

Sounds good.  you can add:

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
