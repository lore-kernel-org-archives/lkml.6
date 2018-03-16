Return-Path: <dsterba@suse.cz>
X-Google-Smtp-Source: AG47ELsUBxtVjTyz7cPOsjVGBc3v1qJmtAe0mXzOscK9UU5CjCuHdjilBgdDhEt9Bnhir63ivnBk
ARC-Seal: i=1; a=rsa-sha256; t=1521206667; cv=none;
        d=google.com; s=arc-20160816;
        b=H1F7tNUErT2fiVmh+AqlY3ip2goY8bdzKPTJN/WZ+QiynaH3BVbe/butQoiw/41cEm
         xoiaTnsQ4v7dNSbVVtWDJHsH4TbuKt+dSBZr3PN2zhejkPq3IqO+1+IbCmrGGRm8EjC0
         /oVZZfAkZQOrlPZrekCVxcB6ulJiz9Svu1aJg5cWDs+HciP6m4wapprSdFeh5e7axOxx
         qqiN4PSz+Rl8PLNUx7+ZHW7/0wKzfhLofvlI0SziA3H00QD1ul01OVRvSdIy4fPFDX0D
         uuY1v/FGp9PT1Lb1ByBLeC97SQfczK3C5PcEMPDod365Agk8YPQ6nPiasQyR+TSAtNK3
         TEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=mAIlOlfRKInv63fTmT6G9/y4B7bsKlpBUVwqbSqOo0U=;
        b=HTkdZKLufoXFrUjmv0m8IqyQa2t8ONgyr7inhhlF09hAU+zlpATqgEBzT2LTlB7DwQ
         a6ABvRNL3jt9ExJOY4mMEjnUQ90Som49qpNQdPkbBB1XeaqJsz4Oys16nwjLmTxSXWS8
         Tx3jKerSyQJSG1KPxZ6OYB4hoFIaT1Zm3FwxNpU4pMFT2MqrkdWakENl5bT9g6lwD1uA
         OztXyabZOlhlCDsHxLgNxpHrB/SDrs+MQM0Az+nVcaFTznuRnUPjSg4urGYZx46OYrDr
         puZFJFZZIUALahF8X7DWMvKMTgvLA9DDbt/8BhdZyoiYtNIMccCe+sJ+GluWgHtyUhJ2
         i19Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Date: Fri, 16 Mar 2018 14:22:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
	Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
Message-ID: <20180316132202.GB8297@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
	Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
 <1521139304@msgid.manchmal.in-ulm.de>
 <20180316123049.GC25079@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316123049.GC25079@kroah.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309090147375870?=
X-GMAIL-MSGID: =?utf-8?q?1595100802777288681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 01:30:49PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 15, 2018 at 07:55:42PM +0100, Christoph Biedl wrote:
> > Greg Kroah-Hartman wrote...
> > 
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > > commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
> > (...)
> > 
> > > If the filesystem is always used on a same endian host, this will not
> > > be a problem.
> > 
> > >From my observations I cannot quite subscribe to that.
> > 
> > On big-endian systems, this change intruduces severe corruption,
> > resulting in complete loss of the data on the used block device.
> > 
> > Steps to reproduce (tested on ppc/powerpc and parisc/hppa):
> > 
> > # mkfs.btrfs $DEV
> > # mount $DEV /mnt/tmp/
> > # umount /mnt/tmp/
> > 
> > This simple umount corrupts the file system:
> > 
> > # mount $DEV /mnt/tmp/
> > mount: /mnt/tmp: wrong fs type, bad option, bad superblock on $DEV, missing codepage or helper program, or other error.
> > 
> > # dmesg:
> > BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
> > BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
> > BTRFS critical (device <dev>): unable to find logical 18102363734671360 length 16384
> > BTRFS error (device <dev>): failed to read chunk root
> > BTRFS error (device <dev>): open_ctree failed
> > 
> > Also fsck is of no help:
> > 
> > # btrfsck $DEV
> > Couldn't map the block 18102363734671360
> > No mapping for 18102363734671360-18102363734687744
> > Couldn't map the block 18102363734671360
> > bytenr mismatch, want=18102363734671360, have=0
> > ERROR: cannot read chunk root
> > ERROR: cannot open file system
> > 
> > 
> > Trying mount or fsck on a little-endian system does not help either. So
> > I consider the data on that device lost - luckily I use btrfs only for
> > files where a backup exists all the time.
> > 
> > 
> > Reverting that change restored the previous error-free behaviour. I
> > didn't check HEAD, i.e. v4.16-rc5, since the upstream commt was the last
> > that affected these files. Still I could give this a try if anybody
> > wishes so.
> 
> That sucks.  Can you test Linus's tree to verify the problem is there?
> I'll gladly revert this if Linus's tree also gets the revert, I don't
> want you to hit this when you upgrade to a newer kernel.

I'll push a fix for the upcoming rc but I think it would be better to
remove the broken patch from stable kernels ASAP, so I'd recommend to
revert it now.
