Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBB720652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBB720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935986AbeFRJvN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:51:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbeFRIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 637D8C7A;
        Mon, 18 Jun 2018 08:21:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gianluca Borello <g.borello@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 099/279] bpf, x64: fix JIT emission for dead code
Date:   Mon, 18 Jun 2018 10:11:24 +0200
Message-Id: <20180618080612.899041223@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gianluca Borello <g.borello@gmail.com>

[ Upstream commit 1612a981b76688c598dc944bbfbe29a2b33e3973 ]

Commit 2a5418a13fcf ("bpf: improve dead code sanitizing") replaced dead
code with a series of ja-1 instructions, for safety. That made JIT
compilation much more complex for some BPF programs. One instance of such
programs is, for example:

bool flag = false
...
/* A bunch of other code */
...
if (flag)
        do_something()

In some cases llvm is not able to remove at compile time the code for
do_something(), so the generated BPF program ends up with a large amount
of dead instructions. In one specific real life example, there are two
series of ~500 and ~1000 dead instructions in the program. When the
verifier replaces them with a series of ja-1 instructions, it causes an
interesting behavior at JIT time.

During the first pass, since all the instructions are estimated at 64
bytes, the ja-1 instructions end up being translated as 5 bytes JMP
instructions (0xE9), since the jump offsets become increasingly large (>
127) as each instruction gets discovered to be 5 bytes instead of the
estimated 64.

Starting from the second pass, the first N instructions of the ja-1
sequence get translated into 2 bytes JMPs (0xEB) because the jump offsets
become <= 127 this time. In particular, N is defined as roughly 127 / (5
- 2) ~= 42. So, each further pass will make the subsequent N JMP
instructions shrink from 5 to 2 bytes, making the image shrink every time.
This means that in order to have the entire program converge, there need
to be, in the real example above, at least ~1000 / 42 ~= 24 passes just
for translating the dead code. If we add this number to the passes needed
to translate the other non dead code, it brings such program to 40+
passes, and JIT doesn't complete. Ultimately the userspace loader fails
because such BPF program was supposed to be part of a prog array owner
being JITed.

While it is certainly possible to try to refactor such programs to help
the compiler remove dead code, the behavior is not really intuitive and it
puts further burden on the BPF developer who is not expecting such
behavior. To make things worse, such programs are working just fine in all
the kernel releases prior to the ja-1 fix.

A possible approach to mitigate this behavior consists into noticing that
for ja-1 instructions we don't really need to rely on the estimated size
of the previous and current instructions, we know that a -1 BPF jump
offset can be safely translated into a 0xEB instruction with a jump offset
of -2.

Such fix brings the BPF program in the previous example to complete again
in ~9 passes.

Fixes: 2a5418a13fcf ("bpf: improve dead code sanitizing")
Signed-off-by: Gianluca Borello <g.borello@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/net/bpf_jit_comp.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -992,7 +992,17 @@ emit_cond_jmp:		/* convert BPF opcode to
 			break;
 
 		case BPF_JMP | BPF_JA:
-			jmp_offset = addrs[i + insn->off] - addrs[i];
+			if (insn->off == -1)
+				/* -1 jmp instructions will always jump
+				 * backwards two bytes. Explicitly handling
+				 * this case avoids wasting too many passes
+				 * when there are long sequences of replaced
+				 * dead code.
+				 */
+				jmp_offset = -2;
+			else
+				jmp_offset = addrs[i + insn->off] - addrs[i];
+
 			if (!jmp_offset)
 				/* optimize out nop jumps */
 				break;


