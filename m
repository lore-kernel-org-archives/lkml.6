Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeFELxn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:53:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60654 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeFELxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:53:42 -0400
Date: Tue, 5 Jun 2018 12:53:40 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Ilya Matveychikov <matvejchikov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
Message-ID: <20180605115340.GO30522@ZenIV.linux.org.uk>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
 <20180605112641.GN30522@ZenIV.linux.org.uk>
 <1E519BA2-4198-4255-BAE4-3125C59741A3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E519BA2-4198-4255-BAE4-3125C59741A3@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:35:55PM +0400, Ilya Matveychikov wrote:
> 
> > On Jun 5, 2018, at 3:26 PM, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> >> 
> >>> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov <matvejchikov@gmail.com> wrote:
> >>> 
> >>> Early check for mount permissions prevents possible allocation of 3
> >>> pages from kmalloc() pool by unpriveledged user which can be used for
> >>> spraying the kernel heap.
> > 
> > I'm sorry, but there are arseloads of unpriveleged syscalls that do the same,
> > starting with read() from procfs files.  So what the hell does it buy?
> 
> Means that if all do the same shit no reason to fix it? Sounds weird...

Fix *what*?  You do realize that there's no permission checks to stop e.g.
stat(2) from copying the pathname in, right?  With user-supplied contents,
even...

If you depend upon preventing kmalloc'ed temporary allocations filled
with user-supplied data, you are screwed, plain and simple.  It really can't
be prevented, in a lot of ways that are much less exotic than mount(2).
Most of syscall arguments are copied in, before we get any permission
checks.  It does happen and it will happen - examining them while they are
still in userland is a nightmare in a lot of respects, starting with
security.
