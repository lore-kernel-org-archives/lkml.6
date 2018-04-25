Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755963AbeDYQVQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:21:16 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:44401 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754839AbeDYQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:20:58 -0400
X-Google-Smtp-Source: AIpwx48zn+5eeyjVyDWbxRx5fw5IzDmV4W0RLpLWPEzBLPHWcjXTtQlcQCgkYjC4w1PhZEsT8GXJbA==
Subject: Re: [PATCH net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>
References: <20180425052722.73022-1-edumazet@google.com>
 <20180425052722.73022-2-edumazet@google.com>
 <20180425062859.GA23914@infradead.org>
 <5cd31eba-63b5-9160-0a2e-f441340df0d3@gmail.com>
 <20180425160413.GC8546@bombadil.infradead.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <8ce78bd6-8142-2937-11fd-2e4a2b22d90c@gmail.com>
Date: Wed, 25 Apr 2018 09:20:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425160413.GC8546@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 09:04 AM, Matthew Wilcox wrote:

> If you don't zap the page range, any of the CPUs in the system where
> any thread in this task have ever run may have a TLB entry pointing to
> this page ... if the page is being recycled into the page allocator,
> then that page might end up as a slab page or page table or page cache
> while the other CPU still have access to it.

Yes, this makes sense.

> 
> You could hang onto the page until you've built up a sufficiently large
> batch, then bulk-invalidate all of the TLB entries, but we start to get
> into weirdnesses on different CPU architectures.
> 

zap_page_range() is already doing a bulk-invalidate,
so maybe vm_replace_page() wont bring serious improvement if we end-up doing same dance.

Thanks.
