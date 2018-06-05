Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeFEMbR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:31:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbeFEMbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:31:16 -0400
Date: Tue, 5 Jun 2018 14:28:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Ilya Matveychikov <matvejchikov@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
Message-ID: <20180605122829.y4vicefcfvzpqraw@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Ilya Matveychikov <matvejchikov@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
 <20180605112641.GN30522@ZenIV.linux.org.uk>
 <1E519BA2-4198-4255-BAE4-3125C59741A3@gmail.com>
 <20180605115340.GO30522@ZenIV.linux.org.uk>
 <0F38EDA5-DEC3-48A1-9375-47949C26DAE8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0F38EDA5-DEC3-48A1-9375-47949C26DAE8@gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:07:15PM +0400, Ilya Matveychikov wrote:
> > On Jun 5, 2018, at 3:53 PM, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> > On Tue, Jun 05, 2018 at 03:35:55PM +0400, Ilya Matveychikov wrote:
> >>> On Jun 5, 2018, at 3:26 PM, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> >>>>> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov <matvejchikov@gmail.com> wrote:
> >>>>> Early check for mount permissions prevents possible allocation of 3
> >>>>> pages from kmalloc() pool by unpriveledged user which can be used for
> >>>>> spraying the kernel heap.
> >>> 
> >>> I'm sorry, but there are arseloads of unpriveleged syscalls that do the same,
> >>> starting with read() from procfs files.  So what the hell does it buy?
> >> 
> >> Means that if all do the same shit no reason to fix it? Sounds weird...
> > 
> > Fix *what*?  You do realize that there's no permission checks to stop e.g.
> > stat(2) from copying the pathname in, right?  With user-supplied contents,
> > even...
> > 
> > If you depend upon preventing kmalloc'ed temporary allocations filled
> > with user-supplied data, you are screwed, plain and simple.  It really can't
> > be prevented, in a lot of ways that are much less exotic than mount(2).
> > Most of syscall arguments are copied in, before we get any permission
> > checks.  It does happen and it will happen - examining them while they are
> > still in userland is a nightmare in a lot of respects, starting with
> > security.
> 
> I agree that it’s impossible to completely avoid this kind of allocations
> and examining data in user-land will be the bigger problem than copying
> arguments to the kernel. But aside of that what’s wrong with the idea of
> having the permission check before doing any kind of work?

Isn't there some sysctl knob or config option to sanitize freed memory?
I doubt that using kzfree everywhere unconditionally would be welcome,
also would not scale as there are too many of them. This IMHO leaves
only the build-time option for those willing to pay the performance hit.

> BTW, sys_umount() has this check in the right place - before doing anything.
> So, why not to have the same logic for mount/umount?

What if the check is not equivalent to the one done later? may_mount
needs namespace, it will be available at umount time but not necessarily
during mount due to the security hooks.
