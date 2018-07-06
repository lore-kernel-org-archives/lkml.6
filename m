Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E990EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954B7219A6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954B7219A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGFPXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:23:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:16889 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeGFPXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:23:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 08:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,316,1526367600"; 
   d="scan'208";a="69207093"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2018 08:23:30 -0700
Date:   Fri, 6 Jul 2018 23:28:56 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     joeyli <jlee@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/3][RFC] PM / Hibernate: Encrypt the snapshot pages
 before submitted to the block device
Message-ID: <20180706152856.GB9631@sandybridge-desktop>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <5a1cc6bff40ff9a3e023392c69b881e91b16837a.1529486870.git.yu.c.chen@intel.com>
 <20180628130641.GG3628@linux-l9pv.suse>
 <20180628135017.GA6561@sandybridge-desktop>
 <20180628142856.GH3628@linux-l9pv.suse>
 <20180628145207.GA10891@sandybridge-desktop>
 <20180629125943.GK3628@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629125943.GK3628@linux-l9pv.suse>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey Lee,
On Fri, Jun 29, 2018 at 08:59:43PM +0800, joeyli wrote:
> On Thu, Jun 28, 2018 at 10:52:07PM +0800, Yu Chen wrote:
> > Hi,
> > On Thu, Jun 28, 2018 at 10:28:56PM +0800, joeyli wrote:
> > > On Thu, Jun 28, 2018 at 09:50:17PM +0800, Yu Chen wrote:
> > > > Hi,
> > > > On Thu, Jun 28, 2018 at 09:07:20PM +0800, joeyli wrote:
> > > > > Hi Chen Yu,
> > > > > 
> > > > > On Wed, Jun 20, 2018 at 05:40:32PM +0800, Chen Yu wrote:
> > > > > > Use the helper functions introduced previously to encrypt
> > > > > > the page data before they are submitted to the block device.
> > > > > > Besides, for the case of hibernation compression, the data
> > > > > > are firstly compressed and then encrypted, and vice versa
> > > > > > for the resume process.
> > > > > >
> > > > > 
> > > > > I want to suggest my solution that it direct signs/encrypts the
> > > > > memory snapshot image. This solution is already shipped with
> > > > > SLE12 a couple of years:
> > > > > 
> > > > > https://github.com/joeyli/linux-s4sign/commits/s4sign-hmac-encrypted-key-v0.2-v4.17-rc3
> > > > > 
> > > > I did not see image page encryption in above link, if I understand
> > > 
> > > PM / hibernate: Generate and verify signature for snapshot image
> > > https://github.com/joeyli/linux-s4sign/commit/bae39460393ada4c0226dd07cd5e3afcef86b71f
> > >
> > > PM / hibernate: snapshot image encryption
> > > https://github.com/joeyli/linux-s4sign/commit/6a9a0113bb221c036ebd0f6321b7191283fe4929
> > >
> > > The above patches sign and encrypt the data pages in snapshot image.
> > > It puts the signature to header.
> > >
> > It looks like your signature code can be simplyly added on top of the
> > solution we proposed here, how about we collaborating on this task?
> 
> OK, I will base on your user key solution to respin my signature patches.
>  
> > just my 2 cents, 
> > 1. The cryption code should be indepent of the snapshot code, and
> >    this is why we implement it as a kernel module for that in PATCH[1/3].
> 
> Why the cryption code must be indepent of snapshot code?
>
Modules can be easier to be maintained and customized/improved in the future IMO..
> > 2. There's no need to traverse the snapshot image twice, if the
> >    image is large(there's requirement on servers now) we can
> >    simplyly do the encryption before the disk IO, and this is
> >    why PATCH[2/3] looks like this.
> 
> If the encryption solution is only for block device, then the uswsusp
> interface must be locked-down when kernel is in locked mode:
> 
> uswsusp: Disable when the kernel is locked down
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=lockdown-20180410&id=8732c1663d7c0305ae01ba5a1ee4d2299b7b4612
> 
> I still suggest to keep the solution to direct encript the snapshot
> image for uswsusp because the snapshot can be encrypted by kernel
> before user space get it.
> 
> I mean that if the uswsusp be used, then kernel direct encrypts the
> snapshot image, otherwise kernel encrypts pages before block io.
> 
I did not quite get the point, if the kernel has been locked down,
then the uswsusp is disabled, why the kernel encrypts the snapshot
for uswsusp?
> On the other hand, I have a question about asynchronous block io.
> Please see below...
> 
Okay.
> > > > > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > > > Cc: Len Brown <len.brown@intel.com>
> > > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > > Cc: "Lee, Chun-Yi" <jlee@suse.com>
> > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > > > ---
> > > > > >  kernel/power/power.h |   1 +
> > > > > >  kernel/power/swap.c  | 215 ++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > >  2 files changed, 205 insertions(+), 11 deletions(-)
> [...snip]
> > > > > >  /* kernel/power/hibernate.c */
> > > > > >  extern int swsusp_check(void);
> > > > > > diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> > > > > > index c2bcf97..2b6b3d0 100644
> > > > > > --- a/kernel/power/swap.c
> > > > > > +++ b/kernel/power/swap.c
> [...snip]
> > > > > > @@ -1069,18 +1171,42 @@ static int load_image(struct swap_map_handle *handle,
> > > > > >  	if (!m)
> > > > > >  		m = 1;
> > > > > >  	nr_pages = 0;
> > > > > > +	crypto_page_idx = 0;
> > > > > > +	if (handle->crypto) {
> > > > > > +		crypt_buf = (void *)get_zeroed_page(GFP_KERNEL);
> > > > > > +		if (!crypt_buf)
> > > > > > +			return -ENOMEM;
> > > > > > +	}
> > > > > >  	start = ktime_get();
> > > > > >  	for ( ; ; ) {
> > > > > >  		ret = snapshot_write_next(snapshot);
> > > > > >  		if (ret <= 0)
> > > > > >  			break;
> > > > > > -		ret = swap_read_page(handle, data_of(*snapshot), &hb);
> > > > > > +		if (handle->crypto)
> > > > > > +			ret = swap_read_page(handle, crypt_buf, &hb);
> > > > > > +		else
> > > > > > +			ret = swap_read_page(handle, data_of(*snapshot), &hb);
> > > > > >  		if (ret)
> > > > > >  			break;
> > > > > >  		if (snapshot->sync_read)
> > > > > >  			ret = hib_wait_io(&hb);
> 
> In snapshot_write_next(), the logic will clean the snapshot->sync_read
> when the buffer page doesn't equal to the original page. Which means
> that the page can be read by asynchronous block io. Otherwise, kernel
> calls hib_wait_io() to wait until the block io was done.
> 
Yes, you are right, I missed the asynchronous block io in non-compression
case.
> > > > > >  		if (ret)
> > > > > >  			break;
> > > > > > +		if (handle->crypto) {
> > > > > > +			/*
> > > > > > +			 * Need a decryption for the
> > > > > > +			 * data read from the block
> > > > > > +			 * device.
> > > > > > +			 */
> > > > > > +			ret = crypto_data(crypt_buf, PAGE_SIZE,
> > > > > > +					  data_of(*snapshot),
> > > > > > +					  PAGE_SIZE,
> > > > > > +					  false,
> > > > > > +					  crypto_page_idx);
> > > > > > +			if (ret)
> > > > > > +				break;
> > > > > > +			crypto_page_idx++;
> > > > > > +		}
> 
> The decryption is here in the for-loop. But maybe the page is still in
> the block io queue for waiting the batch read? The page content is not
> really read to memory when the crypto_data be run? 
> 
Yes, it is possible.
> > > > > >  		if (!(nr_pages % m))
> > > > > >  			pr_info("Image loading progress: %3d%%\n",
> > > > > >  				nr_pages / m * 10);
>                 nr_pages++;
>         }
>         err2 = hib_wait_io(&hb);
>         stop = ktime_get();
> 
> When the for-loop is break, the above hib_wait_io(&hb) guarantees that
> all asynchronous block io are done. Then all pages are read to memory.
> 
> I think that the decryption code must be moved after for-loop be break.
> Or there have any callback hook in the asynchronous block io that we
> can put the encryption code after the block io read the page.
> 
Yes, we can move the decryptino code here. Another thought came to my
mind, how about disabling the asynchronous block io in non-compression
case if encryption hibernation is enabled(because encryption hibernation
is not using the  asynchronous block io and it has to traverse each page
one by one, so asynchronous block io does not bring benefit to encryption
hibernation in non-compression case)? Or do I miss something?

Best,
Yu
> Thanks a lot!
> Joey Lee 
