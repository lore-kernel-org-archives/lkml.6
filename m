Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39DD20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="be7UFB1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfAKCIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:08:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33866 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfAKCIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:08:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so6034636plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Pbs3viVnbLmrJDgZToOWnI2RCPBUPFNlcmEf/PajdJI=;
        b=be7UFB1LIsM1GXBUnRqgUd1Bg5S47LHTc2yx/D8RMpNdLkrEnNcED8NWgmKomJqmIp
         WYgPN5abdriOnT3SevisE/0NwDFNJm98i7Be+Yrrs7w3sFyh7/lrZVItpBY6kofBUDOu
         pJb1Lh35mDCcDASTBoeUkDycl4LRVlQLpMsmSkvJxeZk/Txd1lR5ry5mibtvseHAiu2p
         RfOEXz8MP2uBBNzf/BVP27ymYip56gz6xvNjqpT11W93MQvBoF0Y3YoSVbzL3KzR5T9t
         4exhZdcdIU4hoVbQE+e9wmpsTGnBFzRbm/SmI7DtE5/CFUvu2vCXhHJEJiD/zifhK4td
         x9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Pbs3viVnbLmrJDgZToOWnI2RCPBUPFNlcmEf/PajdJI=;
        b=HDepZ6rbit++FOjmy3wrO/mv7slW2hkkTZVHgpiabe3h9q3dYVHE5SW9D9WnLGtytp
         WcHNvP/235PEKgvuqNIJA746JyMVs/T5kl9vpvwBAIBtBRp13OxWNReREvy4K8g5DNBu
         u0fsdgNNJbcDWUtqvpNtYkt0JwcatlVuqmMFrE2iqAwVwSm9Diq3sb8ewumC1gro6sHa
         b5eymmm27LfrtxFSTpPjDrzGtL022i1wOA3vL30+L1YszdO1VAoFiyoz7jBGriJtMsBj
         UFhEjOkUcbtUnWrX00ZtwwqEcpZOqaW2f1bplg94JlNk9QM6qTyi6n69Ie9vpDfXyNrn
         kJ5w==
X-Gm-Message-State: AJcUukd97oxO141q/Jb3hXqYn/8cz5fIE7HW2mKhzqJKIJDPqyA6W7hM
        WhMwfoRS8BM4EpE0xJo20rvyXw==
X-Google-Smtp-Source: ALg8bN4UQkYPpqJKpxWxRaK4cmgmxKZNkNyamVkTWcAR4FwLrPYPdnPfoPvOk/aDS3iWtakkjV8faA==
X-Received: by 2002:a17:902:5588:: with SMTP id g8mr12780632pli.22.1547172532918;
        Thu, 10 Jan 2019 18:08:52 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id v9sm111315757pfg.144.2019.01.10.18.08.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 18:08:50 -0800 (PST)
Date:   Thu, 10 Jan 2019 18:08:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is
 migrated
In-Reply-To: <fccdbef6-00cf-38ad-3aa0-9466c9b83176@suse.cz>
Message-ID: <alpine.LSU.2.11.1901101748550.3146@eggly.anvils>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils> <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com> <alpine.LSU.2.11.1811251900300.1278@eggly.anvils> <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
 <fccdbef6-00cf-38ad-3aa0-9466c9b83176@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Vlastimil Babka wrote:
> 
> For the record, anyone backporting this to older kernels should make
> sure to also include 605ca5ede764 ("mm/huge_memory.c: reorder operations
> in __split_huge_page_tail()") or they are in for a lot of fun, like me.

Thanks a lot for alerting us all to this, Vlastimil.  Yes, I consider
Konstantin's 605ca5ede764 a must-have, and so had it already in all
the trees on which I was testing put_and_wait_on_page_locked(),
without being aware of the critical role it was playing.

But you do enjoy fun, don't you? So I shouldn't apologize :)

> 
> Long story [1] short, Konstantin was correct in 605ca5ede764 changelog,
> although it wasn't the main known issue he was fixing:
> 
>   clear_compound_head() also must be called before unfreezing page
>   reference because after successful get_page_unless_zero() might follow
>   put_page() which needs correct compound_head().
> 
> Which is exactly what happens in __migration_entry_wait():
> 
>         if (!get_page_unless_zero(page))
>                 goto out;
>         pte_unmap_unlock(ptep, ptl);
>         put_and_wait_on_page_locked(page); -> does put_page(page)
> 
> while waiting on the THP split (which inserts those migration entries)
> to finish. Before put_and_wait_on_page_locked() it would wait first, and
> only then do put_page() on a page that's no longer tail page, so it
> would work out despite the dangerous get_page_unless_zero() on a tail
> page. Now it doesn't :)

It took me a while to follow there, but yes, agreed.

> 
> Now if only 605ca5ede764 had a CC:stable and a Fixes: tag... Machine
> Learning won this round though, because 605ca5ede764 was added to 4.14
> stable by Sasha...

I'm proud to have passed the Turing test in reverse, but actually
that was me, not ML.  My 173d9d9fd3dd ("mm/huge_memory: splitting set
mapping+index before unfreeze") in 4.20 built upon Konstantin's, so I
included his as a precursor when sending the stable guys pre-XArray
backports.  So Konstantin's is even in 4.9 stable now.

Hugh
