Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8321120842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dcvMx2nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBYMQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:16:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34115 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBYMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:16:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id d15so4446686plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 04:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QoHK3PgkDfCguINsmSF+2MuDz+h6HTxyVRXfDqtpRZg=;
        b=dcvMx2nnQUb9KYZws9peECQMeHPpL5aFu9AtR8QIYHJRPARWGWWLtCeJWg2lkjFExc
         +Yu9GZq2U/OUigzY7nhXv/N12yv7ZDnTQVXvXdoRpfC5IPwdNBlCKHAT9hHWBgQltGbm
         6J1mi3qweufoa7wFeQ6aJOEODl611JN3aFUwBbMNoegswcIM9ZKNAYWbC7SHM/oxs+xJ
         sML5p6lFAMh6zDGafz4iDkkp5h/bYb0pcfDQSeTWEdasAm58VHoNgKjj4DktD1XZRzSP
         Y6k1fNzfrebGzArL8N+Awr5NHTiUcSeCD8YvhAa3LYe8LjSBouDhGiD3BUQWP4/VKnON
         cIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QoHK3PgkDfCguINsmSF+2MuDz+h6HTxyVRXfDqtpRZg=;
        b=EPomhEVQBOW8eGQemu4kFcXdCBZZ/iicpoirF4cdL4YG6Xqo0fE/o/NvGxFsL0kVcb
         s+mIXQT3wBIn1UU7sWlhlAB9k/7MoJUPC49GM6sBJLRH1SfNa4dBOYIDS9T8FwxEnzGv
         5c1Ks59q/sxgXKjQa3XGRxNEChqKjOTHAB8lALmY4eYbqHealnTBxZ2DMYjNID81RUjB
         t1YosjovsR/+dBRxCq7xFnpDIyY1VWMLf7T7WkTm12p0Yzzvw6gkHaO3DA6lwKFJ5Q9T
         8H3rmmXrFYzFR8ATexYJttI/p63P/rDhosc5UySqaqHIdrjpR9nRIfJQ9YyTR4m88URe
         qaXQ==
X-Gm-Message-State: AHQUAua1MRp5JSSsvpwbg9K7fgwezj2P/rTiqzAqsvhYQGzKcKPZzcaJ
        RCVaZ90ZOITp+LAtyqlDJAJu5A==
X-Google-Smtp-Source: AHgI3Iae/hpdKws0On9nrGt+ofyS6R3GDjkkiVtcw6MZEHcEu3RLsH4W58bju8+OLMI5bulx6+MHGA==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr20151663plk.126.1551096965898;
        Mon, 25 Feb 2019 04:16:05 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id h64sm16611921pfc.142.2019.02.25.04.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 04:16:04 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 97A8B301717; Mon, 25 Feb 2019 15:16:01 +0300 (+03)
Date:   Mon, 25 Feb 2019 15:16:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        hughd@google.com, joel@joelfernandes.org, jglisse@redhat.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net
Subject: Re: [RFC PATCH] mm,mremap: Bail out earlier in mremap_to under map
 pressure
Message-ID: <20190225121601.k4g7cabebeemthae@kshutemo-mobl1>
References: <20190221085406.10852-1-osalvador@suse.de>
 <20190222130125.apa2ysnahgfuj2vx@kshutemo-mobl1>
 <cfc53e5a-a403-a732-69d2-1f96b8416f6d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc53e5a-a403-a732-69d2-1f96b8416f6d@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:46:46PM +0100, Vlastimil Babka wrote:
> On 2/22/19 2:01 PM, Kirill A. Shutemov wrote:
> > On Thu, Feb 21, 2019 at 09:54:06AM +0100, Oscar Salvador wrote:
> >> When using mremap() syscall in addition to MREMAP_FIXED flag,
> >> mremap() calls mremap_to() which does the following:
> >>
> >> 1) unmaps the destination region where we are going to move the map
> >> 2) If the new region is going to be smaller, we unmap the last part
> >>    of the old region
> >>
> >> Then, we will eventually call move_vma() to do the actual move.
> >>
> >> move_vma() checks whether we are at least 4 maps below max_map_count
> >> before going further, otherwise it bails out with -ENOMEM.
> >> The problem is that we might have already unmapped the vma's in steps
> >> 1) and 2), so it is not possible for userspace to figure out the state
> >> of the vma's after it gets -ENOMEM, and it gets tricky for userspace
> >> to clean up properly on error path.
> >>
> >> While it is true that we can return -ENOMEM for more reasons
> >> (e.g: see may_expand_vm() or move_page_tables()), I think that we can
> >> avoid this scenario in concret if we check early in mremap_to() if the
> >> operation has high chances to succeed map-wise.
> >>
> >> Should not be that the case, we can bail out before we even try to unmap
> >> anything, so we make sure the vma's are left untouched in case we are likely
> >> to be short of maps.
> >>
> >> The thumb-rule now is to rely on the worst-scenario case we can have.
> >> That is when both vma's (old region and new region) are going to be split
> >> in 3, so we get two more maps to the ones we already hold (one per each).
> >> If current map count + 2 maps still leads us to 4 maps below the threshold,
> >> we are going to pass the check in move_vma().
> >>
> >> Of course, this is not free, as it might generate false positives when it is
> >> true that we are tight map-wise, but the unmap operation can release several
> >> vma's leading us to a good state.
> >>
> >> Because of that I am sending this as a RFC.
> >> Another approach was also investigated [1], but it may be too much hassle
> >> for what it brings.
> > 
> > I believe we don't need the check in move_vma() with this patch. Or do we?
> 
> move_vma() can be also called directly from SYSCALL_DEFINE5(mremap) for
> the non-MMAP_FIXED case. So unless there's further refactoring, the
> check is still needed.

Okay, makes sense.

> >>
> >> [1] https://lore.kernel.org/lkml/20190219155320.tkfkwvqk53tfdojt@d104.suse.de/
> >>
> >> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
