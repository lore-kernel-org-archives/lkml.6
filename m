Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45BFC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE4D205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE4D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeJWANZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:13:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbeJWANZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:13:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCBA08830E;
        Mon, 22 Oct 2018 15:54:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A8265DA65;
        Mon, 22 Oct 2018 15:54:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181020045933.GI32577@ZenIV.linux.org.uk>
References: <20181020045933.GI32577@ZenIV.linux.org.uk> <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk> <153999785247.866.991476712548092023.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] iov_iter: Renumber the ITER_* constants in uio.h
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15349.1540223657.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 22 Oct 2018 16:54:17 +0100
Message-ID: <15350.1540223657@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 22 Oct 2018 15:54:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> > Renumber the ITER_* constants in uio.h to be contiguous to make comparing
> > them more efficient in a switch-statement.
> 
> Are you sure that they *are* more efficient that way?  Some of those paths
> are fairly hot, so much that I would really like to see profiles before
> and after these changes (both this and the previous one).

Here's a test program for you and five different implementations of selecting
the appropriate algorithm to jump to (number corresponds to TEST macro setting
in attached test program):

 (0) If-chain with bit-AND conditions.

 (1) If-chain with integer-equals conditionals.

 (2) switch-statement.  gcc-8 optimises this to a jump table

 (3) Hand-coded asm version of (2) with every other CMP instruction removed
     and use of JC/JE pairs.

 (4) Further evolution of (4), with each JC+JE replaced with a JLE and the JE
     pushed out into the target of the first jump (ie. a jump tree).

Note that (3) and (4) represent what the gcc optimiser could be modified to do
if presented with a switch-statement on consecutive integers.

The load is the same in each case, separate out-of-line memcpy of the
chunksize parameter.  I've used huge buffers to try and mitigate the existence
of the CPU's data cache.  I've also added two more iterator types to see how
the time taken progresses as more iterator types have to be checked for.

The results are:

0-AND   N     min           max           sum             mean          stddev
iovec   16    344856555     345343574     5519068476      344941779     113853
kvec    16    344872418     346016079     5532563468      345785216     350294
bvec    16    344895021     346239692     5525132232      345320764     514280
pipe    16    344798475     345951321     5529161043      345572565     465066
discard 16    344899551     346153210     5530263989      345641499     503421
mapping 16    345746878     345944635     5533548707      345846794      49381

1-EQ    N     min           max           sum             mean          stddev
iovec   16    345072671     345723483     5523587218      345224201     144920
kvec    16    345161998     345379465     5523770227      345235639      65712
bvec    16    345112804     345348494     5523047648      345190478      57416
pipe    16    345039449     345309247     5523169492      345198093      63221
discard 16    345112452     345576187     5523058937      345191183     106849
mapping 16    345137738     345516823     5523691504      345230719      97269

2-SWITC N     min           max           sum             mean          stddev
iovec   16    345222242     345826345     5525558259      345347391     142656
kvec    16    345231273     345356290     5524828010      345301750      40323
bvec    16    345196219     345392770     5525109005      345319312      54971
pipe    16    345185882     345373837     5524409531      345275595      53113
discard 16    345212568     345592390     5525001888      345312618      90384
mapping 16    345299922     345387759     5525183520      345323970      22687

3-ASM   N     min           max           sum             mean          stddev
iovec   16    345722167     346285326     5533150786      345821924     133015
kvec    16    344753568     346628433     5526922278      345432642     552298
bvec    16    344818033     345895319     5523243780      345202736     405817
pipe    16    344895308     346153821     5523284721      345205295     445216
discard 16    344851487     346035258     5525122223      345320138     491117
mapping 16    344839034     345954366     5524715012      345294688     382539

4-ASM   N     min           max           sum             mean          stddev
iovec   16    344640450     346185543     5525393037      345337064     494363
kvec    16    345469543     345622113     5528670420      345541901      46475
bvec    16    345572503     345736350     5530531163      345658197      49622
pipe    16    345516577     345722855     5530182459      345636403      52755
discard 16    344735842     345900033     5525914972      345369685     466301
mapping 16    344711585     345673217     5522124834      345132802     438480

Apart from the N column, which is the number of samples, all the numbers are
in nanoseconds.
=======

So, doing:

	test-for-0, je, test 2, je, test 4, je, test 8, je ...

appears to be a bit faster than:

	test-for-0, je, cmp 1, je, cmp 2, je, ...

and both are faster than the jump-table gcc optimises a switch-statement to.

3-ASM and 4-ASM, however, appear to be a little bit faster than 0-AND - if
only gcc generated either of them for a switch-statement.  3-ASM does:

	cmp 1, jc, je, cmp 3, jc, je, cmp 5, jc, je, ...

and 4-ASM does:

	cmp 1, jle, cmp 3, jle, cmp 5, jle, ...

and then puts a je at the beginning of the target of each jle.

I'm also not certain how the CPU's branch cache affects this.

