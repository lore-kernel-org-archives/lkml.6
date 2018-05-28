Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033741AbeE1KXy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033712AbeE1KXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:23:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 185/268] powerpc/mpic: Check if cpu_possible() in mpic_physmask()
Date: Mon, 28 May 2018 12:02:39 +0200
Message-Id: <20180528100223.292347668@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 0834d627fbea00c1444075eb3e448e1974da452d ]

In mpic_physmask() we loop over all CPUs up to 32, then get the hard
SMP processor id of that CPU.

Currently that's possibly walking off the end of the paca array, but
in a future patch we will change the paca array to be an array of
pointers, and in that case we will get a NULL for missing CPUs and
oops. eg:

  Unable to handle kernel paging request for data at address 0x88888888888888b8
  Faulting instruction address: 0xc00000000004e380
  Oops: Kernel access of bad area, sig: 11 [#1]
  ...
  NIP .mpic_set_affinity+0x60/0x1a0
  LR  .irq_do_set_affinity+0x48/0x100

Fix it by checking the CPU is possible, this also fixes the code if
there are gaps in the CPU numbering which probably never happens on
mpic systems but who knows.

Debugged-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -626,7 +626,7 @@ static inline u32 mpic_physmask(u32 cpum
 	int i;
 	u32 mask = 0;
 
-	for (i = 0; i < min(32, NR_CPUS); ++i, cpumask >>= 1)
+	for (i = 0; i < min(32, NR_CPUS) && cpu_possible(i); ++i, cpumask >>= 1)
 		mask |= (cpumask & 1) << get_hard_smp_processor_id(i);
 	return mask;
 }
