Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CSPtIC6q53IYO7ge0lijNY7tsVfj1YeyUUZBvWUdmQLUT2Oft6xtHvs9Z0X1Px2OTz4EN
ARC-Seal: i=1; a=rsa-sha256; t=1522168417; cv=none;
        d=google.com; s=arc-20160816;
        b=ITMQzwzuv4bsMkpbsb3DJca1lwVHeV5pKkC80lqypF5CjFkcFaHbEkcSoEOsYB381e
         i+DuRqwkTvKMZZYymtRwALW+4AGI42hTY/JYEXO9PSNIA9azRdFeQloC4duaFkhU/+Mi
         lNXzQa0ojH+t5YgQ82wSxSiq1TQpRsrVKm91s5Btkro/A2yd0a3OUJfKR8Wmoyq33gvf
         bUPZJktI+XrnCD82N+3BgtVFtV483/PrpRuXzQPh4n/koMAm95J+jXFhmF9TRyflLKYO
         wKyjgq7DHr4/Y+yWs9gqGrnCmBsyfQDFCgRmF4LOPgNwojnIgIal+aqGWzpk1AveWWTn
         fjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AHbR7DGiPHs3cZncr5w1EbiFU6d5sJJvKh8Dp2H8l1U=;
        b=I7aMZWppGtLsq7LMYTagPm3s/FQ98mUuXMU8wCDnJnxaa0MHGUUPzFaFt6Ulh507Yg
         qSPoeqpzXqp6pfFp5XXnStFWHAY+ToFTVAxLOQdqVl5+dFgjz2HfVO23uLE7jGgx6KUS
         DA4+65Q0ywdFmGlXbluC3iDZLO1Dl4E0j3Li2p6nQy5mKExX3PXHHops2yGe38//B1Uh
         luMSRGKrjk9+WWxtDIvo1fly2UFw6Exv0hcJckmjWBznCO/HB3NgdaukW/PQ6fUmGYHK
         TVRi/SU464JOmZRYdZ4DTwjFJdFBzj4Ulk9qGSnNTVFdp7M8foxFuUnd59CT0imC9f2N
         jj+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prasad Sodagudi <psodagud@codeaurora.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chenbo Feng <fengc@google.com>,
	Richard Smith <richard-llvm@metafoo.co.uk>,
	Chandler Carruth <chandlerc@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.9 65/67] kbuild: disable clangs default use of -fmerge-all-constants
Date: Tue, 27 Mar 2018 18:27:57 +0200
Message-Id: <20180327162731.344277212@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109074327630438?=
X-GMAIL-MSGID: =?utf-8?q?1596109270979967920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 87e0d4f0f37fb0c8c4aeeac46fff5e957738df79 upstream.

