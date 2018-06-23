Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3FC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0048D24078
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Nmyd8BvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0048D24078
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeFWN6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 09:58:15 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:44602 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeFWN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 09:58:13 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w5NDvYBW015690;
        Sat, 23 Jun 2018 22:57:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w5NDvYBW015690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529762256;
        bh=eF6juXb7PirRchUcfKJpaftuAQl8aBHmTPqdBo4/Lqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nmyd8BvV8EY4bEtgAC9k6W+nM6sM3FbLyMCoPHjKLvEM9zj0B4NZ7zXV+9htJI3Fk
         B7CX7gOwYC3vERSIVhughD9DksIgZCX4nkHVMlpONDfASbxRhlNw3kO5S1Iuc6rvto
         DGVXikA+FsM1zfiCYGdusSdAxiUG7zbqICJYkZ+6lNEaeFfHZFE3LUmYQkW+grRRa+
         imx95FK5IIkz8RLUuLBb0te+f/x30FsKh8c+JOCJs+HnQ6cpLmDd+VEUybgX6HilCm
         bJ33+iJAfTgeitMU1dnHBwK0PjDpHrZu8/o/7BHHvYv7N6jRhaUQwWiIkc5kGoZ4ID
         A3imn6KzTBnLg==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] kbuild: do not update config for 'make kernelrelease'
Date:   Sat, 23 Jun 2018 22:56:09 +0900
Message-Id: <1529762169-13488-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make kernelrelease' depends on CONFIG_LOCALVERSION(_AUTO), but
for the same reason as install targets, we do not want to update
the configuration just for printing the kernelrelease string.

This is likely to happen when you compiled the kernel with
CROSS_COMPILE, but forget to pass it to 'make kernelrelease'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f1e06fba..bb7394a 100644
--- a/Makefile
+++ b/Makefile
@@ -225,7 +225,8 @@ no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
 			 kernelversion %src-pkg
-no-sync-config-targets := $(no-dot-config-targets) install %install
+no-sync-config-targets := $(no-dot-config-targets) install %install \
+			   kernelrelease
 
 config-targets  := 0
 mixed-targets   := 0
-- 
2.7.4

