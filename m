Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC27C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76E320875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="VMSWJUBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76E320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeGLFzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:55:52 -0400
Received: from bosmailout10.eigbox.net ([66.96.189.10]:40505 "EHLO
        bosmailout10.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeGLFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:51 -0400
X-Greylist: delayed 1876 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 01:55:50 EDT
Received: from bosmailscan12.eigbox.net ([10.20.15.12])
        by bosmailout10.eigbox.net with esmtp (Exim)
        id 1fdTy6-0004Fk-Py
        for linux-kernel@vger.kernel.org; Thu, 12 Jul 2018 01:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:Message-Id:Date:Subject:Cc:To:From:Reply-To
        :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jQovzf8k9qsqvtgR67QdgQ4b0HnoaTZitsXW3y/r6Jc=; b=VMSWJUBDERDEcN+Kr/1mDoR7sQ
        uVq6YcgFNQzFMlTlr99Req102UD+PR/9GkuqdJvvz0zty7E7MZ2ZJA8FB9JDtnpDjK8L/ELWYw+PH
        HDXIYy+K+VAO9LktES+S/T7RxjB8oFaRUkf6p+nezGugwXdE0S/GkS7DBFGVpJmkjjEwmn8+giB0l
        hj+2g6tmoHxIQeL51U0pG524QcG52GZHaBeDRcfWKvsX2TfkSU8XBbklU6vWCEVLHvTmfd1O8amR7
        ZZp4dngJazi0O6mzsf2yCmTGigQs/OKHmGN8C0t3VWgbVujxhGXZEv9rA+WeG0LAGYcLywJFDFs5o
        pn+W7hHA==;
Received: from [10.115.3.32] (helo=bosimpout12)
        by bosmailscan12.eigbox.net with esmtp (Exim)
        id 1fdTy6-0000FZ-Mr
        for linux-kernel@vger.kernel.org; Thu, 12 Jul 2018 01:16:42 -0400
Received: from bosauthsmtp17.yourhostingaccount.com ([10.20.18.17])
        by bosimpout12 with 
        id 9hGa1y0040N5uqq01hGd5C; Thu, 12 Jul 2018 01:16:42 -0400
X-Authority-Analysis: v=2.2 cv=UN2tJGXy c=1 sm=1 tr=0
 a=f4kFLigMKr8AH7rIJ//qJA==:117 a=Dlu3QSMc4l9Ye4MXzL7CyA==:17
 a=R9QF1RCXAYgA:10 a=c2dxBoeyqOUA:10 a=dSbym95GAAAA:8 a=QyXUC8HyAAAA:8
 a=ZNeiQbORJdvHGzE3RP4A:9 a=DIU0KJH7bMsA:10 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [37.142.20.114] (port=11570 helo=localhost.localdomain)
        by bosauthsmtp17.eigbox.net with esmtpa (Exim)
        id 1fdTxy-0001XH-1J; Thu, 12 Jul 2018 01:16:34 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH] MAINTAINERS: Add samples/mic/
Date:   Thu, 12 Jul 2018 08:15:31 +0300
Message-Id: <20180712051601.24037-1-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 37.142.20.114
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b40d702337f2..42c439b5cd6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7303,6 +7303,7 @@ F:	drivers/misc/mic/
 F:	drivers/dma/mic_x100_dma.c
 F:	drivers/dma/mic_x100_dma.h
 F:	Documentation/mic/
+F:	samples/mic/
 
 INTEL PMC CORE DRIVER
 M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
-- 
2.17.1

