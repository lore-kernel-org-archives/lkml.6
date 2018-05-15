Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeEOLlx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:41:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeEOLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:41:52 -0400
Date: Tue, 15 May 2018 13:41:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        will.deacon@arm.com, mark.rutland@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515114144.GX12217@hirez.programming.kicks-ass.net>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180515083556.GA30420@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515083556.GA30420@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 10:35:56AM +0200, Ingo Molnar wrote:
> Which is just _half_ the linecount.

It also provides less. I do not believe smaller is better here. The
line count really isn't the problem with this stuff.

The main pain point here is keeping the atomic, atomic64 and atomic_long
crud consistent, typically we tend to forget about atomic_long because
that lives in an entirely different header.

In any case, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/generated&id=e54c888b3b9d8f3ef57b1a9c4255a6371cb9977d

which generates the atomic/atomic64 bits but does not yet deal with
atomic_long (I think I would've kept the 'header' thing in the
normal .h file but whatever).

Once we have the atomic_long thing added, we should also have enough
data to do function forwarding, and we should be able to start looking
at the whole annotated stuff.

Now clearly Mark hasn't had time to further work on that. But consider a
table like:

add(i,v)		RF
sub(i,v)		RF
inc(v)			RF
dec(v)			RF
or(i,v)			F
and(i,v)		F
andnot(i,v)		F
xor(i,v)		F
xchg(v,i)		X
cmpxchg(v,i,j)		X
try_cmpxchg(v,I,j)	XB

With the following proglet; that should contain enough to do full
forwarding (seems I forgot to implement 'B').

---
#!/bin/bash

gen_proto() {
	local cnt=0;

	proto=$1; shift;
	ret=$1; shift;
	pfx=$1; shift;
	sfx=$1; shift;

	echo -n "${ret} ";

	name=${proto%(*};
	echo -n "${pfx}${name}${sfx}("

	args=${proto#*\(};
	for arg in ${args//[,)]/ };
	do
		if [ $cnt -gt 0 ]
		then
			echo -n ", ";
		fi
		let cnt++;
		echo -n "${TYPES[$arg]} ${arg}"
	done
	echo ");"
}

gen_proto_order() {
	gen_proto $1 $2 $3 $4
	gen_proto $1 $2 $3 $4_acquire
	gen_proto $1 $2 $3 $4_release
	gen_proto $1 $2 $3 $4_relaxed
}

gen_void_protos() {
	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
	do
		gen_proto ${proto} "void" ${TYPES[pfx]} ""
	done
}

gen_return_protos() {
	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
	do
		if [[ $meta =~ "R" ]]; then
			gen_proto_order ${proto} ${TYPES[i]} ${TYPES[pfx]} "_return"
		fi
	done
}

gen_fetch_protos() {
	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
	do
		if [[ $meta =~ "F" ]]; then
			gen_proto_order ${proto} ${TYPES[i]} "${TYPES[pfx]}fetch_" ""
		fi
	done
}

gen_exchange_protos() {
	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
	do
		if [[ $meta =~ "X" ]]; then
			gen_proto_order ${proto} ${TYPES[i]} ${TYPES[pfx]} ""
		fi
	done
}

gen_protos() {
	gen_void_protos
	gen_return_protos
	gen_fetch_protos
	gen_exchange_protos
}

declare -A TYPES=( [pfx]="atomic_" [v]="atomic_t *" [i]="int" [j]="int" [I]="int *" )

gen_protos

declare -A TYPES=( [pfx]="atomic64_" [v]="atomic64_t *" [i]="s64" [j]="s64" [I]="s64 *" )

gen_protos

declare -A TYPES=( [pfx]="atomic_long_" [v]="atomic_long_t *" [i]="long" [j]="long" [I]="long *" )

gen_protos
