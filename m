Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E06C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 05:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66536218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 05:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLWFE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 00:04:28 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.38]:22175 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbeLWFE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 00:04:28 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4D1CF1C231
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 23:03:38 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id avvOghOxnYTGMavvOgW4w3; Sat, 22 Dec 2018 23:03:38 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=57676 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gavvN-003VDg-Kh; Sat, 22 Dec 2018 23:03:38 -0600
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181221204901.GA30045@embeddedor>
 <20181222.150722.1493687829239836271.davem@davemloft.net>
 <20181222235952.keue7a336sg7jfim@ast-mbp.dhcp.thefacebook.com>
 <20181222.184051.718127928973898182.davem@davemloft.net>
 <e1c8e69b-3417-6176-6b49-1b7a23febb21@embeddedor.com>
 <20181223030039.wrpytx7pwfcljdjm@ast-mbp.dhcp.thefacebook.com>
 <37df17ba-7fcf-ab04-fe9a-d2a6fc5b6b9c@embeddedor.com>
 <20181223041253.bxqru567rs32mecg@ast-mbp.dhcp.thefacebook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e8343bfd-7846-a23b-b6c0-4b82218efdc0@embeddedor.com>
Date:   Sat, 22 Dec 2018 23:03:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181223041253.bxqru567rs32mecg@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gavvN-003VDg-Kh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.106.44]:57676
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei,

On 12/22/18 10:12 PM, Alexei Starovoitov wrote:
> On Sat, Dec 22, 2018 at 09:37:02PM -0600, Gustavo A. R. Silva wrote:
>>
>> Can't we have the case in which the code can be "trained" to read
>> perfectly valid values for prog->len for quite a while, making the
>> microcode come into place and speculate about:
>>
>> 1013         if (flen == 0 || flen > BPF_MAXINSNS)
>> 1014                 return false;
>>
>> and then make flen to be greater than BPF_MAXINSNS?
> 
> Yes. The user space can train line 1013 to mispredict by passing
> smaller flen N times and then passing large flen.
> Why do you think it's exploitable?
> 
> Without the patch in the mispredicted path the cpu will do
> if (0 < flen) condition and since flen is hot in the cache
> it will happily execute the filter[0] load...
> and about 12-20 u-ops later (depending on u-arch of cpu) when
> branch predictor realizes that it's a miss, the cpu will ignore
> the values computed in the shadow cpu registers used by speculative execution
> and go back to the 'return false' execution path.
> The side effect of bringing filter[0] value in L1 cache is still there.
> The cpu is incapable to undo that cache load. That's what spectre1 is about.
> Do you see how filter[0] value in cpu L1 cache is exploitable?
> 

In this regard, the policy has been to kill the speculation on that
first load (as I mentioned in my last email. It is also mentioned in
the commit log for every patch).

> I took another look at the following patches:
> "net: core: Fix Spectre v1 vulnerability"
> "nfc: af_nfc: Fix Spectre v1 vulnerability"
> "can: af_can: Fix Spectre v1 vulnerability"
> and I have to say that none of them are necessary.
> I'm not sure whether there were other patches that pretend to fix spectre1.
> 

It's not about pretending to fix it. It's about trying to prevent the
conditions that can actually trigger the exploitation of a potential
vulnerability.  The code is not always the same, it changes, it evolves,
and we are currently trying to catch that first load (that's what smatch
does in all these cases) that could eventually lead to an actual vuln.

Thanks
--
Gustavo
