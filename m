Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599DEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAE320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAE320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408015AbeHATXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:23:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436576AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 94489F11;
        Wed,  1 Aug 2018 16:55:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 055/336] powerpc/64s: Fix compiler store ordering to SLB shadow area
Date:   Wed,  1 Aug 2018 18:46:30 +0200
Message-Id: <20180801165031.179666670@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 926bc2f100c24d4842b3064b5af44ae964c1d81c ]

The stores to update the SLB shadow area must be made as they appear
in the C code, so that the hypervisor does not see an entry with
mismatched vsid and esid. Use WRITE_ONCE for this.

GCC has been observed to elide the first store to esid in the update,
which means that if the hypervisor interrupts the guest after storing
to vsid, it could see an entry with old esid and new vsid, which may
possibly result in memory corruption.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/slb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -63,14 +63,14 @@ static inline void slb_shadow_update(uns
 	 * updating it.  No write barriers are needed here, provided
 	 * we only update the current CPU's SLB shadow buffer.
 	 */
-	p->save_area[index].esid = 0;
-	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
-	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));
+	WRITE_ONCE(p->save_area[index].esid, 0);
+	WRITE_ONCE(p->save_area[index].vsid, cpu_to_be64(mk_vsid_data(ea, ssize, flags)));
+	WRITE_ONCE(p->save_area[index].esid, cpu_to_be64(mk_esid_data(ea, ssize, index)));
 }
 
 static inline void slb_shadow_clear(enum slb_index index)
 {
-	get_slb_shadow()->save_area[index].esid = 0;
+	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
 }
 
 static inline void create_shadowed_slbe(unsigned long ea, int ssize,


