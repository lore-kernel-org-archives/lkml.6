Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeCPTTN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:19:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750921AbeCPTTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:19:12 -0400
Date: Fri, 16 Mar 2018 15:19:09 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 4/4] mm/hmm: change CPU page table snapshot functions to
 simplify drivers
Message-ID: <20180316191909.GA4861@redhat.com>
References: <20180315183700.3843-1-jglisse@redhat.com>
 <20180315183700.3843-5-jglisse@redhat.com>
 <cc1bfc05-9b06-1de8-7b14-ca1a6bc6496c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc1bfc05-9b06-1de8-7b14-ca1a6bc6496c@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 10:08:21PM -0700, John Hubbard wrote:
> On 03/15/2018 11:37 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > This change hmm_vma_fault() and hmm_vma_get_pfns() API to allow HMM
> > to directly write entry that can match any device page table entry
> > format. Device driver now provide an array of flags value and we use
> > enum to index this array for each flag.
> > 
> > This also allow the device driver to ask for write fault on a per page
> > basis making API more flexible to service multiple device page faults
> > in one go.
> > 
> 
> Hi Jerome,
> 
> This is a large patch, so I'm going to review it in two passes. The first 
> pass is just an overview plus the hmm.h changes (now), and tomorrow I will
> review the hmm.c, which is where the real changes are.
> 
> Overview: the hmm.c changes are doing several things, and it is difficult to
> review, because refactoring, plus new behavior, makes diffs less useful here.
> It would probably be good to split the hmm.c changes into a few patches, such
> as:
> 
> 	-- HMM_PFN_FLAG_* changes, plus function signature changes (mm_range* 
>            being passed to functions), and
>         -- New behavior in the page handling loops, and 
> 	-- Refactoring into new routines (hmm_vma_handle_pte, and others)
> 
> That way, reviewers can see more easily that things are correct. 

So i resent patchset and i splitted this patch in many (11 patches now).
I included your comments so far in the new version so probably better if
you look at new one.

[...[

> > - * HMM_PFN_READ:  CPU page table has read permission set
> 
> So why is it that we don't need the _READ flag anymore? I looked at the corresponding
> hmm.c but still don't quite get it. Is it that we just expect that _READ is
> always set if there is an entry at all? Or something else?

Explained why in the commit message, !READ when WRITE make no sense so
now VALID imply READ as does WRITE (write by itself is meaningless
without valid).

Cheers,
Jérôme
