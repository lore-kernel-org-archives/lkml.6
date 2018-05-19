Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeESOOu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 10:14:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeESOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 10:14:48 -0400
Date: Sat, 19 May 2018 07:14:45 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Roman Kagan <rkagan@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180519141445.GA9526@bombadil.infradead.org>
References: <20180518175025.GD6361@bombadil.infradead.org>
 <20180518153138.459c78a83c6bada41b4b187d@linux-foundation.org>
 <20180519062635.GA6352@rkaganip.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519062635.GA6352@rkaganip.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 09:26:36AM +0300, Roman Kagan wrote:
> On Fri, May 18, 2018 at 03:31:38PM -0700, Andrew Morton wrote:
> > On Fri, 18 May 2018 10:50:25 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > If the radix tree underlying the IDR happens to be full and we attempt
> > > to remove an id which is larger than any id in the IDR, we will call
> > > __radix_tree_delete() with an uninitialised 'slot' pointer, at which
> > > point anything could happen.  This was easiest to hit with a single entry
> > > at id 0 and attempting to remove a non-0 id, but it could have happened
> > > with 64 entries and attempting to remove an id >= 64.
> > > 
> > > Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
> > > Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> > > Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
> > > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > Neither of the changelogs I'm seeing attempt to describe the end-user
> > impact of the bug.  People like to know that so they can decide which
> > kernel version(s) need patching, so please always remember it.
> 
> That's my fault, Matthew may not have seen the original discussion among
> the KVM folks.
> 
> > Looknig at the sysbot report, the impact is at least "privileged user
> > can trigger a WARN", but I assume there could be worse,
> 
> Unfortunately it is worse: the syzcaller test boils down to opening
> /dev/kvm, creating an eventfd, and calling a couple of KVM ioctls.  None
> of this requires superuser.  And the result is dereferencing an
> uninitialized pointer which is likely a crash.
> 
> > as-yet-undiscovered impacts.  So I'm thinking a cc:stable is needed,
> > yes?
> 
> Well the specific path caught by syzbot is via KVM_HYPERV_EVENTD ioctl
> which is new in 4.17.  But I guess there are other user-triggerable
> paths, so cc:stable is probably justified.

We have around 250 calls to idr_remove() in the kernel today.  Many of
them pass an ID which is embedded in the object they're removing, so
they're safe.  Picking a few likely candidates:

drivers/firewire/core-cdev.c looks unsafe; the ID comes from an ioctl.
drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c is similar
drivers/atm/nicstar.c could be taken down by a handcrafted packet
