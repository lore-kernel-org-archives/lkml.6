Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeFEWx4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:53:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38376 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeFEWxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:53:55 -0400
X-Google-Smtp-Source: ADUXVKJevm9G+FbSigsVUGLq+9Cmo+A7jWhuZ79nc10AhR8MyJtBf0lGhvwzP6UudQ9borCTMeBAZQ==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mremap: Avoid TLB flushing anonymous pages that are not
 in swap cache
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180605200800.emb3yfdtnpjgmxb7@techsingularity.net>
Date: Tue, 5 Jun 2018 15:53:51 -0700
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Aaron Lu <aaron.lu@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Message-Id: <4635880A-CC44-4E06-B3DB-597DE6F5B530@gmail.com>
References: <20180605171319.uc5jxdkxopio6kg3@techsingularity.net>
 <EAD124C4-FFA4-4894-AE8B-33949CD6731B@gmail.com>
 <20180605200800.emb3yfdtnpjgmxb7@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55Ms29c020023

Mel Gorman <mgorman@techsingularity.net> wrote:

> On Tue, Jun 05, 2018 at 12:53:57PM -0700, Nadav Amit wrote:
>> While I do not have a specific reservation regarding the logic, I find the
>> current TLB invalidation scheme hard to follow and inconsistent. I guess
>> should_force_flush() can be extended and used more commonly to make things
>> clearer.
>> 
>> To be more specific and to give an example: Can should_force_flush() be used
>> in zap_pte_range() to set the force_flush instead of the current code?
>> 
>>  if (!PageAnon(page)) {
>> 	if (pte_dirty(ptent)) {
>> 		force_flush = 1;
>> 		...
>>  	}
> 
> That check is against !PageAnon pages where it's potentially critical
> that the dirty PTE bit be propogated to the page. You could split the
> separate the TLB flush from the dirty page setting but it's not the same
> class of problem and without perf data, it's not clear it's worthwhile.
> 
> Note that I also didn't handle the huge page moving because it's already
> naturally batching a larger range with a lower potential factor of TLB
> flushing and has different potential race conditions.

I noticed.

> 
> I agree that the TLB handling would benefit from being simplier but it's
> not a simple search/replace job to deal with the different cases that apply.

I understand. It’s not just a matter of performance: having a consistent
implementation can prevent bugs and allow auditing of the invalidation
scheme.

Anyhow, if I find some free time, I’ll give it a shot.
