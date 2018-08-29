Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8191C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPCQdK7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A51F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeH2L2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeH2L2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:28:01 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2108E2084A;
        Wed, 29 Aug 2018 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535527950;
        bh=Xbs3MzuZf70I1Q0o4JqIy6/Wie8FTvoLd/imSukjNPg=;
        h=From:To:Cc:Subject:Date:From;
        b=OPCQdK7LkhCF6y8kRTV8D1atsjEdkSaLfnd77zbZuB01ps7wToD2iIpDbjReaBu+D
         gl/wR8TiP5jjEN4WJOgDQGFs3iQWBNCYdVC33Jepw+aLZD/a7g1YT14KkVqkKZhHld
         zN32YkeueoTivcHc7d1CCJDP4l8FDCiNaI0sOqe8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Michal Kubecek <mkubecek@suse.cz>
Subject: [RFT] powerpc/boot: Fix missing crc32poly.h when building with KERNEL_XZ
Date:   Wed, 29 Aug 2018 09:32:23 +0200
Message-Id: <1535527943-32566-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit faa16bc404d7 ("lib: Use existing define with
polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
directory thus any other user of this code should define proper include
path.

This fixes the build error on powerpc with CONFIG_KERNEL_XZ:

    In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
                     from ../arch/powerpc/boot/decompress.c:42:
    ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory

Reported-by: Michal Kubecek <mkubecek@suse.cz>
Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Only compile tested.
---
 arch/powerpc/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0fb96c26136f..ba4182fb185d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -63,7 +63,7 @@ ifeq ($(call cc-option-yn, -fstack-protector),y)
 BOOTCFLAGS	+= -fno-stack-protector
 endif
 
-BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
+BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj) -I$(srctree)/include
 
 DTC_FLAGS	?= -p 1024
 
-- 
2.7.4