Prasad reported that he has seen crashes in BPF subsystem with netd
on Android with arm64 in the form of (note, the taint is unrelated):

  [ 4134.721483] Unable to handle kernel paging request at virtual address 800000001
  [ 4134.820925] Mem abort info:
  [ 4134.901283]   Exception class = DABT (current EL), IL = 32 bits
  [ 4135.016736]   SET = 0, FnV = 0
  [ 4135.119820]   EA = 0, S1PTW = 0
  [ 4135.201431] Data abort info:
  [ 4135.301388]   ISV = 0, ISS = 0x00000021
  [ 4135.359599]   CM = 0, WnR = 0
  [ 4135.470873] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffe39b946000
  [ 4135.499757] [0000000800000001] *pgd=0000000000000000, *pud=0000000000000000
  [ 4135.660725] Internal error: Oops: 96000021 [#1] PREEMPT SMP
  [ 4135.674610] Modules linked in:
  [ 4135.682883] CPU: 5 PID: 1260 Comm: netd Tainted: G S      W       4.14.19+ #1
  [ 4135.716188] task: ffffffe39f4aa380 task.stack: ffffff801d4e0000
  [ 4135.731599] PC is at bpf_prog_add+0x20/0x68
  [ 4135.741746] LR is at bpf_prog_inc+0x20/0x2c
  [ 4135.751788] pc : [<ffffff94ab7ad584>] lr : [<ffffff94ab7ad638>] pstate: 60400145
  [ 4135.769062] sp : ffffff801d4e3ce0
  [...]
  [ 4136.258315] Process netd (pid: 1260, stack limit = 0xffffff801d4e0000)
  [ 4136.273746] Call trace:
  [...]
  [ 4136.442494] 3ca0: ffffff94ab7ad584 0000000060400145 ffffffe3a01bf8f8 0000000000000006
  [ 4136.460936] 3cc0: 0000008000000000 ffffff94ab844204 ffffff801d4e3cf0 ffffff94ab7ad584
  [ 4136.479241] [<ffffff94ab7ad584>] bpf_prog_add+0x20/0x68
  [ 4136.491767] [<ffffff94ab7ad638>] bpf_prog_inc+0x20/0x2c
  [ 4136.504536] [<ffffff94ab7b5d08>] bpf_obj_get_user+0x204/0x22c
  [ 4136.518746] [<ffffff94ab7ade68>] SyS_bpf+0x5a8/0x1a88

Android's netd was basically pinning the uid cookie BPF map in BPF
fs (/sys/fs/bpf/traffic_cookie_uid_map) and later on retrieving it
again resulting in above panic. Issue is that the map was wrongly
identified as a prog! Above kernel was compiled with clang 4.0,
and it turns out that clang decided to merge the bpf_prog_iops and
bpf_map_iops into a single memory location, such that the two i_ops
could then not be distinguished anymore.

Reason for this miscompilation is that clang has the more aggressive
-fmerge-all-constants enabled by default. In fact, clang source code
has a comment about it in lib/AST/ExprConstant.cpp on why it is okay
to do so:

  Pointers with different bases cannot represent the same object.
  (Note that clang defaults to -fmerge-all-constants, which can
  lead to inconsistent results for comparisons involving the address
  of a constant; this generally doesn't matter in practice.)

The issue never appeared with gcc however, since gcc does not enable
-fmerge-all-constants by default and even *explicitly* states in
it's option description that using this flag results in non-conforming
behavior, quote from man gcc:

  Languages like C or C++ require each variable, including multiple
  instances of the same variable in recursive calls, to have distinct
  locations, so using this option results in non-conforming behavior.

There are also various clang bug reports open on that matter [1],
where clang developers acknowledge the non-conforming behavior,
and refer to disabling it with -fno-merge-all-constants. But even
if this gets fixed in clang today, there are already users out there
that triggered this. Thus, fix this issue by explicitly adding
-fno-merge-all-constants to the kernel's Makefile to generically
disable this optimization, since potentially other places in the
kernel could subtly break as well.

Note, there is also a flag called -fmerge-constants (not supported
by clang), which is more conservative and only applies to strings
and it's enabled in gcc's -O/-O2/-O3/-Os optimization levels. In
gcc's code, the two flags -fmerge-{all-,}constants share the same
variable internally, so when disabling it via -fno-merge-all-constants,
then we really don't merge any const data (e.g. strings), and text
size increases with gcc (14,927,214 -> 14,942,646 for vmlinux.o).

  $ gcc -fverbose-asm -O2 foo.c -S -o foo.S
    -> foo.S lists -fmerge-constants under options enabled
  $ gcc -fverbose-asm -O2 -fno-merge-all-constants foo.c -S -o foo.S
    -> foo.S doesn't list -fmerge-constants under options enabled
  $ gcc -fverbose-asm -O2 -fno-merge-all-constants -fmerge-constants foo.c -S -o foo.S
    -> foo.S lists -fmerge-constants under options enabled

Thus, as a workaround we need to set both -fno-merge-all-constants
*and* -fmerge-constants in the Makefile in order for text size to
stay as is.

  [1] https://bugs.llvm.org/show_bug.cgi?id=18538

Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Richard Smith <richard-llvm@metafoo.co.uk>
Cc: Chandler Carruth <chandlerc@gmail.com>
Cc: linux-kernel@vger.kernel.org
Tested-by: Prasad Sodagudi <psodagud@codeaurora.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -790,6 +790,15 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 
+# clang sets -fmerge-all-constants by default as optimization, but this
+# is non-conforming behavior for C and in fact breaks the kernel, so we
+# need to disable it here generally.
+KBUILD_CFLAGS	+= $(call cc-option,-fno-merge-all-constants)
+
+# for gcc -fno-merge-all-constants disables everything, but it is fine
+# to have actual conforming behavior enabled.
+KBUILD_CFLAGS	+= $(call cc-option,-fmerge-constants)
+
 # Make sure -fstack-check isn't enabled (like gentoo apparently did)
 KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
 
