Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676B820881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfAaM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:57:42 -0500
Received: from gruss.cc ([80.82.209.135]:38468 "EHLO mail.gruss.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732280AbfAaM5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:57:42 -0500
Received: from [10.27.152.141] (unknown [129.27.152.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lava@gruss.cc)
        by mail.gruss.cc (Postfix) with ESMTPSA id 3772F2A0112;
        Thu, 31 Jan 2019 12:57:40 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT is
 set for the I/O
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz>
 <aea9a09a-9d01-fd08-d210-96b94162aba6@gruss.cc>
 <nycvar.YFH.7.76.1901311306570.3281@cbobk.fhfr.pm>
From:   Daniel Gruss <daniel@gruss.cc>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel@gruss.cc; prefer-encrypt=mutual; keydata=
 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
Message-ID: <443c3e0b-f93a-f857-0c95-9e0a1c87e318@gruss.cc>
Date:   Thu, 31 Jan 2019 13:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1901311306570.3281@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 1:08 PM, Jiri Kosina wrote:
> On Thu, 31 Jan 2019, Daniel Gruss wrote:
> 
>> If I understood it correctly, this patch just removes the advantages of 
>> preadv2 over mmmap+access for the attacker.
> 
> Which is the desired effect. We are not trying to solve the timing aspect, 
> as I don't think there is a reasonable way to do it, is there?

There are two building blocks to cache attacks, bringing the cache into
a state, and observing a state change, you can mitigate them by breaking
either of these building blocks.

For most attacks the attacker would be interested in observing *when* a
specific victim page is loaded into the page cache rather than observing
whether it is in the page cache right now (it could be there for ages if
the system was not under memory pressure).
So, one could try to prevent interference in the page cache between
attacker and victim -> working set algorithms do that to some extent.
Simpler idea (with more side effects) would be limiting the maximum
share of the page cache per user (or per process, depending on the
threat model)...


Cheers,
Daniel
