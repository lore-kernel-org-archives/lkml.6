Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id A4tRDSzMHFszLgAAmS7hNA
	; Sun, 10 Jun 2018 06:58:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E8E860850; Sun, 10 Jun 2018 06:58:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7Qe6nUg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77AC7606DD;
	Sun, 10 Jun 2018 06:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77AC7606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeFJG6t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753731AbeFJG6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:58:48 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3551620858;
        Sun, 10 Jun 2018 06:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528613927;
        bh=WrPnDvs8pjOFoVF2Bv+nNIqexPOGhtS6+vkBj907B6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7Qe6nUgHFg00wyCSwU4lH1zss2aY1yUD8N4RkVeArQXBr2fCGgWp/TR2kdaGF1rM
         wmNUcj/5thUvCXiBZc0CBjzDvZEfjljjuyo91CuPp9ajE5SgxKrtcUBTbjELq4dP8Q
         Pb16PUykay5T3niCqWiMxmRTxvQGvW5oNPJr1I3A=
Date: Sun, 10 Jun 2018 08:58:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: regression: "95cde3c59966 debugfs: inode: debugfs_create_dir
 uses mode permission from parent" terminally annoys libvirt
Message-ID: <20180610065824.GA17740@kroah.com>
References: <1528442176.4678.10.camel@gmx.de>
 <cba2a66b-e8f7-6bf0-d4c1-8f2ba7d89822@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba2a66b-e8f7-6bf0-d4c1-8f2ba7d89822@linux.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:13:57PM +0200, Thomas-Mich Richter wrote:
> On 06/08/2018 09:16 AM, Mike Galbraith wrote:
> > Greetings,
> > 
> > $subject bisected and verified via revert.  Box is garden variety
> > i4790, distro is openSUSE Leap 15.0.
> > 
> > Error starting domain: internal error: process exited while connecting to monitor: ioctl(KVM_CREATE_VM) failed: 12 Cannot allocate memory
> > 2018-06-08T03:18:00.453006Z qemu-system-x86_64: failed to initialize KVM: Cannot allocate memory
> > 
> > Traceback (most recent call last):
> >   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 89, in cb_wrapper
> >     callback(asyncjob, *args, **kwargs)
> >   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 125, in tmpcb
> >     callback(*args, **kwargs)
> >   File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 82, in newfn
> >     ret = fn(self, *args, **kwargs)
> >   File "/usr/share/virt-manager/virtManager/domain.py", line 1508, in startup
> >     self._backend.create()
> >   File "/usr/lib64/python3.6/site-packages/libvirt.py", line 1069, in create
> >     if ret == -1: raise libvirtError ('virDomainCreate() failed', dom=self)
> > libvirt.libvirtError: internal error: process exited while connecting to monitor: ioctl(KVM_CREATE_VM) failed: 12 Cannot allocate memory
> > 2018-06-08T03:18:00.453006Z qemu-system-x86_64: failed to initialize KVM: Cannot allocate memory
> > 
> > 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775 is the first bad commit
> > commit 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775
> > Author: Thomas Richter <tmricht@linux.ibm.com>
> > Date:   Fri Apr 27 14:35:47 2018 +0200
> > 
> >     debugfs: inode: debugfs_create_dir uses mode permission from parent
> >     
> ...
> 
> Hi,
> 
> that patch does not allocate any memory, it just sets permission on newly
> created subdirectories in /sys/kernel/debug.
> I do not know what ioctl(KVM_CREATE_VM) does, but maybe requires permissions
> for group and others in that directory.
> 
> Best thing is to revert this patch.

Can you send me the revert so I can queue it up once 4.18-rc1 is out?

thanks,

greg k-h
