Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DD2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F6220665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F6220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeJWVoJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:44:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2AC088318;
        Tue, 23 Oct 2018 13:20:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A75260191;
        Tue, 23 Oct 2018 13:20:40 +0000 (UTC)
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
Content-ID: <31389.1540300839.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 23 Oct 2018 14:20:39 +0100
Message-ID: <31390.1540300839@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 23 Oct 2018 13:20:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Sat, Oct 20, 2018 at 02:10:52AM +0100, David Howells wrote:
> > Renumber the ITER_* constants in uio.h to be contiguous to make comparing
> > them more efficient in a switch-statement.
> 
> Are you sure that they *are* more efficient that way?  Some of those paths
> are fairly hot, so much that I would really like to see profiles before
> and after these changes (both this and the previous one).

I updated my test program to try and overcome the effects of branch prediction
by going forwards through the set of iterator types and then back again inside
the inner loop rather than putting it on the outside.

I also made it run all the tests itself, do the stats calculations itself on
the output and only output at the end.

Firstly, with 32MiB bufsize to cause the dcache to be fully cycled (values are
times in nanoseconds, lower is better):

TEST           TOTAL       LOWEST      HIGHEST         MEAN       STDDEV
  0-AND  86690784677     10743312     11185591     10836348        36292
   1-EQ  86718137278     10743467     11189117     10839767        34984
2-SWITC  86716408086     10724792     11278450     10839551        35031
  3-ASM  86755866820     10742027     11214087     10844483        33932
  4-ASM  86587355807     10728937     11291730     10823419        34628
5-SW-BT  86532876718     10725349     11303746     10816609        31168

And, secondly, with 1MiB bufsize to keep the data fully within the dcache:

TEST           TOTAL       LOWEST      HIGHEST         MEAN       STDDEV
  0-AND    665992395        81216       136894        83249         2598
   1-EQ    665442229        81146       102292        83180         1767
2-SWITC    665263828        81133       103332        83157         1819
  3-ASM    667402344        81525       119804        83425         2251
  4-ASM    664493028        81178       104506        83061         2230
5-SW-BT    665792835        81378       115603        83224         2145

Each test was run 8000 times (samples parameter).  The differences appear to
be around .1% and are quite variable, presumably because of interrupts.

Interestingly, if I comment out all the memcpy calls and set iter.type to 5, I
get something that looks like:

TEST           TOTAL       LOWEST      HIGHEST         MEAN       STDDEV
  0-AND   5091749489       569535       925088       636468        13459
   1-EQ   4565513562       569496       620423       570689         3138
2-SWITC   4126907116       498480       650886       515863        10394
  3-ASM   9126139444      1137597      1177709      1140767         5006
  4-ASM   7411945298       924526      1123532       926493         4301
5-SW-BT   5135087754       640499       679302       641885         3217

This is a pretty consistent picture over all runs.  The numbers are larger
than for the 1MiB buffer size because it's doing 32x as many chunks, even
those chunks aren't actually being copied.  Reducing bufsize to 1MiB:

TEST           TOTAL       LOWEST      HIGHEST         MEAN       STDDEV
  0-AND    176123187        19299        54659        22015         2837
   1-EQ    153711816        19123        36712        19213          810
2-SWITC    140564024        16917        32145        17570          947
  3-ASM    296678820        36948        54856        37084         1113
  4-ASM    242791274        30210        49183        30348         1188
5-SW-BT    171511145        21351        35625        21438          765

3-ASM sticks out like a sore thumb, presumably because of the adjacent jumps.
Letting gcc optimise a switch-statement with sequentially numbered cases seems
to be optimal.

David
---
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <limits.h>
#include <math.h>
#include <sys/mman.h>

/* Adjustable parameters */
#define bufsize		(32ULL * 1024 * 1024)
#define chunksize	(1 * 128)
#define samples		(8000)


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

enum b_iter_type {
	B_ITER_IOVEC = 0,
	B_ITER_KVEC = 2,
	B_ITER_BVEC = 4,
	B_ITER_PIPE = 8,
	B_ITER_DISCARD = 16,
	B_ITER_MAPPING = 32,
};

