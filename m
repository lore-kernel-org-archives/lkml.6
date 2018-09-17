Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65862ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1132620685
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1132620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeIREaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:30:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIREaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:30:24 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BF3CC77;
        Mon, 17 Sep 2018 23:00:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Reza Arbab <arbab@linux.ibm.com>,
        Alistair Popple <alistair@popple.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 027/126] powerpc/powernv: Fix concurrency issue with npu->mmio_atsd_usage
Date:   Tue, 18 Sep 2018 00:41:15 +0200
Message-Id: <20180917211706.559809783@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Reza Arbab <arbab@linux.ibm.com>

[ Upstream commit 9eab9901b015f489199105c470de1ffc337cfabb ]

We've encountered a performance issue when multiple processors stress
{get,put}_mmio_atsd_reg(). These functions contend for
mmio_atsd_usage, an unsigned long used as a bitmask.

The accesses to mmio_atsd_usage are done using test_and_set_bit_lock()
and clear_bit_unlock(). As implemented, both of these will require
a (successful) stwcx to that same cache line.

What we end up with is thread A, attempting to unlock, being slowed by
other threads repeatedly attempting to lock. A's stwcx instructions
fail and retry because the memory reservation is lost every time a
different thread beats it to the punch.

There may be a long-term way to fix this at a larger scale, but for
now resolve the immediate problem by gating our call to
test_and_set_bit_lock() with one to test_bit(), which is obviously
implemented without using a store.

Fixes: 1ab66d1fbada ("powerpc/powernv: Introduce address translation services for Nvlink2")
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Acked-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/npu-dma.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -427,8 +427,9 @@ static int get_mmio_atsd_reg(struct npu
 	int i;
 
 	for (i = 0; i < npu->mmio_atsd_count; i++) {
-		if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
-			return i;
+		if (!test_bit(i, &npu->mmio_atsd_usage))
+			if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
+				return i;
 	}
 
 	return -ENOSPC;


