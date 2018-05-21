Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeEUVqk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:46:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:39008 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeEUVqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:46:37 -0400
Subject: Re: [PATCH] bpf: prevent memory disambiguation attack
To: Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180521211743.1492305-1-ast@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <65f20b2e-d9d5-ca7d-6027-54a900893d6d@iogearbox.net>
Date: Mon, 21 May 2018 23:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180521211743.1492305-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 11:17 PM, Alexei Starovoitov wrote:
> Detect code patterns where malicious 'speculative store bypass' can be used
> and sanitize such patterns.
> 
>  39: (bf) r3 = r10
>  40: (07) r3 += -216
>  41: (79) r8 = *(u64 *)(r7 +0)   // slow read
>  42: (7a) *(u64 *)(r10 -72) = 0  // verifier inserts this instruction
>  43: (7b) *(u64 *)(r8 +0) = r3   // this store becomes slow due to r8
>  44: (79) r1 = *(u64 *)(r6 +0)   // cpu speculatively executes this load
>  45: (71) r2 = *(u8 *)(r1 +0)    // speculatively arbitrary 'load byte'
>                                  // is now sanitized
> 
> Above code after x86 JIT becomes:
>  e5: mov    %rbp,%rdx
>  e8: add    $0xffffffffffffff28,%rdx
>  ef: mov    0x0(%r13),%r14
>  f3: movq   $0x0,-0x48(%rbp)
>  fb: mov    %rdx,0x0(%r14)
>  ff: mov    0x0(%rbx),%rdi
> 103: movzbq 0x0(%rdi),%rsi
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

(No further action needed since already in Linus tree [1]. This went via the
 batch of x86 fixes on the speculative store buffer bypass from today [2].)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af86ca4e3088fe5eacf2f7e58c01fa68ca067672
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b78ce4a34b761c7fe13520de822984019ff1a8f
