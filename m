Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A478C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D01620879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfAJRTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:19:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:8012 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbfAJRTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:19:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:19:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="115793775"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.152])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2019 09:19:24 -0800
Date:   Thu, 10 Jan 2019 19:19:23 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
Message-ID: <20190110171923.GC6589@linux.intel.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
 <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
 <1545519232.3940.115.camel@linux.ibm.com>
 <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
 <20190103132737.GD10491@linux.intel.com>
 <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
 <20190103150434.GC17015@linux.intel.com>
 <5aa2fc082b6b0657574918b025005ad569da6412.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aa2fc082b6b0657574918b025005ad569da6412.camel@mniewoehner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 04:47:31PM +0100, Michael Niewöhner wrote:
> On Thu, 2019-01-03 at 17:04 +0200, Jarkko Sakkinen wrote:
> > On Thu, Jan 03, 2019 at 02:38:11PM +0100, Michael Niewöhner wrote:
> > > On Thu, 2019-01-03 at 15:27 +0200, Jarkko Sakkinen wrote:
> > > > On Sun, Dec 23, 2018 at 12:55:12PM +0100, Michael Niewöhner wrote:
> > > > > There is another issue but I don't know if both are related. Maybe
> > > > > that's
> > > > > just a
> > > > > timing issue...
> > > > > 
> > > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1
> > > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > > 0+0 records in
> > > > > 0+0 records out
> > > > > 0 bytes copied, 0.755958 s, 0.0 kB/s
> > > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng
> > > > > bs=1
> > > > > count=1 | xxd
> > > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > > 0+0 records in
> > > > > 0+0 records out
> > > > > 0 bytes copied, 0.755697 s, 0.0 kB/s
> > > > > 1+0 records in
> > > > > 1+0 records out
> > > > > 00000000: 52                                       R
> > > > > 1 byte copied, 0.0106268 s, 0.1 kB/s
> > > > > 
> > > > > 
> > > > > Michael
> > > > 
> > > > What does /sys/devices/virtual/misc/hw_random/rng_current show?
> > > > 
> > > > Did run commands as a sanity check on my laptop and seem to work.
> > > > 
> > > > /Jarkko
> > > 
> > > rng_current says "tpm-rng-0", which should be correct
> > 
> > Is /dev/tpm0 accessible and usable?
> > 
> > /Jarkko
> 
> No, it does not seem to work:
> 
> root@debian:~# tpm_version                                     
> Tspi_Context_Connect failed: 0x00003011 - layer=tsp, code=0011 (17),
> Communication failure
> root@debian:~# tcsd -f
> TCSD TDDL ioctl: (25) Inappropriate ioctl for device
> TCSD TDDL Falling back to Read/Write device support.
> TCSD TDDL ERROR: write to device /dev/tpm0 failed: Operation not permitted
> TCSD TCS ERROR: TCS GetCapability failed with result = 0x1087
> root@debian:~# stat /dev/tpm0
>   File: /dev/tpm0
>   Size: 0         	Blocks: 0          IO Block: 4096   character special
> file
> Device: 6h/6d	Inode: 1114        Links: 1     Device type: a,e0
> Access: (0600/crw-------)  Uid: (  104/     tss)   Gid: (  112/     tss)
> Access: 2019-01-03 16:39:20.627635333 +0100
> Modify: 2019-01-03 16:39:20.627635333 +0100
> Change: 2019-01-03 16:39:20.627635333 +0100
>  Birth: -

But those tools should not work because TrouSerS is for TPM 1.2.

/Jarkko
