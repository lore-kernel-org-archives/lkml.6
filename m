Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeDYNUK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:20:10 -0400
Received: from foss.arm.com ([217.140.101.70]:39742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752439AbeDYNUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:20:05 -0400
Date: Wed, 25 Apr 2018 14:19:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180425131958.hhapvc3b2i3b4pgy@lakrids.cambridge.arm.com>
References: <20180419051510.GA21898@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419051510.GA21898@mwanda>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Apr 19, 2018 at 08:15:10AM +0300, Dan Carpenter wrote:
> Several people have asked me to write this and I think one person was
> maybe working on writing it themselves...
> 
> The point of this check is to find place which might be vulnerable to
> the Spectre vulnerability.  In the kernel we have the array_index_nospec()
> macro which turns off speculation.  There are fewer than 10 places where
> it's used.  Meanwhile this check complains about 800 places where maybe
> it could be used.  Probably the 100x difference means there is something
> that I haven't understood...
> 
> What the test does is it looks at array accesses where the user controls
> the offset.  It asks "is this a read?" and have we used the
> array_index_nospec() macro?  If the answers are yes, and no respectively
> then print a warning.
> 
> http://repo.or.cz/smatch.git/blob/HEAD:/check_spectre.c
> 
> The other thing is that speculation probably goes to 200 instructions
> ahead at most.  But the Smatch doesn't have any concept of CPU
> instructions.  I've marked the offsets which were recently compared to
> something as "local cap" because they were probably compared to the
> array limit.  Those are maybe more likely to be under the 200 CPU
> instruction count.
> 
> This obviously a first draft.
> 
> What would help me, is maybe people could tell me why there are so many
> false positives.  Saying "the lower level checks for that" is not
> helpful but if you could tell me the exact function name where the check
> is that helps a lot...

Running this over an arm64 v4.17-rc2, I thought I'd found a
false-positive, but I've now convinced myself that we have a class of
false-negatives.

The short story is:

1) Compiler transformations mean that under speculation, a variable can
   behave as-if it is a larger type, e.g. an unsigned char can hold any
   value in the range 0..~0ULL. This full range can be used when
   performing an array access.

   This means that implicit narrowing cannot be relied upon under
   speculation; any variable may behave as-if it is an unsigned long
   long.

2) Compiler transformations can elide binary operations, so we cannot
   rely on source level AND (&) or MOD (%) operations to narrow the
   range of an expression, regardless of the types of either operand.

   This means that source-level AND and MOD operations cannot be relied
   upon under speculation.

3) MOD (%) operations may be implemented with branchy library code. Even
   where the compiler cannot elide a MOD, it can be effectively skipped
   under speculation.

   This means that source-level MOD operations cannot be relied upon
   under speculation, *even if we can make the inputs and outputs opaque
   to the compiler*.

I think this means that *any* expression, regardless of its type must be
considered as having the full range of the machine's word size, unless a
compiler-opaque bounding operation like array_index_nospec() has been
used to sanitize that expression.

For smatch, this means that the result of check_spectre.c's
get_may_by_type() may be misleading, and we may be throwing away valid
spectre gadgets.

