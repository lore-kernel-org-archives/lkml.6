Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB37C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BDE217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="vEsKzOIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfBDRtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:49:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36504 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfBDRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:49:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so260315pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2A6x174oxI1IgjF5yxplIhVYlOCz6dxbQ/HwjJADVZw=;
        b=vEsKzOIaAMi+H2u4pE7522ta/Tc5WruP+jIZ1MljviL39vb7jLg+EWAgsPJBpsPboe
         iMwVm1ACABfqR8ZIPOsw5To/w9qiI/q+rTWFzcoftZmLATWuz/M99oQpxgzmgxS6BbUx
         UWosBgdLO0iixiGPDe5PZjlSmuuwRSN3DRs6XSHKaiDcvXVyWVjbPn0bBJv+8D58YGql
         0YKbTG/zDpGuobqWUP/TCSUehf+1zLLw8nddBehIlgob/I4TCtjv3a5LckirsI2FDk0L
         4Ct2O4DbbyEgRxQHm4dv83w1cCx67yvNhP8fy/WRnv2FuCKHI8V4uasyOiud4SFLvt2g
         vMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2A6x174oxI1IgjF5yxplIhVYlOCz6dxbQ/HwjJADVZw=;
        b=jG3rm8fjy4dir0kw5vggicW/J/00O2WQZybVllgOgTQhqQAmaZisxNymm6it6QbSv3
         N58CRf9Op+0Jk5bpCc+ps7rLviHxeDgjiw7z/K0OgO8IFPJxNfxzAqcIKswlhvPK8lQB
         3egsMhNroCQNRAWIsYEhlZwa2xy9QUnPfJm5VXWsEq0mZ+rQqvoAZPl8yFR9aDFjMeQX
         5ttYEoChvyGSWOtiLxaw4eN8CaimeeM6K7nfeySG7Q9Xxl3PrmHrifCEkQaa9uxVaJ92
         TjfYltWk0t511Xfb1JrDZyQreXXfUpD6ojhAEKi6jz2vMyCVNwObeyqCDYgNdRYHpz0s
         aC3w==
X-Gm-Message-State: AHQUAubtBJ2/SrtYiNdyJQQEBHBfHzQbOweBf1da2jG84OMd+ORlk/v4
        fxRGN2g2i91BUZipOt978/6k8w==
X-Google-Smtp-Source: AHgI3IaPMY9nH1FCWeKpGupYPVuzdhT3KIi0uzpL+uqDF4hDkKbk1b4oB/gD/Oxhra7W0bsbfyaIaA==
X-Received: by 2002:a63:df50:: with SMTP id h16mr469184pgj.421.1549302538896;
        Mon, 04 Feb 2019 09:48:58 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d25sm1124853pfe.40.2019.02.04.09.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:48:58 -0800 (PST)
Date:   Mon, 4 Feb 2019 09:48:56 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, songliubraving@fb.com,
        yhs@fb.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: bpf: BPF_PROG_TEST_RUN leads to unkillable process
Message-ID: <20190204174856.GA10769@mini-arch>
References: <CACT4Y+aUy-3F43ECZACEps4c3GcbqCne9XFV8q7G8Dm8afn6kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aUy-3F43ECZACEps4c3GcbqCne9XFV8q7G8Dm8afn6kA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Dmitry Vyukov wrote:
> Hello,
> 
> The following program leads to an unkillable process that eats CPU in
> an infinite loop in BPF_PROG_TEST_RUN syscall. But kernel does not
> self-detect cpu/rcu/task stalls either. The program contains max
> number of repetitions, but as far as I see the intention is that it
> should be killable. I see that bpf_test_run() checks for
> signal_pending(current), but it does so only if need_resched() is also
> set. Can need_resched() be not set for prolonged periods of time?
> /proc/pid/stack is empty, not sure what other info I can provide.
There is a bunch of places in the kernel where we do the same nested check:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/broadcom/tg3.c#n12059
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/hw_random/s390-trng.c#n80
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c#n1049
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/crypto/prng.c#n470

So it's not something unusual we do. OTOH, in the kernel/bpf/verifier.c
do_check() we do signal_pending() and need_resched() sequentially. In
theory, it should not hurt to do them in sequence. Any thoughts about
the patch below? I think we also need to properly return -ERESTARTSYS
when returning from signal_pending().

-- 

From ce360c909ce4f3caf8eb69f2ad5ce0d3eee1515d Mon Sep 17 00:00:00 2001
Message-Id: <ce360c909ce4f3caf8eb69f2ad5ce0d3eee1515d.1549302207.git.sdf@google.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 4 Feb 2019 09:17:37 -0800
Subject: [PATCH bpf] bpf/test_run: properly handle signal_pending

Syzbot found out that running BPF_PROG_TEST_RUN with repeat=0xffffffff
makes process unkillable. Let's move signal_pending out of need_resched
and properly return -ERESTARTSYS to the userspace.

In the kernel/bpf/verifier.c do_check() we do:
	if (signal_pending())
		...
	if (need_resched())
		...

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fa2644d276ef..a891c60cf248 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -28,12 +28,13 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
 	return ret;
 }
 
