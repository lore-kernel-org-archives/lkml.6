Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08767ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F1C2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pogth8Ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F1C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeKIHmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeKIHmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:10 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8D620844;
        Thu,  8 Nov 2018 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714680;
        bh=LRlfBy1xSZqEUKqqmH68YOUCr0nu+PxnPxQVyiLCuRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pogth8TyHYE7BkuucLsk66+Lu1fkSlK3oavCzyrOlAdyhoEkxr154Bz+xe7kShg9I
         moquPPnTqBkivsKbEek7Ns9keBbT/mfOWkf8/Fr9sGH2xsDhEdRXOEKNWmIr1TNspP
         XSOLuAYAxFd0fV0XVQyz+JvDL4WUZFcz6243CRHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jane Chu <jane.chu@oracle.com>,
        Bob Picco <bob.picco@oracle.com>,
        Atish Patra <atish.patra@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 061/171] arch/sparc: increase CONFIG_NODES_SHIFT on SPARC64 to 5
Date:   Thu,  8 Nov 2018 13:50:31 -0800
Message-Id: <20181108215131.976363367@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7485af89a6fd48f7e6fab2505d2364d1817723e6 ]

SPARC M6-32 platform has (2^5) NUMA nodes, so need to bump up the
CONFIG_NODES_SHIFT to 5.

Orabug: 25577754

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Atish Patra <atish.patra@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8b4152f3a764..cef42d4be292 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -290,9 +290,13 @@ config NUMA
 	depends on SPARC64 && SMP
 
 config NODES_SHIFT
-	int
-	default "4"
+	int "Maximum NUMA Nodes (as a power of 2)"
+	range 4 5 if SPARC64
+	default "5"
 	depends on NEED_MULTIPLE_NODES
+	help
+	  Specify the maximum number of NUMA Nodes available on the target
+	  system.  Increases memory reserved to accommodate various tables.
 
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
-- 
2.17.1



