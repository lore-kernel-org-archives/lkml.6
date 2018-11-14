Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D556C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA34A223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LrzAFjMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA34A223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeKNSZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:25:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbeKNSZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nw/+1np6RLBwFolHupU7NVMEa64709yGsbbCr2kO4Uw=; b=LrzAFjMRbZGmBAjMO9HHRyGIWC
        KYe9i1KM+gnkk3XB+hU1HE3XRagWqWFKHt6MdzJdoGVLcyMmMqxTVIEeF3VUFYASMizmt4HbRECGo
        ciCcZVdXE5icpvoJY1T0JkuWcHf0j2dni5LK9I3JVVEXFxQ+U96/6KgzUn5DlwsdivzcxXGdEkpcL
        T/Xk0HDV2YvozBu+aBb+EBz0paVrdtN9qHlt4PaHq8ZDkwfJ0Og5BD1yPANn3mX5CL4puLZl+sphQ
        JkkOFVvCBTJJIHA7eVIhp4hGKm5d0vAB2dRFFWVPPRYGcQxrkKPOaBMF/WfGiiHqUJ1zDyQ2snIVB
        akQJq2zg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSH-0004e1-Qq; Wed, 14 Nov 2018 08:23:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/34] powerpc: allow NOT_COHERENT_CACHE for amigaone
Date:   Wed, 14 Nov 2018 09:22:42 +0100
Message-Id: <20181114082314.8965-3-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMIGAONE select NOT_COHERENT_CACHE, so we better allow it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/Kconfig.cputype | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f4e2c5729374..6fedbf349fce 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -412,7 +412,8 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
+	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
+		GAMECUBE_COMMON || AMIGAONE
 	default n if PPC_47x
 	default y
 
-- 
2.19.1

