Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B508C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1F321904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497986;
	bh=dYNwiHqNTc2JnVADaNBH+3D6uJlPxREo/i4LUywMm2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MqKvsyjk16NXOzE3iKc25nM452WYCIY3SNEO/muCzrY3rJeJuwcjroosoZKO2r6iL
	 GkwnAnZxPzMw+8Ez1FgltChVg6Az3aPtzp3eF9UoHppHjb4KpV6d5mrm4J9pXnG5Xr
	 37wM3YSTMwBciIxPqCt0N7qo3EoobYD22O+8mRRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfBRNxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfBRNxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA0420449;
        Mon, 18 Feb 2019 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497979;
        bh=dYNwiHqNTc2JnVADaNBH+3D6uJlPxREo/i4LUywMm2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVz74M6T+sX7mHh8iPTm9YY+dACI4QCgtlouiOypy9VVI/7Ckc5lNnGCctXQwVBj7
         +NrwbIkBH1gJQvc7XzZHTkgLs53qxMKSPLLK7g8wdJOwGBvn2fOgLM03U+6PfofsKy
         bN3mXXLxWSZsTadnv4cdxmmK3wcviQogLWn/+SLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.19 71/85] alpha: Fix Eiger NR_IRQS to 128
Date:   Mon, 18 Feb 2019 14:43:37 +0100
Message-Id: <20190218133506.760823229@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Meelis Roos <mroos@linux.ee>

commit bfc913682464f45bc4d6044084e370f9048de9d5 upstream.

Eiger machine vector definition has nr_irqs 128, and working 2.6.26
boot shows SCSI getting IRQ-s 64 and 65. Current kernel boot fails
because Symbios SCSI fails to request IRQ-s and does not find the disks.
It has been broken at least since 3.18 - the earliest I could test with
my gcc-5.

The headers have moved around and possibly another order of defines has
worked in the past - but since 128 seems to be correct and used, fix
arch/alpha/include/asm/irq.h to have NR_IRQS=128 for Eiger.

This fixes 4.19-rc7 boot on my Force Flexor A264 (Eiger subarch).

Cc: stable@vger.kernel.org # v3.18+
Signed-off-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/include/asm/irq.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/alpha/include/asm/irq.h
+++ b/arch/alpha/include/asm/irq.h
@@ -56,15 +56,15 @@
 
 #elif defined(CONFIG_ALPHA_DP264) || \
       defined(CONFIG_ALPHA_LYNX)  || \
-      defined(CONFIG_ALPHA_SHARK) || \
-      defined(CONFIG_ALPHA_EIGER)
+      defined(CONFIG_ALPHA_SHARK)
 # define NR_IRQS	64
 
 #elif defined(CONFIG_ALPHA_TITAN)
 #define NR_IRQS		80
 
 #elif defined(CONFIG_ALPHA_RAWHIDE) || \
-	defined(CONFIG_ALPHA_TAKARA)
+      defined(CONFIG_ALPHA_TAKARA) || \
+      defined(CONFIG_ALPHA_EIGER)
 # define NR_IRQS	128
 
 #elif defined(CONFIG_ALPHA_WILDFIRE)


