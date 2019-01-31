Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F3AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466682086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbfAaMHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:07:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:41114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfAaMHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:07:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 327A4AC4B;
        Thu, 31 Jan 2019 12:06:59 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT is
 set for the I/O
To:     Daniel Gruss <daniel@gruss.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Jiri Kosina <jkosina@suse.cz>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jiri Kosina <jikos@kernel.org>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz>
 <aea9a09a-9d01-fd08-d210-96b94162aba6@gruss.cc>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <fb914afa-a76c-5678-81e8-ce5736f772be@suse.cz>
Date:   Thu, 31 Jan 2019 13:06:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <aea9a09a-9d01-fd08-d210-96b94162aba6@gruss.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 1:04 PM, Daniel Gruss wrote:
> On 1/30/19 1:44 PM, Vlastimil Babka wrote:
>> Close that sidechannel by always initiating readahead on the cache if we
>> encounter a cache miss for preadv2(RWF_NOWAIT); with that in place, probing
>> the pagecache residency itself will actually populate the cache, making the
>> sidechannel useless.
> 
> I fear this does not really close the side channel. You can time the
> preadv2 function and infer which path it took, so you just bring it down
> to the same as using mmap and timing accesses.
> If I understood it correctly, this patch just removes the advantages of
> preadv2 over mmmap+access for the attacker.

But isn't that the same with mincore()? We can't simply remove the
possibility of mmap+access, but we are closing the simpler methods?

Vlastimil


> Cheers,
> Daniel
> 

