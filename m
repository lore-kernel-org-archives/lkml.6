Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981EDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B1A222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="OO+4k0y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfBKN7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:59:30 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:34766 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:59:25 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B421A25BEE2;
        Tue, 12 Feb 2019 00:59:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549893554; bh=4Wt8YgIK6tvMWR7ftlSnQU4JQjmsI43dIhNg/wYW9gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OO+4k0y59vvKnBb3Ynur832nLt+feqXLUrt5s7/tvbJ+YOsKG2LX/Wxb0/F/7aLLD
         uRtn0D026TmjaAa8hjfW/hbefwb/DGVRqnocJvhRBe5aZvScHCc37tAEsU3S3TkFBK
         pWvwtOcvUVA9Q4XQr4xdygImPO5LR7iPdDPjDvXo=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B16519404AC; Mon, 11 Feb 2019 14:59:11 +0100 (CET)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 3/6] math64: New DIV64_U64_ROUND_CLOSEST helper
Date:   Mon, 11 Feb 2019 14:58:55 +0100
Message-Id: <20190211135858.23635-4-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211135858.23635-1-horms+renesas@verge.net.au>
References: <20190211135858.23635-1-horms+renesas@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide DIV64_U64_ROUND_CLOSEST helper which performs division rounded to
the closes integer using an unsigned 64bit dividend and divisor.

This will be used in a follow-up patch to allow calculation of clock
divisors with high frequency parents in the R-Car Gen3 CPG MSSR driver
where ovefolow occurs if either the dividend or divisor is 32bit.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5: New separate patch to add DIV64_U64_ROUND_CLOSEST
---
 include/linux/math64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index bb2c84afb80c..65bef21cdddb 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -284,4 +284,17 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
+/**
+ * DIV64_U64_ROUND_CLOSEST - unsigned 64bit divide with 64bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 64bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 64bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
+
 #endif /* _LINUX_MATH64_H */
-- 
2.11.0

