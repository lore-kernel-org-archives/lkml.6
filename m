Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B76C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AA2224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AA2224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=itcare.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeKMDAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:00:05 -0500
Received: from smtp7.iq.pl ([86.111.240.244]:51003 "EHLO smtp7.iq.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbeKMDAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:00:05 -0500
Received: from [192.168.2.200] (unknown [185.78.72.18])
        (Authenticated sender: pstaszewski@itcare.pl)
        by smtp.iq.pl (Postfix) with ESMTPSA id 42txwg515Qz3wrn;
        Mon, 12 Nov 2018 18:05:55 +0100 (CET)
Subject: Re: [PATCH 1/2] mm/page_alloc: free order-0 pages through PCP in
 page_frag_free()
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     aaron.lu@intel.com, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        ilias.apalodimas@linaro.org, yoel@kviknet.dk,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, dave.hansen@linux.intel.com
References: <20181105085820.6341-1-aaron.lu@intel.com>
 <CAKgT0UdvYVTA8OjgLhXo9tRUOGikrCi3zJXSrqM0ZmeHb5P2mA@mail.gmail.com>
 <b8b1fbb7-9139-9455-69b8-8c1bed4f7c74@itcare.pl>
 <CAKgT0UdhcXF-ohPHPbg8onRjFabEMnbpXGmLm-27skCNzGKOgw@mail.gmail.com>
 <bd33633b-2f6c-0034-a130-38a8468531db@itcare.pl>
 <CAKgT0UeOBF0yPJLOTBBb3m7nTkmSDxzkCur+iGzJ++Y-jWaw9g@mail.gmail.com>
 <6edcec1a-eefa-7861-1af4-cdf7fa45184c@gmail.com>
From:   =?UTF-8?Q?Pawe=c5=82_Staszewski?= <pstaszewski@itcare.pl>
Message-ID: <7a879d64-1d5a-ebda-8f44-b8d6bdd94afd@itcare.pl>
Date:   Mon, 12 Nov 2018 18:06:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <6edcec1a-eefa-7861-1af4-cdf7fa45184c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


W dniu 12.11.2018 o 16:44, Eric Dumazet pisze:
>
> On 11/12/2018 07:30 AM, Alexander Duyck wrote:
>
>> It sounds to me like XDP would probably be your best bet. With that
>> you could probably get away with smaller ring sizes, higher interrupt
>> rates, and get the advantage of it batching the Tx without having to
>> drop packets.
> Add to this that with XDP (or anything lowering per packet processing costs)
> you can reduce number of cpus/queues, get better latencies, and bigger TX batches.

Yes for sure - the best for my use case will be to implement XDP :)

But for real life not test lab use programs like xdp_fwd need to be 
extended for minimal information needed from IP router - like counters 
and some aditional debug for traffic like sniffing / sampling for ddos 
detection.

And that is rly minimum needed - for routing IP traffic with XDP