enum s_iter_type {
	S_ITER_IOVEC = 0,
	S_ITER_KVEC = 1,
	S_ITER_BVEC = 2,
	S_ITER_PIPE = 3,
	S_ITER_DISCARD = 4,
	S_ITER_MAPPING = 5,
};

/*
 * 0-AND: Use bitwise-AND if-chain tests
 */
noinline void TEST0_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
	if (     unlikely(i->type & B_ITER_BVEC))	iterate_bvec(addr, bytes, i);
	else if (unlikely(i->type & B_ITER_KVEC))	iterate_kvec(addr, bytes, i);
	else if (unlikely(i->type & B_ITER_PIPE))	iterate_pipe(addr, bytes, i);
	else if (unlikely(i->type & B_ITER_DISCARD))	iterate_discard(addr, bytes, i);
	else if (unlikely(i->type & B_ITER_MAPPING))	iterate_mapping(addr, bytes, i);
	else						iterate_iovec(addr, bytes, i);

	i->iov_offset += bytes;
}

/*
 * 1-EQ: Use integer-equals if-chain tests on sequential integers
 */
noinline void TEST1_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
	if (     unlikely(i->type == S_ITER_IOVEC))	iterate_iovec(addr, bytes, i);
	else if (unlikely(i->type == S_ITER_KVEC))	iterate_kvec(addr, bytes, i);
	else if (unlikely(i->type == S_ITER_BVEC))	iterate_bvec(addr, bytes, i);
	else if (unlikely(i->type == S_ITER_PIPE))	iterate_pipe(addr, bytes, i);
	else if (unlikely(i->type == S_ITER_DISCARD))	iterate_discard(addr, bytes, i);
	else if (unlikely(i->type == S_ITER_MAPPING))	iterate_mapping(addr, bytes, i);
	else {
		printf("unknown iter %d\n", i->type);
		exit(2);
	}
	i->iov_offset += bytes;
}

/*
 * 2-SWITC: Use switch with sequential integers
 */
noinline void TEST2_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
	switch (i->type) {
	case S_ITER_IOVEC:	iterate_iovec(addr, bytes, i);	break;
	case S_ITER_BVEC:	iterate_bvec(addr, bytes, i);	break;
	case S_ITER_KVEC:	iterate_kvec(addr, bytes, i);	break;
	case S_ITER_PIPE:	iterate_pipe(addr, bytes, i);	break;
	case S_ITER_DISCARD:	iterate_discard(addr, bytes, i); break;
	case S_ITER_MAPPING:	iterate_mapping(addr, bytes, i); break;
	default:
		printf("unknown iter %d\n", i->type);
		exit(2);
	}
	i->iov_offset += bytes;
}

/*
 * 3-ASM: Like 1-EQ, but hand-optimised to remove half the CMP instructions.
 */
