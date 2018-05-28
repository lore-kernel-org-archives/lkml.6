Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422772AbeE1LFI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164593AbeE1K4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:56:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 343/496] powerpc/64s/idle: Fix restore of AMOR on POWER9 after deep sleep
Date: Mon, 28 May 2018 12:02:08 +0200
Message-Id: <20180528100334.268146588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit c1b25a17d24925b0961c319cfc3fd7e1dc778914 ]

POWER8 restores AMOR when waking from deep sleep, but POWER9 does not,
because it does not go through the subcore restore.

Have POWER9 restore it in core restore.

Fixes: ee97b6b99f42 ("powerpc/mm/radix: Setup AMOR in HV mode to allow key 0")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/idle_book3s.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -838,6 +838,8 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_PTCR,r4
 	ld	r4,_RPR(r1)
 	mtspr	SPRN_RPR,r4
+	ld	r4,_AMOR(r1)
+	mtspr	SPRN_AMOR,r4
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 	ld	r4,_TSCR(r1)
