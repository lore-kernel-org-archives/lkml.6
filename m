Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6166C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CFB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CFB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJIGIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:08:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:58318 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeJIGIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:08:45 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1g9ePs-0006DE-5I; Tue, 09 Oct 2018 00:54:20 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g9ePr-0000MX-VJ; Tue, 09 Oct 2018 00:54:19 +0200
Subject: Re: [PATCHv2 bpf-next] bpf: fix building without CONFIG_INET
To:     Song Liu <liu.song.a23@gmail.com>, joe@wand.net.nz
Cc:     Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        makita.toshiaki@lab.ntt.co.jp, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181008183001.10406-1-joe@wand.net.nz>
 <CAPhsuW5wNDEEQbHY_zCTcCQ_FKN4poBGq26H2Gksd=QB1SGZow@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7afaf95f-a8bd-986e-02ac-2f4900ae1c1a@iogearbox.net>
Date:   Tue, 9 Oct 2018 00:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5wNDEEQbHY_zCTcCQ_FKN4poBGq26H2Gksd=QB1SGZow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/25019/Mon Oct  8 22:53:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 10:52 PM, Song Liu wrote:
> On Mon, Oct 8, 2018 at 11:30 AM Joe Stringer <joe@wand.net.nz> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The newly added TCP and UDP handling fails to link when CONFIG_INET
>> is disabled:
>>
>> net/core/filter.o: In function `sk_lookup':
>> filter.c:(.text+0x7ff8): undefined reference to `tcp_hashinfo'
>> filter.c:(.text+0x7ffc): undefined reference to `tcp_hashinfo'
>> filter.c:(.text+0x8020): undefined reference to `__inet_lookup_established'
>> filter.c:(.text+0x8058): undefined reference to `__inet_lookup_listener'
>> filter.c:(.text+0x8068): undefined reference to `udp_table'
>> filter.c:(.text+0x8070): undefined reference to `udp_table'
>> filter.c:(.text+0x808c): undefined reference to `__udp4_lib_lookup'
>> net/core/filter.o: In function `bpf_sk_release':
>> filter.c:(.text+0x82e8): undefined reference to `sock_gen_put'
>>
>> Wrap the related sections of code in #ifdefs for the config option.
>>
>> Furthermore, sk_lookup() should always have been marked 'static', this
>> also avoids a warning about a missing prototype when building with
>> 'make W=1'.
>>
>> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Joe Stringer <joe@wand.net.nz>
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Applied to bpf-next, thanks!
