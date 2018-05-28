Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162431AbeE1KiA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162404AbeE1Khz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:37:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 261/329] powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer
Date: Mon, 28 May 2018 12:03:10 +0200
Message-Id: <20180528100303.644848416@linuxfoundation.org>
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

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

[ Upstream commit bb19af816025d495376bd76bf6fbcf4244f9a06d ]

The current Branch History Rolling Buffer (BHRB) code does not check
for any privilege levels before updating the data from BHRB. This
could leak kernel addresses to userspace even when profiling only with
userspace privileges. Add proper checks to prevent it.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/perf/core-book3s.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -448,6 +448,16 @@ static void power_pmu_bhrb_read(struct c
 				/* invalid entry */
 				continue;
 
+			/*
+			 * BHRB rolling buffer could very much contain the kernel
+			 * addresses at this point. Check the privileges before
+			 * exporting it to userspace (avoid exposure of regions
+			 * where we could have speculative execution)
+			 */
+			if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
+				is_kernel_addr(addr))
+				continue;
+
 			/* Branches are read most recent first (ie. mfbhrb 0 is
 			 * the most recent branch).
 			 * There are two types of valid entries:
