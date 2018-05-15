Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeEOMNR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:13:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeEOMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:13:15 -0400
Date: Tue, 15 May 2018 14:13:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        will.deacon@arm.com, mark.rutland@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515121309.GL12235@hirez.programming.kicks-ass.net>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180515083556.GA30420@gmail.com>
 <20180515114144.GX12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515114144.GX12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:41:44PM +0200, Peter Zijlstra wrote:
> #!/bin/bash
> 
> gen_proto() {
> 	local cnt=0;
> 
> 	proto=$1; shift;
> 	ret=$1; shift;
> 	pfx=$1; shift;
> 	sfx=$1; shift;
> 
> 	echo -n "${ret} ";
> 
> 	name=${proto%(*};
> 	echo -n "${pfx}${name}${sfx}("
> 
> 	args=${proto#*\(};
> 	for arg in ${args//[,)]/ };
> 	do
> 		if [ $cnt -gt 0 ]
> 		then
> 			echo -n ", ";
> 		fi
> 		let cnt++;
> 		echo -n "${TYPES[$arg]} ${arg}"
> 	done
> 	echo ");"
> }
> 
> gen_proto_order() {
> 	gen_proto $1 $2 $3 $4
> 	gen_proto $1 $2 $3 $4_acquire
> 	gen_proto $1 $2 $3 $4_release
> 	gen_proto $1 $2 $3 $4_relaxed
> }
> 
> gen_void_protos() {
> 	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
> 	do
> 		gen_proto ${proto} "void" ${TYPES[pfx]} ""
> 	done
> }
> 
> gen_return_protos() {
> 	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
> 	do
> 		if [[ $meta =~ "R" ]]; then
> 			gen_proto_order ${proto} ${TYPES[i]} ${TYPES[pfx]} "_return"
> 		fi
> 	done
> }
> 
> gen_fetch_protos() {
> 	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
> 	do
> 		if [[ $meta =~ "F" ]]; then
> 			gen_proto_order ${proto} ${TYPES[i]} "${TYPES[pfx]}fetch_" ""
> 		fi
> 	done
> }
> 
> gen_exchange_protos() {
> 	grep -v -e "^$" -e "^#" atomic.tbl | while read proto meta;
> 	do
> 		if [[ $meta =~ "X" ]]; then

			ret=${TYPES[i]};
			if [[ $meta =~ "B" ]]; then
				ret="bool"
			fi
			gen_proto_order ${proto} ${ret} ${TYPES[pfx]} ""

> 		fi
> 	done
> }
> 
> gen_protos() {
> 	gen_void_protos
> 	gen_return_protos
> 	gen_fetch_protos
> 	gen_exchange_protos
> }
> 
> declare -A TYPES=( [pfx]="atomic_" [v]="atomic_t *" [i]="int" [j]="int" [I]="int *" )
> 
> gen_protos
> 
> declare -A TYPES=( [pfx]="atomic64_" [v]="atomic64_t *" [i]="s64" [j]="s64" [I]="s64 *" )
> 
> gen_protos
> 
> declare -A TYPES=( [pfx]="atomic_long_" [v]="atomic_long_t *" [i]="long" [j]="long" [I]="long *" )
> 
> gen_protos
> 
> 