David
---
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/mman.h>

#define TEST		4
#define bufsize		(1ULL * 1024 * 1024 * 1024)
#define chunksize	(4 * 1024)
#define samples		(16)

#define noinline	__attribute__((noinline))
#define unlikely(x)	__builtin_expect(!!(x), 0)

struct iov_iter {
	int type;
	size_t iov_offset;
	size_t count;
	char *p;
};

noinline void iterate_iovec(const void *addr, size_t bytes, struct iov_iter *i)
{
	memcpy(i->p + i->iov_offset, addr, bytes);
}

noinline void iterate_kvec(const void *addr, size_t bytes, struct iov_iter *i)
{
	memcpy(i->p + i->iov_offset, addr, bytes);
}

noinline void iterate_bvec(const void *addr, size_t bytes, struct iov_iter *i)
{
	memcpy(i->p + i->iov_offset, addr, bytes);
}

noinline void iterate_pipe(const void *addr, size_t bytes, struct iov_iter *i)
{
	memcpy(i->p + i->iov_offset, addr, bytes);
}

noinline void iterate_discard(const void *addr, size_t bytes, struct iov_iter *i)
{
	memcpy(i->p + i->iov_offset, addr, bytes);
}

noinline void iterate_mapping(const void *addr, size_t bytes, struct iov_iter *i)
{
	memcpy(i->p + i->iov_offset, addr, bytes);
}

#if TEST == 0
enum iter_type {
	ITER_IOVEC = 0,
	ITER_KVEC = 2,
	ITER_BVEC = 4,
	ITER_PIPE = 8,
	ITER_DISCARD = 16,
	ITER_MAPPING = 32,
};

noinline void copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
	if (       unlikely(i->type & ITER_BVEC)) {	iterate_bvec(addr, bytes, i);
	} else if (unlikely(i->type & ITER_KVEC)) {	iterate_kvec(addr, bytes, i);
	} else if (unlikely(i->type & ITER_PIPE)) {	iterate_pipe(addr, bytes, i);
	} else if (unlikely(i->type & ITER_DISCARD)) {	iterate_discard(addr, bytes, i);
	} else if (unlikely(i->type & ITER_MAPPING)) {	iterate_mapping(addr, bytes, i);
	} else {
		iterate_iovec(addr, bytes, i);
	}

	i->iov_offset += bytes;
}

#elif TEST == 1
enum iter_type {
	ITER_IOVEC = 0,
	ITER_KVEC = 1,
	ITER_BVEC = 2,
	ITER_PIPE = 3,
	ITER_DISCARD = 4,
	ITER_MAPPING = 5,
};

noinline void copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
	if (       unlikely(i->type == ITER_IOVEC)) {	iterate_iovec(addr, bytes, i);
	} else if (unlikely(i->type == ITER_KVEC)) {	iterate_kvec(addr, bytes, i);
	} else if (unlikely(i->type == ITER_BVEC)) {	iterate_bvec(addr, bytes, i);
	} else if (unlikely(i->type == ITER_PIPE)) {	iterate_pipe(addr, bytes, i);
	} else if (unlikely(i->type == ITER_DISCARD)) {	iterate_discard(addr, bytes, i);
	} else if (unlikely(i->type == ITER_MAPPING)) {	iterate_mapping(addr, bytes, i);
	} else {
		printf("unknown iter %d\n", i->type);
		exit(2);
	}
	i->iov_offset += bytes;
}

#elif TEST == 2
enum iter_type {
	ITER_IOVEC = 0,
	ITER_KVEC = 1,
	ITER_BVEC = 2,
	ITER_PIPE = 3,
	ITER_DISCARD = 4,
	ITER_MAPPING = 5,
};

noinline void copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
	switch (i->type) {
	case ITER_IOVEC:	iterate_iovec(addr, bytes, i);	break;
	case ITER_BVEC:		iterate_bvec(addr, bytes, i);	break;
	case ITER_KVEC:		iterate_kvec(addr, bytes, i);	break;
	case ITER_PIPE:		iterate_pipe(addr, bytes, i);	break;
	case ITER_DISCARD:	iterate_discard(addr, bytes, i); break;
	case ITER_MAPPING:	iterate_mapping(addr, bytes, i); break;
	default:
		printf("unknown iter %d\n", i->type);
		exit(2);
	}
	i->iov_offset += bytes;
}

#elif TEST == 3
enum iter_type {
	ITER_IOVEC = 0,
	ITER_KVEC = 1,
	ITER_BVEC = 2,
	ITER_PIPE = 3,
	ITER_DISCARD = 4,
	ITER_MAPPING = 5,
};

