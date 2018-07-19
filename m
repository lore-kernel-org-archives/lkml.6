Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A282206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A282206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeGSJwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:52:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:39317 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeGSJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:52:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 02:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="68297484"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2018 02:10:08 -0700
Date:   Thu, 19 Jul 2018 17:16:01 +0800
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
Message-ID: <20180719091601.GA28314@sandybridge-desktop>
References: <5a1cc6bff40ff9a3e023392c69b881e91b16837a.1529486870.git.yu.c.chen@intel.com>
 <20180628130641.GG3628@linux-l9pv.suse>
 <20180628135017.GA6561@sandybridge-desktop>
 <20180628142856.GH3628@linux-l9pv.suse>
 <20180628145207.GA10891@sandybridge-desktop>
 <20180629125943.GK3628@linux-l9pv.suse>
 <20180706152856.GB9631@sandybridge-desktop>
 <20180712101037.GI7985@linux-l9pv.suse>
 <20180713073425.GA29266@sandybridge-desktop>
 <20180718154819.GH18419@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718154819.GH18419@linux-l9pv.suse>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:48:19PM +0800, joeyli wrote:
> On Fri, Jul 13, 2018 at 03:34:25PM +0800, Yu Chen wrote:
> > Hi,
> > On Thu, Jul 12, 2018 at 06:10:37PM +0800, joeyli wrote:
> > > Hi Yu Chen, 
> > > 
> > > Sorry for my delay...
> > > 
> > > On Fri, Jul 06, 2018 at 11:28:56PM +0800, Yu Chen wrote:
> [...snip]
> > > > > Why the cryption code must be indepent of snapshot code?
> > > > >
> > > > Modules can be easier to be maintained and customized/improved in the future IMO..
> > > 
> > > hm... currently I didn't see apparent benefit on this...
> > > 
> > > About modularization, is it possible to separate the key handler code
> > > from crypto_hibernation.c? Otherwise the snapshot signature needs
> > > to depend on encrypt function.
> > > 
> > I understand.
> > It seems that we can reuse crypto_data() for the signature logic.
> > For example, add one parameter for crypto_data(..., crypto_mode)
> > the crypto_mode is a combination of ENCRYPT/DECRYPT/SIGNATURE_START/SIGNATURE_END,
> > and can be controled by sysfs. If SIGNATURE_START is enabled, the crypto_data()
> > invokes crypto_shash_update() to get "hmac(sha512)" hash, and if SIGNATURE_END
> > is enabled, crypto_shash_final() stores the final result in global buffer
> 
> I agree that the swsusp_prepare and hmac-hash codes can be extract to
> crypto_hibernation.  
> 
> > struct hibernation_crypto.keys.digest[SNAPSHOT_DIGEST_SIZE] which can be
> > passed to the restore kernel, the same as the salt. Besides,
> 
> The salt is stored in the swsusp_header and put in swap. What I want
> is that the signature of snapshot should be keep in the snapshot header
> as my original design in patch. The benefit is that the snapshot with
> signature can be stored to any place but not just swap. The user space
> can take snapshot image with signature to anywhere.
>
Okay, got it.
> > the swsusp_prepare_hash() in your code could be moved into
> > init_crypto_helper(), thus the signature key could also reuse
> > the same key passed from user space or via get_efi_secret_key().
> > In this way, the change in snapshot.c is minimal and the crypto
> > facilities could be maintained in one file.
> 
> I agree. But as I mentioned in that mail, the key handler codes
> in hibernation_crypto() should be extract to another C file to avoid
> the logic is mixed with the crypto code. The benefit is that we can
> add more key sources like encrypted key or EFI key in the future. 
> 
Ok, will extract the key handler code from this file.
> > > > > > 2. There's no need to traverse the snapshot image twice, if the
> > > > > >    image is large(there's requirement on servers now) we can
> > > > > >    simplyly do the encryption before the disk IO, and this is
> > > > > >    why PATCH[2/3] looks like this.
> > > > > 
> > > > > If the encryption solution is only for block device, then the uswsusp
> > > > > interface must be locked-down when kernel is in locked mode:
> > > > > 
> > > > > uswsusp: Disable when the kernel is locked down
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=lockdown-20180410&id=8732c1663d7c0305ae01ba5a1ee4d2299b7b4612
> > > > > 
> > > > > I still suggest to keep the solution to direct encript the snapshot
> > > > > image for uswsusp because the snapshot can be encrypted by kernel
> > > > > before user space get it.
> > > > > 
> > > > > I mean that if the uswsusp be used, then kernel direct encrypts the
> > > > > snapshot image, otherwise kernel encrypts pages before block io.
> > > > > 
> > > > I did not quite get the point, if the kernel has been locked down,
> > > > then the uswsusp is disabled, why the kernel encrypts the snapshot
> > > > for uswsusp?
> > > 
> > > There have some functions be locked-down because there have no
> > > appropriate mechanisms to check the integrity of writing data. If
> > > the snapshot image can be encrypted and authentication, then the
> > > uswsusp interface is avaiable for userspace. We do not need to lock
> > > it down.
> > Ok, I got your point. To be honest, I like your implementation to treat
> > the snapshot data seperately except that it might cause small overhead
> > when traversing large number of snapshot and make snapshot logic a little
> > coupling with crypto logic. Let me send our v2 using the crypto-before-blockio
> > for review and maybe change to your solution using the encapsulated APIs in
> > crypto_hibernate.c.
> 
> Because sometimes I stick on other topics...
> 
> If you are urgent for pushing your encryption solution. Please do not
> consider too much on signature check. Just complete your patches and push
> to kernel mainline. I will follow your result to respin my signature work.
> 
Thanks, I've just sent out another version before I noticed your
comment yesterday, let me address your concern in v3,
but please feel free to comment on v2.
Thanks,
Yu

> Thanks
> Joey Lee 
