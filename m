Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78368C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3932402D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3932402D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753778AbeGEPWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:22:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:11858 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753259AbeGEPVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:21:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 08:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="54666794"
Received: from dmorlich-mobl.amr.corp.intel.com (HELO localhost) ([10.252.36.24])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2018 08:21:44 -0700
Date:   Thu, 5 Jul 2018 18:21:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "S, Shirish" <sshankar@amd.com>
Cc:     Shirish S <shirish.s@amd.com>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix NULL pointer dereference in tpm_transmit()
Message-ID: <20180705152143.GA10001@linux.intel.com>
References: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
 <20180704171357.GB6724@linux.intel.com>
 <edc9b7ba-9b76-7708-31c9-b02a703c848a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc9b7ba-9b76-7708-31c9-b02a703c848a@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:29:34AM +0530, S, Shirish wrote:
> 
> 
> On 7/4/2018 10:43 PM, Jarkko Sakkinen wrote:
> > On Wed, Jul 04, 2018 at 02:33:40PM +0530, Shirish S wrote:
> > > During system shutdown,
> > > tpm_class_shutdown() when called with TPM_CHIP_FLAG_TPM2
> > > flag set, makes chip->ops NULL.
> > > 
> > > However tpm_chip_unregister() called later in shutdown
> > > sequence tries to access chip->ops in tpm_try_transmit()
> > > leading the NULL pointer dereference.
> > > 
> > > This patch fixes this issue.
> > > Below is the trace for reference:
> > > 
> > > BUG: unable to handle kernel NULL pointer dereference at
> > > 0000000000000048
> > > IP: tpm_transmit+0x267/0x565
> > > PGD 0 P4D 0
> > > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > ...
> > > task: ffff937c847fe580 task.stack: ffffa79f80b04000
> > > RIP: 0010:tpm_transmit+0x267/0x565
> > > RSP: 0018:ffffa79f80b07c08 EFLAGS: 00010286
> > > RAX: 0000000000000000 RBX: ffff937ca9bc8000 RCX: ffff937c847fe580
> > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff98e3cd40
> > > RBP: ffffa79f80b07c88 R08: 000000000001fff4 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: ffffa79f80b07cd4
> > > R13: 000000000000008c R14: ffffffffffffffc3 R15: 0000000000000000
> > > FS:  00007ef31f747740(0000) GS:ffff937caed00000(0000)
> > > knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000000000048 CR3: 00000001243d2000 CR4: 00000000001406e0
> > > Call Trace:
> > > tpm_transmit_cmd+0x25/0x70
> > > tpm2_shutdown+0x69/0xa3
> > > ? __radix_tree_replace+0xd9/0x120
> > > ? idr_replace_ext+0x92/0xb6
> > > tpm_chip_unregister+0xaa/0xdb
> > > cr50_i2c_shutdown+0x1e/0x41
> > > device_shutdown+0x157/0x193
> > > kernel_power_off+0x35/0x6e
> > > SYSC_reboot+0x120/0x1a3
> > > ? do_writepages+0x36/0x6e
> > > ? do_writepages+0x36/0x6e
> > > ? sync_inodes_one_sb+0x17/0x17
> > > ? _raw_spin_unlock+0xe/0x20
> > > ? iput+0x87/0x1bd
> > > do_syscall_64+0x64/0x72
> > > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > 
> > > Signed-off-by: Shirish S <shirish.s@amd.com>
> > > ---
> > >   drivers/char/tpm/tpm-interface.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index e32f6e8..b14d196 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -411,6 +411,14 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> > >   	unsigned long stop;
> > >   	bool need_locality;
> > > +	/* chip->ops is made NULL in tpm_class_shutdown()
> > > +	 * This case is hit when tpm_chip_unregister() is called post
> > > +	 * tpm_class_shutdown(), hence exit early and return
> > > +	 * transmit operation not permitted
> > > +	 */
> > > +	if (!chip->ops)
> > > +		return -EPERM;
> > > +
> > >   	rc = tpm_validate_command(chip, space, buf, bufsiz);
> > >   	if (rc == -EINVAL)
> > >   		return rc;
> > > -- 
> > > 2.7.4
> > > 
> > What is cr50 anyway?
> Please ignore this patch, i realised the cr50 is not yet upstreamed.
> Hence the issue lies in in cr50 and not tpm driver.
> Thanks.
> Regards,
> Shirish S

tpm_chip_unregister() in supposed to be called only in removal/detach
sequence so the root cause for the NULL pointer deref is the driver, not
the existing TPM stack.

/Jarkko