-static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
-			u32 *time)
+static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
+			u32 *retval, u32 *time)
 {
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
 	enum bpf_cgroup_storage_type stype;
 	u64 time_start, time_spent = 0;
+	int ret = 0;
 	u32 i;
 
 	for_each_cgroup_storage_type(stype) {
@@ -50,10 +51,12 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
 		repeat = 1;
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		*ret = bpf_test_run_one(prog, ctx, storage);
+		*retval = bpf_test_run_one(prog, ctx, storage);
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 		if (need_resched()) {
-			if (signal_pending(current))
-				break;
 			time_spent += ktime_get_ns() - time_start;
 			cond_resched();
 			time_start = ktime_get_ns();
@@ -66,7 +69,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
 	for_each_cgroup_storage_type(stype)
 		bpf_cgroup_storage_free(storage[stype]);
 
-	return 0;
+	return ret;
 }
 
 static int bpf_test_finish(const union bpf_attr *kattr,

> 
> Tested is on upstream commit 4aa9fc2a435abe95a1e8d7f8c7b3d6356514b37a.
> Config is attached.
> 
> FTR, generated from the following syzkaller program:
> 
> r1 = bpf$PROG_LOAD(0x5, &(0x7f0000000080)={0x3, 0x3,
> &(0x7f0000001fd8)=@framed={{0xffffff85, 0x0, 0x0, 0x0, 0x13, 0x5}},
> &(0x7f0000000000)='\x00', 0x5, 0x487, &(0x7f000000cf3d)=""/195}, 0x48)
> bpf$BPF_PROG_TEST_RUN(0xa, &(0x7f0000000200)={r1, 0x0, 0xe, 0x0,
> &(0x7f0000000100)="8557147d6187677523fea28c88a8", 0x0,
> 0xfffffffffffffffe}, 0x28)
> 
> 
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> #define _GNU_SOURCE
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
> 
> int main(void)
> {
>   syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
>   long res = 0;
>   *(uint32_t*)0x20000080 = 3;
>   *(uint32_t*)0x20000084 = 3;
>   *(uint64_t*)0x20000088 = 0x20001fd8;
>   *(uint8_t*)0x20001fd8 = 0x85;
>   *(uint8_t*)0x20001fd9 = 0x44;
>   *(uint16_t*)0x20001fda = 0;
>   *(uint32_t*)0x20001fdc = 0x13;
>   *(uint8_t*)0x20001fe0 = 5;
>   *(uint8_t*)0x20001fe1 = 0;
>   *(uint16_t*)0x20001fe2 = 0;
>   *(uint32_t*)0x20001fe4 = 0;
>   *(uint8_t*)0x20001fe8 = 0x95;
>   *(uint8_t*)0x20001fe9 = 0;
>   *(uint16_t*)0x20001fea = 0;
>   *(uint32_t*)0x20001fec = 0;
>   *(uint64_t*)0x20000090 = 0x20000000;
>   memcpy((void*)0x20000000, "\000", 1);
>   *(uint32_t*)0x20000098 = 5;
>   *(uint32_t*)0x2000009c = 0x487;
>   *(uint64_t*)0x200000a0 = 0x2000cf3d;
>   *(uint32_t*)0x200000a8 = 0;
>   *(uint32_t*)0x200000ac = 0;
>   *(uint8_t*)0x200000b0 = 0;
>   *(uint8_t*)0x200000b1 = 0;
>   *(uint8_t*)0x200000b2 = 0;
>   *(uint8_t*)0x200000b3 = 0;
>   *(uint8_t*)0x200000b4 = 0;
>   *(uint8_t*)0x200000b5 = 0;
>   *(uint8_t*)0x200000b6 = 0;
>   *(uint8_t*)0x200000b7 = 0;
>   *(uint8_t*)0x200000b8 = 0;
>   *(uint8_t*)0x200000b9 = 0;
>   *(uint8_t*)0x200000ba = 0;
>   *(uint8_t*)0x200000bb = 0;
>   *(uint8_t*)0x200000bc = 0;
>   *(uint8_t*)0x200000bd = 0;
>   *(uint8_t*)0x200000be = 0;
>   *(uint8_t*)0x200000bf = 0;
>   *(uint32_t*)0x200000c0 = 0;
>   *(uint32_t*)0x200000c4 = 0;
>   int fd = syscall(__NR_bpf, 5, 0x20000080, 0x48);
>   *(uint32_t*)0x20000200 = fd;
>   *(uint32_t*)0x20000204 = 0;
>   *(uint32_t*)0x20000208 = 0xe;
>   *(uint32_t*)0x2000020c = 0;
>   *(uint64_t*)0x20000210 = 0x20000100;
>   memcpy((void*)0x20000100,
>          "\x85\x57\x14\x7d\x61\x87\x67\x75\x23\xfe\xa2\x8c\x88\xa8", 14);
>   *(uint64_t*)0x20000218 = 0;
>   *(uint32_t*)0x20000220 = 0xfffffffe;
>   *(uint32_t*)0x20000224 = 0;
>   syscall(__NR_bpf, 0xa, 0x20000200, 0x28);
>   return 0;
> }


