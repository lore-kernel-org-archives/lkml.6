Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEFQpC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 12:45:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44603 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeEFQpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 12:45:00 -0400
X-Google-Smtp-Source: AB8JxZr7uEMidliOXI23CNYkWbojVMvunmX0wqX1Om0DnzeTiKl2zrsnmyNOFQnZLo4dwY7Ry9OcaA==
Date: Sun, 6 May 2018 19:44:57 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Jonathan de Boyne Pollard
        <J.deBoynePollard-newsgroups@NTLWorld.COM>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] prctl: (Please do not!) Deprecate non PR_SET_MM_MAP
 operations
Message-ID: <20180506164457.GP31735@uranus>
References: <c8d4aa19-1bb4-3f72-4600-8d20fdad98d9@NTLWorld.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d4aa19-1bb4-3f72-4600-8d20fdad98d9@NTLWorld.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 12:01:44PM +0100, Jonathan de Boyne Pollard wrote:
> Cyrill Gorcunov:
> 
> > Or we can simply drop it off because PR_SET_MM_MAP covers all needs, and I
> would rather prefer to do that asap.
> 
> Please do not do that, because PR_SET_MM_MAP really does not cover all
> needs.  Not by a long shot.
> 
> The use case is applications that want to affect /proc/self/cmdline and
> /proc/self/environ on the fly, for controlling what is displayed in a ps
> listing, but do not have to hand or want to deal in any of the *other*
> information that PR_SET_MM_MAP mandates.  They just want the pseudo-files to
> point to a new chunk of memory that they have allocated from their heaps and
> filled in.  They don't want to have to deal in all of the otherwise
> irrelevant stuff, of how they are loaded into memory and open file
> descriptors for executables.
> 
> * https://unix.stackexchange.com/a/438007/5132
> 
> * https://unix.stackexchange.com/a/432681/5132
> 
> You have not provided a way to read out that information, which would at
> least make a query-modify-set approach viable for such applications.  So
> please do not remove the API that works and that is in use without providing
> a usable substitute that is at least as good, which what you are proposing
> is not.  Ironically, if you replaced what you want to replace by going back
> to the original design of having start+length passed in one atomic ioctl()
> call, rather than two separate ioctl() calls for setting start and end
> individually (and the consequent hoops that applications softwares have to
> jump through when modifying to new pointer pairs, and seemingly unavoidable
> windows for outright data leaks, because they cannot read out the existing
> values and cannot even temporarily set start > end), that would be a welcome
> improvement.
> 
> Incidentally, it is a welcome change to see the idea that unprivileged
> processes may alter these things being introduced, as is already the case on
> (say) FreeBSD.
> 
> (I am not subscribed to linux-kernel.)

So eventually people use this feature outside of criu. Moreover I found that
systemd calls for PR_SET_MM_ARG_START/END (hell knows how I managed to miss
it when beeing googling for constants trying to find a user for this interface).

That said, indeed, we can't just drop it away while here are users. I'm
working on patches to bring back compat layer with the former interface.

Thanks a huge for reporting!

	Cyrill
