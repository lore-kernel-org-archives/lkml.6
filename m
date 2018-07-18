Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EAFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E020673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3E020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGRRKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:10:36 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:45778 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727535AbeGRRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:10:36 -0400
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1ffpMo-0005cG-Mv; Wed, 18 Jul 2018 12:31:54 -0400
Date:   Wed, 18 Jul 2018 12:31:53 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH] [RESEND] coda: stop using 'struct timespec' in user API
Message-ID: <20180718163153.ogfriudjw7ztwpag@cs.cmu.edu>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>
References: <20180718114645.591551-1-arnd@arndb.de>
 <20180718155006.lkoktldllafrfqbf@cs.cmu.edu>
 <CAK8P3a3HYBar1yVCEjxR2VNpPOOx23qM5fCyO-TMmeF780rBiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3HYBar1yVCEjxR2VNpPOOx23qM5fCyO-TMmeF780rBiQ@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:10:29PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 18, 2018 at 5:50 PM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> > On Wed, Jul 18, 2018 at 01:46:25PM +0200, Arnd Bergmann wrote:
> >> Unfortunately, this breaks the layout of the coda_vattr structure, so
> >> we need to redefine that in terms of something that does not change.
> >> I'm introducing a new 'struct vtimespec' structure here that keeps
> >> the existing layout, and the same change has to be done in the coda
> >> user space copy of linux/coda.h before anyone can use that on a 32-bit
> >> architecture with 64-bit time_t.
> >
> > I think the userbase is small enough that we can handle a much simpler
> > transition to 64-bit timespecs everywhere. In that case the
> > CODA_KERNEL_VERSION should be updated, which is currently defined in
> > include/uapi/linux/coda.h as 3. As moving to 64-bit timespecs only
> > breaks 32-bit systems this allows userspace to catch that case and
> > refuse to run userspace with a mismatched layout (or handle
> > translation).
> 
> Ok, so to make sure I get this right, you say we can do an
> incompatible ABI change for coda without causing any problems
> for existing users?
> 
> That would definitely be the easiest approach here. I guess
> we also just have to be incompatible for 32-bit user space,
> since it would make 32-bit users have the same ABI as 64-bit
> ones, right?
> 
> I'll have another look at the ABI side then, to see how it can
> be transitioned.

Correct, the first thing a client does after opening the /dev/cfs0
device is to send a CIOC_KERNEL_VERSION ioctl. In response the Coda
kernel module returns the current value of CODA_KERNEL_VERSION.

Right now anything but 3 will make the client complain about version
mismatch and refuse to start. It is trivial to allow existing 64-bit
clients to accept both 3 and 4 as valid, and when 32-bit userspace is
updated to also use 64-bit timespec it can be changed to accept only 4.

> >> > If we only have one code base, it should be fairly straightforward to
> >> > make it deal with 'unsigned' timestamps consistently, which would
> >> > let the code work fine until 2106 rather than wrapping around from
> >> > 2038 to 1902.
> >
> > At some point there was a webdav filesystem that used the Coda kernel
> > apis, but I think they may have moved to FUSE since then so I would not
> > be surprised if there is only a single code base at this point.
> 
> Ok, I found davfs2 at http://dav.sourceforge.net/index.shtml
> 
> Ah, so the coda kernel implementation is similar to both fuse and 9pfs
> in that it can connect to arbitrary user space implementations, but with
> no known users other than your coda user space and some versions of
> davfs2?

Correct and since the FUSE api is easier to work with it has seen more
users. AFAIK, the work on davfs2 was started before FUSE existed.

Jan
