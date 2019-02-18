Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B3321903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500010;
	bh=fh+Qv6RlwWnw+QjANmPCdjy7iy5MOfwZ3/EAuwAUP2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AjJC9RZHpnkX9fDssGqgCqpOViZRpQzpzcj1ZAzTW8mByJxK7xguk1ahJrxp8CbPR
	 vtrVgAd8DOcdUocfahlQy7uGCqBvGQSlKdAEOgOdm3Rhq6PqlEWwn2fy+tQ+swK6pm
	 o3dcysskH0MwHVY7nrBGV9JmEIn/ySrtlmXLAilM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbfBRO0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388374AbfBROCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C7520842;
        Mon, 18 Feb 2019 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498540;
        bh=fh+Qv6RlwWnw+QjANmPCdjy7iy5MOfwZ3/EAuwAUP2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqMdY+dP+rd541OXs/VK8STqS1LDc0pQ5TLt7qiW9dh0Ik5kR1+u4+diNGldumpAQ
         XXUntgs5VSI7YhK4Q85IrsJRpE3svVBNN9IwSxnolzHa0/u6mdPPrTkJzVqp0T2syY
         F6oqFH5VdxKDj2IBDXRYDPBalJMGCEq1C2MF9j2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 041/143] powerpc/uaccess: fix warning/error with access_ok()
Date:   Mon, 18 Feb 2019 14:42:49 +0100
Message-Id: <20190218133530.649016810@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 05a4ab823983d9136a460b7b5e0d49ee709a6f86 ]

With the following piece of code, the following compilation warning
is encountered:

	if (_IOC_DIR(ioc) != _IOC_NONE) {
		int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

		if (!access_ok(verify, ioarg, _IOC_SIZE(ioc))) {

drivers/platform/test/dev.c: In function 'my_ioctl':
drivers/platform/test/dev.c:219:7: warning: unused variable 'verify' [-Wunused-variable]
   int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

This patch fixes it by referencing 'type' in the macro allthough
doing nothing with it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a5ffe0207c16..05f1389228d2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -59,7 +59,7 @@
 #endif
 
 #define access_ok(type, addr, size)		\
-	(__chk_user_ptr(addr),			\
+	(__chk_user_ptr(addr), (void)(type),		\
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
 
 /*
-- 
2.19.1



