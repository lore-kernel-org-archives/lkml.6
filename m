Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31667ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C276C20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XAKBqT+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C276C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbeKAAY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:24:29 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:36206 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeKAAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:24:29 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4799524E1044;
        Wed, 31 Oct 2018 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540999561; bh=U8VffSoUo3TdgUfR1xBBMWutGmz0vyVgbyJpt2oHIg4=;
        h=From:To:Cc:Subject:Date:From;
        b=XAKBqT+u9glgu2kPlPYTYxTXzrvtR5bEMaF00R9oN9HQab8rsRBzgCsJUS6jLe8KJ
         nMUMJ+0Pnk1eQgbOfgRj72FmGPtGG/kkeqlsUXKfHCmJoT6b3fbIA5OAq9wpx9Ii5w
         0/RRu6WiYsIGTjVHLH+hCzOaHgnsPuXBGvRKERPZQz2X4MFJRc2sc2TO1iv1v76PfF
         xnA8IXhiRA+QjJf43O1JQQ1u/MO0IiTX9u5wZ+v1s6tj8Cd3mbQ7gtPE+rhy0QjvHS
         lmqGH+asgAmIvAcwYpVA88pIp4ioycbhVus+USZ4Oakkap3c0iqkCZv5Zt5BybL++n
         ZMkGLi8vCjQ1w==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.225.15.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id A05C452E2;
        Wed, 31 Oct 2018 08:25:55 -0700 (PDT)
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        stable@vger.kernel.org
Subject: [PATCH v4] devres: Align data[] to ARCH_KMALLOC_MINALIGN
Date:   Wed, 31 Oct 2018 18:25:47 +0300
Message-Id: <20181031152547.9066-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially we bumped into problem with 32-bit aligned atomic64_t
on ARC, see [1]. And then during quite lengthly discussion Peter Z.
mentioned ARCH_KMALLOC_MINALIGN which IMHO makes perfect sense.
If allocation is done by plain kmalloc() obtained buffer will be
ARCH_KMALLOC_MINALIGN aligned and then why buffer obtained via
devm_kmalloc() should have any other alignment?

This way we at least get the same behavior for both types of
allocation.

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004009.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004036.html

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Cc: <stable@vger.kernel.org> # 4.8+
---

Changes v3 -> v4:

 * Use ARCH_KMALLOC_MINALIGN for alignment instead of "8" [Peter]

Changes v2 -> v3:

 * Align explicitly to 8 bytes [David]
 * Rephrased in-line comment [David]
 * Added more techinical details to commit message [Greg]
 * Mention more alignment options in commit message [Geert]

Changes v1 -> v2:

 * Reworded commit message
 * Inserted comment right in source [Thomas]

 drivers/base/devres.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 4aaf00d2098b..e038e2b3b7ea 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -26,8 +26,14 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	/*
+	 * Some archs want to perform DMA into kmalloc caches
+	 * and need a guaranteed alignment larger than
+	 * the alignment of a 64-bit integer.
+	 * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
+	 * buffer alignment as if it was allocated by plain kmalloc().
+	 */
+	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
 };
 
 struct devres_group {
-- 
2.17.2

