Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EACBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA820675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbfAKPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:25:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfAKPZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:25:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB5FBC09942B;
        Fri, 11 Jan 2019 15:25:54 +0000 (UTC)
Received: from [10.36.117.137] (ovpn-117-137.ams2.redhat.com [10.36.117.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE7A41019638;
        Fri, 11 Jan 2019 15:25:52 +0000 (UTC)
Subject: Re: [PATCH v1] s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20190111141822.17262-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <3107a059-0117-fe29-05d6-4cba539a113d@redhat.com>
Date:   Fri, 11 Jan 2019 16:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190111141822.17262-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 11 Jan 2019 15:25:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.19 15:18, David Hildenbrand wrote:
> When calling smp_call_ipl_cpu() from the IPL CPU, we will try to read
> from pcpu_devices->lowcore. However, due to prefixing, that will result
> in reading from absolute address 0 on that CPU. We have to go via the
> actual lowcore instead.
> 
> This means that right now, we will read lc->nodat_stack == 0 and
> therfore work on a very wrong stack.
> 
> This BUG essentially broke rebooting under QEMU TCG (which will report
> a low address protection exception). And checking under KVM, it is
> also broken under KVM. With 1 VCPU it can be easily triggered.
> 
> :/# echo 1 > /proc/sys/kernel/sysrq
> :/# echo b > /proc/sysrq-trigger
> [   28.476745] sysrq: SysRq : Resetting
> [   28.476793] Kernel stack overflow.
> [   28.476817] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
> [   28.476820] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
> [   28.476826] Krnl PSW : 0400c00180000000 0000000000115c0c (pcpu_delegate+0x12c/0x140)
> [   28.476861]            R:0 T:1 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   28.476863] Krnl GPRS: ffffffffffffffff 0000000000000000 000000000010dff8 0000000000000000
> [   28.476864]            0000000000000000 0000000000000000 0000000000ab7090 000003e0006efbf0
> [   28.476864]            000000000010dff8 0000000000000000 0000000000000000 0000000000000000
> [   28.476865]            000000007fffc000 0000000000730408 000003e0006efc58 0000000000000000
> [   28.476887] Krnl Code: 0000000000115bfe: 4170f000            la      %r7,0(%r15)
> [   28.476887]            0000000000115c02: 41f0a000            la      %r15,0(%r10)
> [   28.476887]           #0000000000115c06: e370f0980024        stg     %r7,152(%r15)
> [   28.476887]           >0000000000115c0c: c0e5fffff86e        brasl   %r14,114ce8
> [   28.476887]            0000000000115c12: 41f07000            la      %r15,0(%r7)
> [   28.476887]            0000000000115c16: a7f4ffa8            brc     15,115b66
> [   28.476887]            0000000000115c1a: 0707                bcr     0,%r7
> [   28.476887]            0000000000115c1c: 0707                bcr     0,%r7
> [   28.476901] Call Trace:
> [   28.476902] Last Breaking-Event-Address:
> [   28.476920]  [<0000000000a01c4a>] arch_call_rest_init+0x22/0x80
> [   28.476927] Kernel panic - not syncing: Corrupt kernel stack, can't continue.
> [   28.476930] CPU: 0 PID: 424 Comm: sh Not tainted 5.0.0-rc1+ #13
> [   28.476932] Hardware name: IBM 2964 NE1 716 (KVM/Linux)
> [   28.476932] Call Trace:
> 

I guess this has been broken for a long time. Most probably
ce3dc447493f ("s390: add support for virtually mapped kernel stacks")
finally made it trigger the low address protection.

@@ -372,8 +382,7 @@ void smp_call_online_cpu(void (*func)(void *), void
*data)
 void smp_call_ipl_cpu(void (*func)(void *), void *data)
 {
        pcpu_delegate(&pcpu_devices[0], func, data,
-                     pcpu_devices->lowcore->panic_stack -
-                     PANIC_FRAME_OFFSET + PAGE_SIZE);
+                     pcpu_devices->lowcore->nodat_stack);
 }

The old "- PANIC_FRAME_OFFSET + PAGE_SIZE" Made sure that we were not
trying to write at absolute address 0, but instead something >= 512,
whereby low address protection would not trigger.


> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/smp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index f82b3d3c36e2..be32dd0b4191 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -381,8 +381,13 @@ void smp_call_online_cpu(void (*func)(void *), void *data)
>   */
>  void smp_call_ipl_cpu(void (*func)(void *), void *data)
>  {
> +	struct lowcore *lc = pcpu_devices->lowcore;
> +
> +	if (pcpu_devices[0].address == stap())
> +		lc = &S390_lowcore;
> +
>  	pcpu_delegate(&pcpu_devices[0], func, data,
> -		      pcpu_devices->lowcore->nodat_stack);
> +		      lc->nodat_stack);
>  }
>  
>  int smp_find_processor_id(u16 address)
> 


-- 

Thanks,

David / dhildenb
