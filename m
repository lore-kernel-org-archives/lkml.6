Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755712AbeDCXDj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:03:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754297AbeDCXDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:03:38 -0400
Date: Tue, 3 Apr 2018 19:03:36 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/migrate: properly preserve write attribute in special
 migrate entry
Message-ID: <20180403230336.GH5935@redhat.com>
References: <20180402023506.12180-1-jglisse@redhat.com>
 <20180403153046.88cae4ab18646e8e23a648ce@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180403153046.88cae4ab18646e8e23a648ce@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 03:30:46PM -0700, Andrew Morton wrote:
> On Sun,  1 Apr 2018 22:35:06 -0400 jglisse@redhat.com wrote:
> 
> > From: Ralph Campbell <rcampbell@nvidia.com>
> > 
> > Use of pte_write(pte) is only valid for present pte, the common code
> > which set the migration entry can be reach for both valid present
> > pte and special swap entry (for device memory). Fix the code to use
> > the mpfn value which properly handle both cases.
> > 
> > On x86 this did not have any bad side effect because pte write bit
> > is below PAGE_BIT_GLOBAL and thus special swap entry have it set to
> > 0 which in turn means we were always creating read only special
> > migration entry.
> 
> Does this mean that the patch only affects behaviour of non-x86 systems?

No it affect x86 as explained below (ie it forces a second page fault).

> 
> > So once migration did finish we always write protected the CPU page
> > table entry (moreover this is only an issue when migrating from device
> > memory to system memory). End effect is that CPU write access would
> > fault again and restore write permission.
> 
> That sounds a bit serious.  Was a -stable backport considered?

Like discuss previously with Michal, for lack of upstream user yet
(and PowerPC users of this code are not upstream either yet AFAIK).

Once i get HMM inside nouveau upstream, i will evaluate if people
wants all fixes to be back ported to stable.

Finaly this one isn't too bad, it just burn CPU cycles by forcing
CPU to take a second fault on write access ie double fault the same
address. There is no corruption or incorrect states (it behave as
a COWed page from a fork with a mapcount of 1).


Do you still want me to be more aggressive with stable backport ?
I don't mind either way. I expect to get HMM nouveau upstream over
next couple release cycle.

Cheers,
Jérôme