extern void TEST3_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
asm(
	"TEST3_copy_to_iter:			\n"
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

/*
 * 4-ASM: Like 3-ASM, but further optimised to move some of the jumps out to
 * branches.
 */
extern void TEST4_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
asm(
	"TEST4_copy_to_iter:			\n"
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

/*
 * 5-SW-BIT: Like 1-SWITC, but using the bitwise-optimised constants used
 * by 0-AND.
 */
noinline void TEST5_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
	switch (i->type) {
	case B_ITER_IOVEC:	iterate_iovec(addr, bytes, i);	break;
	case B_ITER_BVEC:	iterate_bvec(addr, bytes, i);	break;
	case B_ITER_KVEC:	iterate_kvec(addr, bytes, i);	break;
	case B_ITER_PIPE:	iterate_pipe(addr, bytes, i);	break;
	case B_ITER_DISCARD:	iterate_discard(addr, bytes, i); break;
	case B_ITER_MAPPING:	iterate_mapping(addr, bytes, i); break;
	default:
		printf("unknown iter %d\n", i->type);
		exit(2);
	}
	i->iov_offset += bytes;
}

#define nr_tests 6

const char *const test_names[nr_tests] = {
	"0-AND",
	"1-EQ",
	"2-SWITC",
	"3-ASM",
	"4-ASM",
	"5-SW-BT",
};

const int b_types[] = {
	B_ITER_IOVEC,
	B_ITER_KVEC,
	B_ITER_BVEC,
	B_ITER_PIPE,
	B_ITER_DISCARD,
	B_ITER_MAPPING,
	-1
};

const int s_types[] = {
	S_ITER_IOVEC,
	S_ITER_KVEC,
	S_ITER_BVEC,
	S_ITER_PIPE,
	S_ITER_DISCARD,
	S_ITER_MAPPING,
	-1
};

unsigned long long sample_buf[nr_tests][samples];

static __always_inline void test(unsigned int test, void *a, void *b)
{
	unsigned long long tmp;
	struct timespec tv_1, tv_2;
	int i = 0, j, k;

	for (j = 0; j < samples; j++) {
		struct iov_iter iter = {
			.p		= a,
			.iov_offset	= 0,
		};

		clock_gettime(CLOCK_THREAD_CPUTIME_ID, &tv_1);
		for (k = 0; k < bufsize / chunksize; k++) {
			const int *types;
			void *p;
			int x;

			switch (test) {
			case 0: types = b_types; break;
			case 1: types = s_types; break;
			case 2: types = s_types; break;
			case 3: types = s_types; break;
			case 4: types = s_types; break;
			case 5: types = b_types; break;
			default: types = NULL; break;
			}

			/* For 6 tests, do 0 1 2 3 4 5 5 4 3 2 1 0 */
			x = i++ % (nr_tests * 2);
			if (x >= nr_tests)
				x = nr_tests * 2 - 1 - x;
			iter.type = types[x];

			p = b + k * chunksize;
			switch (test) {
			case 0: TEST0_copy_to_iter(p, chunksize, &iter); break;
			case 1: TEST1_copy_to_iter(p, chunksize, &iter); break;
			case 2: TEST2_copy_to_iter(p, chunksize, &iter); break;
			case 3: TEST3_copy_to_iter(p, chunksize, &iter); break;
			case 4: TEST4_copy_to_iter(p, chunksize, &iter); break;
			case 5: TEST5_copy_to_iter(p, chunksize, &iter); break;
			}
		}

		clock_gettime(CLOCK_THREAD_CPUTIME_ID, &tv_2);
		tmp = (tv_2.tv_sec - tv_1.tv_sec) * 1000ULL * 1000 * 1000;
		tmp += tv_2.tv_nsec - tv_1.tv_nsec;
		sample_buf[test][j] = tmp;
	}
}

static noinline void test_0(void *a, void *b) { test(0, a, b); }
static noinline void test_1(void *a, void *b) { test(1, a, b); }
static noinline void test_2(void *a, void *b) { test(2, a, b); }
static noinline void test_3(void *a, void *b) { test(3, a, b); }
static noinline void test_4(void *a, void *b) { test(4, a, b); }
static noinline void test_5(void *a, void *b) { test(5, a, b); }

int main()
{
	void *a, *b;
	int i, j;

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

	test_0(a, b);
	test_1(a, b);
	test_2(a, b);
	test_3(a, b);
	test_4(a, b);
	test_5(a, b);

	for (i = 0; i < nr_tests; i++) {
		for (j = 0; j < samples; j++) {
			printf("sample,%s,%llu\n", test_names[i], sample_buf[i][j]);
		}
	}

	printf("\n");
	printf("TEST           TOTAL       LOWEST      HIGHEST         MEAN       STDDEV\n");

	for (i = 0; i < nr_tests; i++) {
		long long lowest = ULLONG_MAX, highest = 0;;
		long long total = 0, mean;
		double stddev;

		for (j = 0; j < samples; j++) {
			total += sample_buf[i][j];
			if (sample_buf[i][j] < lowest)
				lowest = sample_buf[i][j];
			if (sample_buf[i][j] > highest)
				highest = sample_buf[i][j];
		}
		mean = total / samples;

		stddev = 0;
		for (j = 0; j < samples; j++) {
			long long x = sample_buf[i][j];
			x -= mean;
			stddev += (double)x * (double)x;
		}

		stddev /= (samples - 1);
		stddev = sqrt(stddev);

		printf("%7s %12llu %12llu %12llu %12llu %12llu\n",
		       test_names[i], total, lowest, highest, mean,
		       (unsigned long long)stddev);
	}

	return 0;
}
