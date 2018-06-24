Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518CBC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 08:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0275224E48
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 08:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpB10Gh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0275224E48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeFXIY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 04:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbeFXIYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 04:24:24 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CED24E39;
        Sun, 24 Jun 2018 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529828663;
        bh=yKLM/pQY54IGy51q1KTclziGrReSLUtlrR7tmp5YJaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpB10Gh/51L+65G8J3hR/d/PMgPAmlmGN5G3gI+39bRBNH4ERrwAd4jlacBSpMqZ3
         fleT1x7KAYpBv8eNQI7mF27x7xskhtshNzcM9nTqSXEXH63ZzYsxWmdlnOyUhJwQtd
         HP9PI66iGPk7DBlF3m/7+kd3Y2GAQgdSK0bO1Wms=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Hadar Hen Zion <hadarh@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Michael J Ruhl <michael.j.ruhl@intel.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Raed Salem <raeds@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 08/12] overflow.h: Add arithmetic shift helper
Date:   Sun, 24 Jun 2018 11:23:49 +0300
Message-Id: <20180624082353.16138-9-leon@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624082353.16138-1-leon@kernel.org>
References: <20180624082353.16138-1-leon@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Add shift_overflow() helper to help driver authors to ensure that
shift operand doesn't cause to overflow, which is very common pattern
for RDMA drivers.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/linux/overflow.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 8712ff70995f..2a3395248e94 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -202,6 +202,29 @@

 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */

+/**
+ * shift_overflow() - Peform shift operation with overflow check
+ * @a: value to be shifted
+ * @b: shift operand
+ *
+ * Checks if a << b will overflow
+ *
+ * Returns: result of shift for no overflow or SIZE_MAX for overflow
+ */
+static inline __must_check size_t shift_overflow(size_t a, size_t b)
+{
+	size_t c, res;
+
+	if (b >= sizeof(size_t) * BITS_PER_BYTE)
+		return SIZE_MAX;
+
+	c = (size_t)1 << b;
+	if (check_mul_overflow(a, c, &res))
+		return SIZE_MAX;
+
+	return res;
+}
+
 /**
  * array_size() - Calculate size of 2-dimensional array.
  *
--
2.14.4

