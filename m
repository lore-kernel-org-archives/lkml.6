Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE383C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B64C208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B64C208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeGJUCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:02:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:44790 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJUCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:02:48 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcypr-00011V-Ui; Tue, 10 Jul 2018 22:02:07 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcypr-000GOa-Pq; Tue, 10 Jul 2018 22:02:07 +0200
Subject: Re: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
To:     Okash Khawaja <osk@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20180709002202.019053555@fb.com>
 <20180709004002.440153594@fb.com>
 <20180709183236.r4b7gzmev5h4lcbw@kafai-mbp.dhcp.thefacebook.com>
 <58136182-0eb1-78c9-ceb9-402418c7d10c@iogearbox.net>
 <20180710174904.GA3247@w1t1fb>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <939115f0-3457-75f2-c1df-4cfc6a53ba52@iogearbox.net>
Date:   Tue, 10 Jul 2018 22:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180710174904.GA3247@w1t1fb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24740/Tue Jul 10 15:42:50 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 07:49 PM, Okash Khawaja wrote:
> On Tue, Jul 10, 2018 at 10:21:02AM +0200, Daniel Borkmann wrote:
>> On 07/09/2018 08:32 PM, Martin KaFai Lau wrote:
>>> On Sun, Jul 08, 2018 at 05:22:03PM -0700, Okash Khawaja wrote:
>>>> When extracting bitfield from a number, btf_int_bits_seq_show() builds
>>>> a mask and accesses least significant byte of the number in a way
>>>> specific to little-endian. This patch fixes that by checking endianness
>>>> of the machine and then shifting left and right the unneeded bits.
>>>>
>>>> Thanks to Martin Lau for the help in navigating potential pitfalls when
>>>> dealing with endianess and for the final solution.
>>>>
>>>> Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
>>>> Signed-off-by: Okash Khawaja <osk@fb.com>
>>>>
>>>> ---
>>>>  kernel/bpf/btf.c |   32 +++++++++++++++-----------------
>>>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>>>
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>> @@ -162,6 +162,8 @@
>>>>  #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
>>>>  #define BITS_ROUNDUP_BYTES(bits) \
>>>>  	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
>>>> +const int one = 1;
>>>> +#define is_big_endian() ((*(char *)&one) == 0)
>>
>> Also here, in the kernel archs provide proper definitions.
> Is this the __BIG_ENDIAN #define or are there better ways to check that?

Given this deals with bitfields, should be __{BIG,LITTLE}_ENDIAN_BITFIELD.
