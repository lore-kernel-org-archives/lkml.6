Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDDOCR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:02:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDOCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:02:16 -0400
Date: Wed, 4 Apr 2018 16:02:11 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Andreas Radke <andyrtr@archlinux.org>,
        Wolfram Sang <wsa@the-dreams.de>, benjamin.tissoires@redhat.com,
        aduggan@synaptics.com, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Message-ID: <20180404160211.57ae77ea@endymion>
In-Reply-To: <CAKf6xpu4=kLuqZqFsxqFCzLMyLBZyi3C9W_yyssEt=56dhF6RA@mail.gmail.com>
References: <20180402122536.5083-1-jandryuk@gmail.com>
        <20180402123435.5587-1-jandryuk@gmail.com>
        <20180403211326.4907f1bc@laptop64.home>
        <CAKf6xpu4=kLuqZqFsxqFCzLMyLBZyi3C9W_yyssEt=56dhF6RA@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, Andreas,

On Wed, 4 Apr 2018 08:55:20 -0400, Jason Andryuk wrote:
> On Tue, Apr 3, 2018 at 3:13 PM, Andreas Radke <andyrtr@archlinux.org> wrote:
> > I'm faced with similar cold boot issues on my HP ProBook 430 G4 model.
> > Trying your hint with adding
> > "options i2c_i801 disable_features=0x20"
> > to /etc/modprobe.d/i2c_i801.conf doesn't seem to solve it for me.  
> 
> Maybe verify the option is set by checking
> /sys/module/i2c_i801/parameters/disable_features ?  Looks like dmesg
> should also report "SMBus Host Notify disabled by user" when disabled.
> I run with i801 built-in, so I was specifying the option on the kernel
> command line.

Another thing to think of is that you may have to rebuild the
initrd/initramfs after editing /etc/modprobe.d/i2c_i801.conf if
i2c-i801 happens to be part of it (and make sure
that /etc/modprobe.d/i2c_i801.conf is indeed included in
initrd/initramfs then.)

> > My system boots legacy grub in text mode (KMS) and seems to keep hanging
> > even with that option set.  
> 
> Your cold boot hang is in legacy grub itself?  Legacy grub text mode
> actually doesn't hang my G3 850 - it was switching to the graphical
> splash screen that seemed to do it.  PXE booting via F12 was another
> consistent way to hang.  It was very early in the PXE boot code -
> before it checked the link status.  So you could try that with it just
> plugged into a switch even if you don't have a PXE boot setup.
> 
> From my previous post:
> """
> The Boot Agent hang prints "Client Mac Addr 00-11-22-33-44-55<cursor>"
> and hangs.  A normal boot prints a GUID on the same line and
> continues.
> """
> 
> Otherwise, unfortunately, it might just be a different issue.

I recall reports about hangs when we first added support for
interrupts. I think we addressed all the bugs in this area since then
but maybe not. So you may want to try disable_features=0x30 to disable
both interrupts and SMBus Host Notify.

-- 
Jean Delvare
SUSE L3 Support
