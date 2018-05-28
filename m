Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161637AbeE1Ohq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161390AbeE1Kbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:31:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Lord <mlord@pobox.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 127/329] powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access
Date: Mon, 28 May 2018 12:00:56 +0200
Message-Id: <20180528100253.229221434@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Lord <mlord@pobox.com>

[ Upstream commit 083b20907185b076f21c265b30fe5b5f24c03d8c ]

I am using SECCOMP to filter syscalls on a ppc32 platform, and noticed
that the JIT compiler was failing on the BPF even though the
interpreter was working fine.

The issue was that the compiler was missing one of the instructions
used by SECCOMP, so here is a patch to enable JIT for that
instruction.

Fixes: eb84bab0fb38 ("ppc: Kconfig: Enable BPF JIT on ppc32")
Signed-off-by: Mark Lord <mlord@pobox.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -329,6 +329,9 @@ static int bpf_jit_build_body(struct bpf
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
 			PPC_LWZ_OFFS(r_A, r_skb, offsetof(struct sk_buff, len));
 			break;
+		case BPF_LDX | BPF_W | BPF_ABS: /* A = *((u32 *)(seccomp_data + K)); */
+			PPC_LWZ_OFFS(r_A, r_skb, K);
+			break;
 		case BPF_LDX | BPF_W | BPF_LEN: /* X = skb->len; */
 			PPC_LWZ_OFFS(r_X, r_skb, offsetof(struct sk_buff, len));
 			break;
