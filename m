Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeEOPnn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:43:43 -0400
Received: from foss.arm.com ([217.140.101.70]:34608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752779AbeEOPni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:43:38 -0400
Date: Tue, 15 May 2018 16:43:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515154333.bszh4nuowhocozuc@lakrids.cambridge.arm.com>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180515083556.GA30420@gmail.com>
 <20180515114144.GX12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515114144.GX12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:41:44PM +0200, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 10:35:56AM +0200, Ingo Molnar wrote:
> > Which is just _half_ the linecount.
> 
> It also provides less. I do not believe smaller is better here. The
> line count really isn't the problem with this stuff.
> 
> The main pain point here is keeping the atomic, atomic64 and atomic_long
> crud consistent, typically we tend to forget about atomic_long because
> that lives in an entirely different header.
> 
> In any case, see:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/generated&id=e54c888b3b9d8f3ef57b1a9c4255a6371cb9977d
> 
> which generates the atomic/atomic64 bits but does not yet deal with
> atomic_long (I think I would've kept the 'header' thing in the
> normal .h file but whatever).
> 
> Once we have the atomic_long thing added, we should also have enough
> data to do function forwarding, and we should be able to start looking
> at the whole annotated stuff.
> 
> Now clearly Mark hasn't had time to further work on that. But consider a
> table like:
> 
> add(i,v)		RF
> sub(i,v)		RF
> inc(v)			RF
> dec(v)			RF
> or(i,v)			F
> and(i,v)		F
> andnot(i,v)		F
> xor(i,v)		F
> xchg(v,i)		X
> cmpxchg(v,i,j)		X
> try_cmpxchg(v,I,j)	XB
> 
> With the following proglet; that should contain enough to do full
> forwarding (seems I forgot to implement 'B').

I put together the following while trying to avoid bash magic (i.e the
arrays, and keeping the option of naming the params. My local copy of
dash seems happy with it.

I *think* the table can encode enough info to generate atomic-long.h,
atomic-instrumented.h, and the atomic.h ordering fallbacks. I'll need to
flesh out the table and check that we don't end up clashing with
some of the regular fallbacks.

Thanks,
Mark.

----
# name	meta	args...
#
# Where meta contains a string of:
# * B - bool: returns bool, fully ordered
# * V - void: returns void, fully ordered
# * I - int: returns base type, all orderings
# * R - return: returns base type, all orderings
# * F - fetch: returns base type, all orderings
# * T - try: returns bool, all orderings
#
# Where args contains list of type[:name], where type is:
# * v - pointer to atomic base type (atomic or atomic64)
# * i - base type (int or long)
# * I - pointer to base type (int or long)
#
add		VRF	i	v
sub		VRF	i	v
inc		VRF	v
dec		VRF	v
or		VF	i	v
and		VF	i	v
andnot		VF	i	v
xor		VF	i	v
xchg		I	v	i
cmpxchg		I	v	i:old	i:new
try_cmpxchg	T	v	I:old	i:new
add_and_test	B	i	v
sub_and_test	B	i	v
dec_and_test	B	v
inc_and_test	B	v
----


----
#!/bin/sh

gen_return_type() {
	local meta="$1"; shift
	local basetype="$1"; shift

	expr match "${meta}" "[V]" > /dev/null && printf "void"
	expr match "${meta}" "[BT]" > /dev/null && printf "bool"
	expr match "${meta}" "[IFR]" > /dev/null && printf "${basetype}"
}

gen_param()
{
	local basetype="$1"; shift
	local atomictype="$1"; shift
	local fmt="$1"; shift
	local name="${fmt#*:}"
	local type="${fmt%%:*}"

	[ "${type}" = "i" ] && type="${basetype} "
	[ "${type}" = "I" ] && type="${basetype} *"
	[ "${type}" = "v" ] && type="${atomictype} *"

	printf "%s%s" "${type}" "${name}"
}

gen_params()
{
	local basetype="$1"; shift
	local atomictype="$1"; shift

	while [ "$#" -gt 0 ]; do
		gen_param "${basetype}" "${atomictype}" "$1"
		[ "$#" -gt 1 ] && printf ", "
		shift;
	done
}

gen_proto_return_order_variant()
{
	local meta="$1"; shift;
	local name="$1"; shift
	local pfx="$1"; shift
	local basetype="$1"; shift

	gen_return_type "$meta" "${basetype}"

	printf " %s_%s(" "${pfx}" "${name}"
	gen_params "${basetype}" "${pfx}_t" $@
	printf ");\n"
}

gen_proto_return_order_variants()
{
	local meta="$1"; shift
	local name="$1"; shift
	gen_proto_return_order_variant "${meta}" "${name}" "$@"

	if expr match "${meta}" "[RFXC]" > /dev/null; then
		gen_proto_return_order_variant "${meta}" "${name}_acquire" "$@"
		gen_proto_return_order_variant "${meta}" "${name}_release" "$@"
		gen_proto_return_order_variant "${meta}" "${name}_relaxed" "$@"
	fi
}

gen_proto_variants()
{
	local meta="$1"; shift
	local name="$1"; shift

	[ "${meta}" = "R" ] && name="${name}_return"
	[ "${meta}" = "F" ] && name="fetch_${name}"

	gen_proto_return_order_variants "${meta}" "${name}" "$@"
}

gen_proto() {
	local meta="$1"; shift
	for m in $(echo "${meta}" | fold -w1); do
		gen_proto_variants "${m}" $@
	done
}

grep '^[a-z]' "$1" | while read name meta args; do

	gen_proto "${meta}" "${name}" "atomic" "int" ${args}

	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}

	gen_proto "${meta}" "${name}" "atomic_long" "long" ${args}

done
----
