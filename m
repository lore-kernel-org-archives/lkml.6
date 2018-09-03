Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A84C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A84C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbeICVsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:48:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeICVsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:48:41 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C77CD01;
        Mon,  3 Sep 2018 17:27:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.14 152/165] MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7
Date:   Mon,  3 Sep 2018 18:57:18 +0200
Message-Id: <20180903165704.702197566@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 690d9163bf4b8563a2682e619f938e6a0443947f upstream.

Some versions of GCC suboptimally generate calls to the __multi3()
intrinsic for MIPS64r6 builds, resulting in link failures due to the
missing function:

    LD      vmlinux.o
    MODPOST vmlinux.o
  kernel/bpf/verifier.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  fs/select.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  ...

We already have a workaround for this in which we provide the
instrinsic, but we do so selectively for GCC 7 only. Unfortunately the
issue occurs with older GCC versions too - it has been observed with
both GCC 5.4.0 & GCC 6.4.0.

MIPSr6 support was introduced in GCC 5, so all major GCC versions prior
to GCC 8 are affected and we extend our workaround accordingly to all
MIPS64r6 builds using GCC versions older than GCC 8.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Fixes: ebabcf17bcd7 ("MIPS: Implement __multi3 for GCC7 MIPS64r6 builds")
Patchwork: https://patchwork.linux-mips.org/patch/20297/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/arch/mips/lib/multi3.c b/arch/mips/lib/multi3.c
index 111ad475aa0c..4c2483f410c2 100644
--- a/arch/mips/lib/multi3.c
+++ b/arch/mips/lib/multi3.c
@@ -4,12 +4,12 @@
 #include "libgcc.h"
 
 /*
- * GCC 7 suboptimally generates __multi3 calls for mips64r6, so for that
- * specific case only we'll implement it here.
+ * GCC 7 & older can suboptimally generate __multi3 calls for mips64r6, so for
+ * that specific case only we implement that intrinsic here.
  *
  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82981
  */
-#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ == 7)
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ < 8)
 
 /* multiply 64-bit values, low 64-bits returned */
 static inline long long notrace dmulu(long long a, long long b)