extern void copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
asm(
	"copy_to_iter:				\n"
	"    push   %rbp			\n"
	"    mov    %rsi,%rbp			\n"
	"    push   %rbx			\n"
	"    mov    %rdx,%rbx			\n"
	"    sub    $0x8,%rsp			\n"
	"    mov    (%rdx),%esi			\n"
	"    cmp    $0x1,%esi			\n"
	"    jc     72f				\n"
	"    je     96f				\n"
	"    cmp    $0x3,%esi			\n"
	"    jc     112f			\n"
	"    je     128f			\n"
	"    cmp    $0x5,%esi			\n"
	"    jc     144f			\n"
	"    je     160f			\n"
	"    xor    %eax,%eax			\n"
	"    jmp    80f				\n"
	"72:					\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_iovec		\n"
	"80:					\n"
	"    add    %rbp,0x8(%rbx)		\n"
	"    add    $0x8,%rsp			\n"
	"    pop    %rbx			\n"
	"    pop    %rbp			\n"
	"    retq				\n"
	"    nopl   0x0(%rax,%rax,1)		\n"
	"96:					\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_kvec		\n"
	"   jmp    80b				\n"
	"112:					\n"
	"   mov    %rbp,%rsi			\n"
	"   callq  iterate_bvec			\n"
	"   jmp    80b				\n"
	"128:					\n"
	"   mov    %rbp,%rsi			\n"
	"   callq  iterate_pipe			\n"
	"   jmp    80b				\n"
	"144:					\n"
	"   mov    %rbp,%rsi			\n"
	"   callq  iterate_discard		\n"
	"   jmp    80b				\n"
	"160:					\n"
	"   mov    %rbp,%rsi			\n"
	"   callq  iterate_mapping		\n"
	"   jmp    80b				\n"
    );

#elif TEST == 4
enum iter_type {
	ITER_IOVEC = 0,
	ITER_KVEC = 1,
	ITER_BVEC = 2,
	ITER_PIPE = 3,
	ITER_DISCARD = 4,
	ITER_MAPPING = 5,
};

extern void copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
asm(
	"copy_to_iter:				\n"
	"    push   %rbp			\n"
	"    mov    %rsi,%rbp			\n"
	"    push   %rbx			\n"
	"    mov    %rdx,%rbx			\n"
	"    sub    $0x8,%rsp			\n"
	"    mov    (%rdx),%esi			\n"
	"    cmp    $0x1,%esi			\n"
	"    jle    72f				\n"
	"    cmp    $0x3,%esi			\n"
	"    jle    112f			\n"
	"    cmp    $0x5,%esi			\n"
	"    jle    144f			\n"
	"    xor    %eax,%eax			\n"
	"    jmp    80f				\n"
	"72:					\n"
	"    je     96f				\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_iovec		\n"
	"80:					\n"
	"    add    %rbp,0x8(%rbx)		\n"
	"    add    $0x8,%rsp			\n"
	"    pop    %rbx			\n"
	"    pop    %rbp			\n"
	"    retq				\n"
	"    nopl   0x0(%rax,%rax,1)		\n"
	"96:					\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_kvec		\n"
	"    jmp    80b				\n"
	"112:					\n"
	"    je     128f			\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_bvec		\n"
	"    jmp    80b				\n"
	"128:					\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_pipe		\n"
	"    jmp    80b				\n"
	"144:					\n"
	"    je     160f			\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_discard		\n"
	"    jmp    80b				\n"
	"160:					\n"
	"    mov    %rbp,%rsi			\n"
	"    callq  iterate_mapping		\n"
	"    jmp    80b				\n"
    );

#endif

int types[] = {
	ITER_IOVEC,
	ITER_KVEC,
	ITER_BVEC,
	ITER_PIPE,
	ITER_DISCARD,
	ITER_MAPPING,
	-1
};
char *type_names[] = {
	"iovec",
	"kvec",
	"bvec",
	"pipe",
	"discard",
	"mapping",
};

unsigned long long sample_buf[samples];

int main()
{
	unsigned long long tmp;
	struct timespec tv_1, tv_2;
	void *a, *b;
	int i, j, k;

	a = mmap(NULL, bufsize, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
	if (a == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}

	b = mmap(NULL, bufsize, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
	if (a == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}

	memset(a, 1, bufsize);
	memset(b, 1, bufsize);
	
	for (i = 0; types[i] != -1; i++) {
		for (j = 0; j < samples; j++) {
			struct iov_iter iter = {
				.type		= types[i],
				.p		= a,
				.iov_offset	= 0,
			};

			clock_gettime(CLOCK_THREAD_CPUTIME_ID, &tv_1);
			for (k = 0; k < bufsize / chunksize; k++)
				copy_to_iter(b + k * chunksize, chunksize, &iter);
			clock_gettime(CLOCK_THREAD_CPUTIME_ID, &tv_2);
			tmp = (tv_2.tv_sec - tv_1.tv_sec) * 1000ULL * 1000 * 1000;
			tmp += tv_2.tv_nsec - tv_1.tv_nsec;
			sample_buf[j] = tmp;
		}

		for (j = 0; j < samples; j++) {
			printf("%7s: %16llu\n", type_names[i], sample_buf[j]);
		}
	}


	return 0;
}
