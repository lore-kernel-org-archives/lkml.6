Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97285ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36388208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36388208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeGMHly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:41:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:63967 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeGMHly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:41:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 00:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="72411115"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2018 00:28:29 -0700
Date:   Fri, 13 Jul 2018 15:34:25 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     joeyli <jlee@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Gu, Kookoo" <kookoo.gu@intel.com>
Subject: Re: [PATCH 2/3][RFC] PM / Hibernate: Encrypt the snapshot pages
 before submitted to the block device
Message-ID: <20180713073425.GA29266@sandybridge-desktop>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <5a1cc6bff40ff9a3e023392c69b881e91b16837a.1529486870.git.yu.c.chen@intel.com>
 <20180628130641.GG3628@linux-l9pv.suse>
 <20180628135017.GA6561@sandybridge-desktop>
 <20180628142856.GH3628@linux-l9pv.suse>
 <20180628145207.GA10891@sandybridge-desktop>
 <20180629125943.GK3628@linux-l9pv.suse>
 <20180706152856.GB9631@sandybridge-desktop>
 <20180712101037.GI7985@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712101037.GI7985@linux-l9pv.suse>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Jul 12, 2018 at 06:10:37PM +0800, joeyli wrote:
> Hi Yu Chen, 
> 
> Sorry for my delay...
> 
> On Fri, Jul 06, 2018 at 11:28:56PM +0800, Yu Chen wrote:
> > Hi Joey Lee,
> > On Fri, Jun 29, 2018 at 08:59:43PM +0800, joeyli wrote:
> > > On Thu, Jun 28, 2018 at 10:52:07PM +0800, Yu Chen wrote:
> > > > Hi,
> > > > On Thu, Jun 28, 2018 at 10:28:56PM +0800, joeyli wrote:
> > > > > On Thu, Jun 28, 2018 at 09:50:17PM +0800, Yu Chen wrote:
> > > > > > Hi,
> > > > > > On Thu, Jun 28, 2018 at 09:07:20PM +0800, joeyli wrote:
> > > > > > > Hi Chen Yu,
> > > > > > > 
> > > > > > > On Wed, Jun 20, 2018 at 05:40:32PM +0800, Chen Yu wrote:
> > > > > > > > Use the helper functions introduced previously to encrypt
> > > > > > > > the page data before they are submitted to the block device.
> > > > > > > > Besides, for the case of hibernation compression, the data
> > > > > > > > are firstly compressed and then encrypted, and vice versa
> > > > > > > > for the resume process.
> > > > > > > >
> > > > > > > 
> > > > > > > I want to suggest my solution that it direct signs/encrypts the
> > > > > > > memory snapshot image. This solution is already shipped with
> > > > > > > SLE12 a couple of years:
> > > > > > > 
> > > > > > > https://github.com/joeyli/linux-s4sign/commits/s4sign-hmac-encrypted-key-v0.2-v4.17-rc3
> > > > > > > 
> > > > > > I did not see image page encryption in above link, if I understand
> > > > > 
> > > > > PM / hibernate: Generate and verify signature for snapshot image
> > > > > https://github.com/joeyli/linux-s4sign/commit/bae39460393ada4c0226dd07cd5e3afcef86b71f
> > > > >
> > > > > PM / hibernate: snapshot image encryption
> > > > > https://github.com/joeyli/linux-s4sign/commit/6a9a0113bb221c036ebd0f6321b7191283fe4929
> > > > >
> > > > > The above patches sign and encrypt the data pages in snapshot image.
> > > > > It puts the signature to header.
> > > > >
> > > > It looks like your signature code can be simplyly added on top of the
> > > > solution we proposed here, how about we collaborating on this task?
> > > 
> > > OK, I will base on your user key solution to respin my signature patches.
> > >  
> > > > just my 2 cents, 
> > > > 1. The cryption code should be indepent of the snapshot code, and
> > > >    this is why we implement it as a kernel module for that in PATCH[1/3].
> > > 
> > > Why the cryption code must be indepent of snapshot code?
> > >
> > Modules can be easier to be maintained and customized/improved in the future IMO..
> 
> hm... currently I didn't see apparent benefit on this...
> 
> About modularization, is it possible to separate the key handler code
> from crypto_hibernation.c? Otherwise the snapshot signature needs
> to depend on encrypt function.
> 
I understand.
It seems that we can reuse crypto_data() for the signature logic.
For example, add one parameter for crypto_data(..., crypto_mode)
the crypto_mode is a combination of ENCRYPT/DECRYPT/SIGNATURE_START/SIGNATURE_END,
and can be controled by sysfs. If SIGNATURE_START is enabled, the crypto_data()
invokes crypto_shash_update() to get "hmac(sha512)" hash, and if SIGNATURE_END
is enabled, crypto_shash_final() stores the final result in global buffer
struct hibernation_crypto.keys.digest[SNAPSHOT_DIGEST_SIZE] which can be
passed to the restore kernel, the same as the salt. Besides,
the swsusp_prepare_hash() in your code could be moved into
init_crypto_helper(), thus the signature key could also reuse
the same key passed from user space or via get_efi_secret_key().
In this way, the change in snapshot.c is minimal and the crypto
facilities could be maintained in one file.
> > > > 2. There's no need to traverse the snapshot image twice, if the
> > > >    image is large(there's requirement on servers now) we can
> > > >    simplyly do the encryption before the disk IO, and this is
> > > >    why PATCH[2/3] looks like this.
> > > 
> > > If the encryption solution is only for block device, then the uswsusp
> > > interface must be locked-down when kernel is in locked mode:
> > > 
> > > uswsusp: Disable when the kernel is locked down
> > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=lockdown-20180410&id=8732c1663d7c0305ae01ba5a1ee4d2299b7b4612
> > > 
> > > I still suggest to keep the solution to direct encript the snapshot
> > > image for uswsusp because the snapshot can be encrypted by kernel
> > > before user space get it.
> > > 
> > > I mean that if the uswsusp be used, then kernel direct encrypts the
> > > snapshot image, otherwise kernel encrypts pages before block io.
> > > 
> > I did not quite get the point, if the kernel has been locked down,
> > then the uswsusp is disabled, why the kernel encrypts the snapshot
> > for uswsusp?
> 
> There have some functions be locked-down because there have no
> appropriate mechanisms to check the integrity of writing data. If
> the snapshot image can be encrypted and authentication, then the
> uswsusp interface is avaiable for userspace. We do not need to lock
> it down.
Ok, I got your point. To be honest, I like your implementation to treat
the snapshot data seperately except that it might cause small overhead
when traversing large number of snapshot and make snapshot logic a little
coupling with crypto logic. Let me send our v2 using the crypto-before-blockio
for review and maybe change to your solution using the encapsulated APIs in
crypto_hibernate.c.
> 
> > > On the other hand, I have a question about asynchronous block io.
> > > Please see below...
> > > 
> > Okay.
> > > > > > > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > > > > > Cc: Len Brown <len.brown@intel.com>
> > > > > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > > > > Cc: "Lee, Chun-Yi" <jlee@suse.com>
> > > > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > > > > > ---
> > > > > > > >  kernel/power/power.h |   1 +
> > > > > > > >  kernel/power/swap.c  | 215 ++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > >  2 files changed, 205 insertions(+), 11 deletions(-)
> > > [...snip]
> > > > > > > >  /* kernel/power/hibernate.c */
> > > > > > > >  extern int swsusp_check(void);
> > > > > > > > diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> > > > > > > > index c2bcf97..2b6b3d0 100644
> > > > > > > > --- a/kernel/power/swap.c
> > > > > > > > +++ b/kernel/power/swap.c
> > > [...snip]
> > > > > > > > @@ -1069,18 +1171,42 @@ static int load_image(struct swap_map_handle *handle,
> > > > > > > >  	if (!m)
> > > > > > > >  		m = 1;
> > > > > > > >  	nr_pages = 0;
> > > > > > > > +	crypto_page_idx = 0;
> > > > > > > > +	if (handle->crypto) {
> > > > > > > > +		crypt_buf = (void *)get_zeroed_page(GFP_KERNEL);
> > > > > > > > +		if (!crypt_buf)
> > > > > > > > +			return -ENOMEM;
> > > > > > > > +	}
> > > > > > > >  	start = ktime_get();
> > > > > > > >  	for ( ; ; ) {
> > > > > > > >  		ret = snapshot_write_next(snapshot);
> > > > > > > >  		if (ret <= 0)
> > > > > > > >  			break;
> > > > > > > > -		ret = swap_read_page(handle, data_of(*snapshot), &hb);
> > > > > > > > +		if (handle->crypto)
> > > > > > > > +			ret = swap_read_page(handle, crypt_buf, &hb);
> > > > > > > > +		else
> > > > > > > > +			ret = swap_read_page(handle, data_of(*snapshot), &hb);
> > > > > > > >  		if (ret)
> > > > > > > >  			break;
> > > > > > > >  		if (snapshot->sync_read)
> > > > > > > >  			ret = hib_wait_io(&hb);
> > > 
> > > In snapshot_write_next(), the logic will clean the snapshot->sync_read
> > > when the buffer page doesn't equal to the original page. Which means
> > > that the page can be read by asynchronous block io. Otherwise, kernel
> > > calls hib_wait_io() to wait until the block io was done.
> > > 
> > Yes, you are right, I missed the asynchronous block io in non-compression
> > case.
> > > > > > > >  		if (ret)
> > > > > > > >  			break;
> > > > > > > > +		if (handle->crypto) {
> > > > > > > > +			/*
> > > > > > > > +			 * Need a decryption for the
> > > > > > > > +			 * data read from the block
> > > > > > > > +			 * device.
> > > > > > > > +			 */
> > > > > > > > +			ret = crypto_data(crypt_buf, PAGE_SIZE,
> > > > > > > > +					  data_of(*snapshot),
> > > > > > > > +					  PAGE_SIZE,
> > > > > > > > +					  false,
> > > > > > > > +					  crypto_page_idx);
> > > > > > > > +			if (ret)
> > > > > > > > +				break;
> > > > > > > > +			crypto_page_idx++;
> > > > > > > > +		}
> > > 
> > > The decryption is here in the for-loop. But maybe the page is still in
> > > the block io queue for waiting the batch read? The page content is not
> > > really read to memory when the crypto_data be run? 
> > > 
> > Yes, it is possible.
> > > > > > > >  		if (!(nr_pages % m))
> > > > > > > >  			pr_info("Image loading progress: %3d%%\n",
> > > > > > > >  				nr_pages / m * 10);
> > >                 nr_pages++;
> > >         }
> > >         err2 = hib_wait_io(&hb);
> > >         stop = ktime_get();
> > > 
> > > When the for-loop is break, the above hib_wait_io(&hb) guarantees that
> > > all asynchronous block io are done. Then all pages are read to memory.
> > > 
> > > I think that the decryption code must be moved after for-loop be break.
> > > Or there have any callback hook in the asynchronous block io that we
> > > can put the encryption code after the block io read the page.
> > > 
> > Yes, we can move the decryptino code here. Another thought came to my
> > mind, how about disabling the asynchronous block io in non-compression
> > case if encryption hibernation is enabled(because encryption hibernation
> > is not using the  asynchronous block io and it has to traverse each page
> > one by one, so asynchronous block io does not bring benefit to encryption
> > hibernation in non-compression case)? Or do I miss something?
> >
> 
> Disabling asynchronous block will cause IO performance drops. As I remeber
> that it's a lot of drops. You can try it. I am not sure how many people
> are still using non-compression mode.
Let me compare the speed of using non-compression mode.
> 
> I do not know too much on block layer API. Is it possible to encrypt each page
> before writing to device from kernel?
It might be hard due to the fact that the IO scheduler might combine different
IO request together and we could not figure out which IO request sections should
be encrypted.
> 
> Thanks
> Joey Lee
