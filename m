Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DDAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB17F20847
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB17F20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeH1Vsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:48:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727707AbeH1Vsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:48:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52DC0AD85;
        Tue, 28 Aug 2018 17:55:52 +0000 (UTC)
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
 <20180823141219.GA4766@kernel.org>
 <64684c59-492c-3310-a5d2-14b467602acc@suse.cz>
 <20180828141047.GG22309@kernel.org> <20180828141843.GH22309@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <e8c2fe77-600e-c0b1-8d14-d46982be9f51@suse.cz>
Date:   Tue, 28 Aug 2018 19:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828141843.GH22309@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 04:18 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 28, 2018 at 11:10:47AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Aug 27, 2018 at 11:06:21AM +0200, Martin Liška escreveu:
>>> On 08/23/2018 04:12 PM, Arnaldo Carvalho de Melo wrote:
>>>> Em Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška escreveu:
>>>>> The patch changes interpretation of:
>>>>> callq  *0x8(%rbx)
>>>>>
>>>>> from:
>>>>>    0.26 │     → callq  *8
>>>>> to:
>>>>>    0.26 │     → callq  *0x8(%rbx)
> 
> <SNIP>
> 
>>>> Please mention one or two functions where such sequence appears, so that
>>>> others can reproduce your before/after more quickly,
> 
>>> Sure, there's self-contained example on can compile (-O2) and test.
>>> It's following call in test function:
> 
>>> test:
>>> .LFB1:
>>>          .cfi_startproc
>>>          movq    %rdi, %rax
>>>          subq    $8, %rsp
>>>          .cfi_def_cfa_offset 16
>>>          movq    %rsi, %rdi
>>>          movq    %rdx, %rsi
>>>          call    *8(%rax) <---- here
>>>          cmpl    $1, %eax
>>>          adcl    $-1, %eax
>>>          addq    $8, %rsp
>>>          .cfi_def_cfa_offset 8
>>>          ret
>>>          .cfi_endproc
>>
>> Here I'm getting:
>>
>> Samples: 2K of event 'cycles:uppp', 4000 Hz, Event count (approx.): 1808551484
>> test  /home/acme/c/perf-callq [Percent: local period]
>>    0.17 │      mov    %rdx,-0x28(%rbp)
>>    0.58 │      mov    -0x18(%rbp),%rax
>>    7.90 │      mov    0x8(%rax),%rax
>>    8.67 │      mov    -0x28(%rbp),%rcx
>>         │      mov    -0x20(%rbp),%rdx
>>    0.08 │      mov    %rcx,%rsi
>>    6.28 │      mov    %rdx,%rdi
>>   10.50 │    → callq  *%rax
>>    1.67 │      mov    %eax,-0x4(%rbp)
>>   11.95 │      cmpl   $0x0,-0x4(%rbp)
>>    8.14 │    ↓ je     3d
>>         │      mov    -0x4(%rbp),%eax
>>         │      sub    $0x1,%eax
>>         │    ↓ jmp    42
>>         │3d:   mov    $0x0,%eax
>>    7.84 │42:   leaveq
>>         │    ← retq
>>
>> Without the patch, will check if something changes with it.

Hi Arnaldo.

Thanks for re-sending of the patch and for the testing. The example I sent
is dependent on version of GCC compiler.

> 
> No changes with the patch, but then I did another test, ran a system
> wide record for a while, then tested without/with your patch, with
> --stdio2 redirecting to /tmp/{before,after} and got the expected
> results, see below.
> 
> Thanks, applying,

Good!
Martin

> 
> - Arnaldo
> 
> --- /tmp/before 2018-08-28 11:16:03.238384143 -0300
> +++ /tmp/after  2018-08-28 11:15:39.335341042 -0300
> @@ -13274,7 +13274,7 @@
>                ↓ jle    128
>                  hash_value = hash_table->hash_func (key);
>                  mov    0x8(%rsp),%rdi
> -  0.91       → callq  *30
> +  0.91       → callq  *0x30(%r12)
>                  mov    $0x2,%r8d
>                  cmp    $0x2,%eax
>                  node_hash = hash_table->hashes[node_index];
> @@ -13848,7 +13848,7 @@
>                   mov    %r14,%rdi
>                   sub    %rbx,%r13
>                   mov    %r13,%rdx
> -              → callq  *38
> +              → callq  *0x38(%r15)
>                   cmp    %rax,%r13
>     1.91        ↓ je     240
>            1b4:   mov    $0xffffffff,%r13d
> @@ -14026,7 +14026,7 @@
>                   mov    %rcx,-0x500(%rbp)
>                   mov    %r15,%rsi
>                   mov    %r14,%rdi
> -              → callq  *38
> +              → callq  *0x38(%rax)
>                   mov    -0x500(%rbp),%rcx
>                   cmp    %rax,%rcx
>                 ↓ jne    9b0
> <SNIP tons of other such cases>
> 

