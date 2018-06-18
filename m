Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0774C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9AE20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9AE20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966024AbeFRJa5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:30:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935926AbeFRIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3AC8FBAD;
        Mon, 18 Jun 2018 08:25:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 176/279] IB/mlx4: Fix integer overflow when calculating optimal MTT size
Date:   Mon, 18 Jun 2018 10:12:41 +0200
Message-Id: <20180618080616.213734209@linuxfoundation.org>
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

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit b03bcde962606d2ee59a4e9dd470db9ad53c5418 ]

When the kernel was compiled using the UBSAN option,
we saw the following stack trace:

[ 1184.827917] UBSAN: Undefined behaviour in drivers/infiniband/hw/mlx4/mr.c:349:27
[ 1184.828114] signed integer overflow:
[ 1184.828247] -2147483648 - 1 cannot be represented in type 'int'

The problem was caused by calling round_up in procedure
mlx4_ib_umem_calc_optimal_mtt_size (on line 349, as noted in the stack
trace) with the second parameter (1 << block_shift) (which is an int).
The second parameter should have been (1ULL << block_shift) (which
is an unsigned long long).

(1 << block_shift) is treated by the compiler as an int (because 1 is
an integer).

Now, local variable block_shift is initialized to 31.
If block_shift is 31, 1 << block_shift is 1 << 31 = 0x80000000=-214748368.
This is the most negative int value.

Inside the round_up macro, there is a cast applied to ((1 << 31) - 1).
However, this cast is applied AFTER ((1 << 31) - 1) is calculated.
Since (1 << 31) is treated as an int, we get the negative overflow
identified by UBSAN in the process of calculating ((1 << 31) - 1).

The fix is to change (1 << block_shift) to (1ULL << block_shift) on
line 349.

Fixes: 9901abf58368 ("IB/mlx4: Use optimal numbers of MTT entries")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -346,7 +346,7 @@ int mlx4_ib_umem_calc_optimal_mtt_size(s
 	/* Add to the first block the misalignment that it suffers from. */
 	total_len += (first_block_start & ((1ULL << block_shift) - 1ULL));
 	last_block_end = current_block_start + current_block_len;
-	last_block_aligned_end = round_up(last_block_end, 1 << block_shift);
+	last_block_aligned_end = round_up(last_block_end, 1ULL << block_shift);
 	total_len += (last_block_aligned_end - last_block_end);
 
 	if (total_len & ((1ULL << block_shift) - 1ULL))


