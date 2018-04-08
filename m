Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeDHDIc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:08:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752466AbeDHDIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:08:31 -0400
Date: Sun, 8 Apr 2018 06:08:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v2 0/3] mm/get_user_pages_fast fixes, cleanups
Message-ID: <20180408060341-mutt-send-email-mst@kernel.org>
References: <1522962072-182137-1-git-send-email-mst@redhat.com>
 <20180406130802.d80742aeda85a595150b28cf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406130802.d80742aeda85a595150b28cf@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 01:08:02PM -0700, Andrew Morton wrote:
> On Fri, 6 Apr 2018 00:03:48 +0300 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Turns out get_user_pages_fast and __get_user_pages_fast return different
> > values on error when given a single page: __get_user_pages_fast returns
> > 0.  get_user_pages_fast returns either 0 or an error.
> > 
> > Callers of get_user_pages_fast expect an error so fix it up to return an
> > error consistently.
> > 
> > Stress the difference between get_user_pages_fast and __get_user_pages_fast
> > to make sure callers aren't confused.
> > 
> 
> A term which is missing from all these changelogs is "vhost" :(

vhost has a BUG_ON for unexpected handling so it catches the bug, but
it's not the only site affected.

> This patchset fixes a user-affecting bug, does it not?  If so, please
> fully describe that bug so that we can decide which kernel version(s)
> need the patchset.

OK, I'll try to write up something.

> And yes, this return value asymmetry is sad.  Did you scope out what
> would be needed to fix up the callers so we can avoid this?

Yes - there is a very small number of callers for __get_user_pages_fast
so it's easy to teach them all to treat any value <=0 as 0.
There seems to be some opposition to changing the API,
I'd like to look into this after the bugfix patchset is merged.

-- 
MST