I suspect this means *many* more potential spectre gadgets. :(

More details/examples below.


1: larger types under speculation
-----------------------------------------------------------------------

I don't believe that we can assume that (under speculation) sub-word
types are actually bounded by their type's size. The compiler can elide
narrowing where it (validly) believes a value is sufficiently small,
e.g. for code like:

int array[256];

static int foo(unsigned char idx)
{
        return array[idx];
}

int bar(unsigned long idx)
{
        if (idx < 256)
                return foo(idx);

        return 0;
}

... GCC will generate the following at -O2:

x86-64
----
0000000000000000 <bar>:
   0:   31 c0                   xor    %eax,%eax
   2:   48 81 ff ff 00 00 00    cmp    $0xff,%rdi
   9:   77 0d                   ja     18 <bar+0x18>
   b:   48 8d 05 00 00 00 00    lea    0x0(%rip),%rax        # 12 <bar+0x12>
  12:   48 63 ff                movslq %edi,%rdi
  15:   8b 04 b8                mov    (%rax,%rdi,4),%eax
  18:   f3 c3                   repz retq 

arm64
-----
0000000000000000 <bar>:
   0:   f103fc1f        cmp     x0, #0xff
   4:   540000a8        b.hi    18 <bar+0x18>  // b.pmore
   8:   90000001        adrp    x1, 400 <bar+0x400>
   c:   91000021        add     x1, x1, #0x0
  10:   b860d820        ldr     w0, [x1, w0, sxtw #2]
  14:   d65f03c0        ret
  18:   52800000        mov     w0, #0x0                        // #0
  1c:   d65f03c0        ret

After the test, GCC trusts that bits 31:8 of idx must be zero, though
for some reason doesn't trust bits 63:32, which seems like a missed
optimization given it requires a pointless movslq on x86-64.

Then GCC performs the array access with bits 31:0 of idx, so if the
bounds check we mis-predicted, we can access array[0x0...0xffffffff]
rather than array[0x0...0xff] as might be expected from the type of the
expression using idx to access the array in foo.


2: elision of binary operations (and associated narrowing)
-----------------------------------------------------------------------

Explicit AND binops can be elided:

int some_array[256];

static int foo(unsigned long a)
{
        unsigned char mask = 0xff;

        return some_array[a & mask];
}

int bar(unsigned long a)
{
        if (a < 256)
                return foo(a);

        return 0;
}

... where GCC -O2 gives us:

x86-64
------
0000000000000000 <bar>:
   0:   31 c0                   xor    %eax,%eax
   2:   48 81 ff ff 00 00 00    cmp    $0xff,%rdi
   9:   77 0a                   ja     15 <bar+0x15>
   b:   48 8d 05 00 00 00 00    lea    0x0(%rip),%rax        # 12 <bar+0x12>
  12:   8b 04 b8                mov    (%rax,%rdi,4),%eax
  15:   f3 c3                   repz retq 

arm64
-----
0000000000000000 <bar>:
   0:   f103fc1f        cmp     x0, #0xff
   4:   540000a8        b.hi    18 <bar+0x18>  // b.pmore
   8:   90000001        adrp    x1, 400 <bar+0x400>
   c:   91000021        add     x1, x1, #0x0
  10:   b8607820        ldr     w0, [x1, x0, lsl #2]
  14:   d65f03c0        ret
  18:   52800000        mov     w0, #0x0                        // #0
  1c:   d65f03c0        ret

... allowing access to array[0x0...0xffffffffffffffff] under
speculation, rather than array[0x0...0xff].

The same applies for MOD operations:

int some_array[256];

static int foo(unsigned long a)
{
        unsigned short mod = 256;
        a %= mod;

        return some_array[a];
}

int bar(unsigned long a)
{
        if (a < 256)
                return foo(a);

        return 0;
}

... where GCC -O2 gives us:

x86-64
------
0000000000000000 <bar>:
   0:   31 c0                   xor    %eax,%eax
   2:   48 81 ff ff 00 00 00    cmp    $0xff,%rdi
   9:   77 0a                   ja     15 <bar+0x15>
   b:   48 8d 05 00 00 00 00    lea    0x0(%rip),%rax        # 12 <bar+0x12>
  12:   8b 04 b8                mov    (%rax,%rdi,4),%eax
  15:   f3 c3                   repz retq 

arm64
-----
0000000000000000 <bar>:
   0:   f103fc1f        cmp     x0, #0xff
   4:   540000a8        b.hi    18 <bar+0x18>  // b.pmore
   8:   90000001        adrp    x1, 400 <bar+0x400>
   c:   91000021        add     x1, x1, #0x0
  10:   b8607820        ldr     w0, [x1, x0, lsl #2]
  14:   d65f03c0        ret
  18:   52800000        mov     w0, #0x0                        // #0
  1c:   d65f03c0        ret


... allowing access to array[0x0...0xffffffffffffffff] under
speculation, rather than array[0x0...0xffff] given that mod was 16-bit.


3: branchy MOD operations
-----------------------------------------------------------------------

On some machines, MOD might be a call to a (branchy) library function
(e.g. __aeabi_uidivmod on ARMv7 without sdiv), and iterative division
could terminate prematurely under speculation, leaving a remainder
larger than the RHS in a register. 

e.g. for code like:

extern int array[256];

int bounded_access(unsigned int idx, char bound)
{
        idx %= bound;
        return array[idx];
}

... GCC can generate the following at -O2:

arm
---
00000000 <bounded_access>:
   0:   b510            push    {r4, lr}
   2:   f240 0400       movw    r4, #0
   6:   f2c0 0400       movt    r4, #0
   a:   f7ff fffe       bl      0 <__aeabi_uidivmod>
   e:   f854 0021       ldr.w   r0, [r4, r1, lsl #2]
  12:   bd10            pop     {r4, pc}


... where under speculation __aeabi_uidivmod could return early, leaving
the remainder in r1 bigger than a char. Thus allowing access to
array[0x0...0xffffffff] under speculation rather than array[0x0..0xff].

Thanks,
Mark.
