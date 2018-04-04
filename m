Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeDDKBu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:01:50 -0400
Received: from www62.your-server.de ([213.133.104.62]:50012 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeDDKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:01:48 -0400
Subject: Re: PROBLEM: Using BPF_PROG_TEST_RUN with data_out != NULL is unsafe
To: Lorenz Bauer <lmb@cloudflare.com>, ast@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CACAyw9-TvamC2HMNv=WDk_aeAM=R7J_BgLiKjevY5+am71W6-A@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c3907b6a-a7cd-0fda-27fd-9357cf63cfec@iogearbox.net>
Date: Wed, 4 Apr 2018 12:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACAyw9-TvamC2HMNv=WDk_aeAM=R7J_BgLiKjevY5+am71W6-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 11:04 AM, Lorenz Bauer wrote:
> Hello,
> 
> I’ve encountered an issue when using BPF_PROG_TEST_RUN and capturing the output.
> The kernel copies data into user space without checking the length of
> the destination buffer.
> 
> In bpf_test_finish(), size is the amount of data in the XDP buffer /
> skb after the program is run. This can be larger than data_size_in due
> to bpf_xdp_adjust_head() and friends.
> bpf_test_finish doesn’t clamp size to data_size_out, which is what I
> was expecting.
> 
> What is the correct way to use this interface?

Yeah, so XDP has a headroom of XDP_PACKET_HEADROOM + NET_IP_ALIGN which in case
of x86 is 256 bytes (NET_IP_ALIGN being 0 there). This means that attr.test.data_out
buffer needs to be 256 bytes larger than attr.test.data_in in case the BPF prog
calls bpf_xdp_adjust_head() or bpf_xdp_adjust_meta(). In case you point data_in
and data_out to the same address, then the total buffer size therefore has to be
attr.test.data_size_in + 256 in order to not overrun anything while not being
aware of the BPF test program. The XDP_PACKET_HEADROOM is exposed to user space
in linux/bpf.h.
