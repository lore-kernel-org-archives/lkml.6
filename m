Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87E2760290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeFFPbC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:31:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:57542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbeFFPbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:31:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="57048367"
Date: Wed, 6 Jun 2018 09:30:59 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2 3/3] libnvdimm: don't flush power-fail protected CPU
 caches
Message-ID: <20180606153059.GA30568@linux.intel.com>
References: <20180605235802.14531-1-ross.zwisler@linux.intel.com>
 <20180605235802.14531-3-ross.zwisler@linux.intel.com>
 <CAPcyv4gs-EMxQhX6dNYnygav1RfaLOuuA0XwYVHv-eSirjw6jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gs-EMxQhX6dNYnygav1RfaLOuuA0XwYVHv-eSirjw6jA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 07:00:14PM -0700, Dan Williams wrote:
> On Tue, Jun 5, 2018 at 4:58 PM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > This commit:
> >
> > 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
> >
> > intended to make sure that deep flush was always available even on
> > platforms which support a power-fail protected CPU cache.  An unintended
> > side effect of this change was that we also lost the ability to skip
> > flushing CPU caches on those power-fail protected CPU cache.
> >
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
> > ---
> >  drivers/dax/super.c   | 14 +++++++++++++-
> >  drivers/nvdimm/pmem.c |  2 ++
> >  include/linux/dax.h   |  4 ++++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index c2c46f96b18c..80253c531a9b 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -152,6 +152,8 @@ enum dax_device_flags {
> >         DAXDEV_ALIVE,
> >         /* gate whether dax_flush() calls the low level flush routine */
> >         DAXDEV_WRITE_CACHE,
> > +       /* only flush the CPU caches if they are not power fail protected */
> > +       DAXDEV_FLUSH_ON_SYNC,
> 
> I'm not grokking why we need DAXDEV_FLUSH_ON_SYNC. The power fail
> protected status of the cache only determines the default for
> DAXDEV_WRITE_CACHE.

Ah, yea, that's much cleaner.  I'll send out a v3.
