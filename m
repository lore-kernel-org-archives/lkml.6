Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB77C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FF20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896421;
	bh=G59B3UYJamT/5nmsYuetps5TNxpDFGTDLkZmy+eM9TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wFxHJ8zwOZPWrx5YGAYPsFxWZA1vhmZdda4fm9DIuLZWrLybrGXY28ZkM5xcZjI+c
	 Bq2dqMDeSh8dJqYDi53d67hedRPp87GvCHvFl2x8MvrcY4RB56Lg2vUucsqQ+aokeB
	 ui7F0URYtGZpqHumKs6yqrtWZ69Z35QE9PPGnNQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbfBKOq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbfBKOq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0950C2081B;
        Mon, 11 Feb 2019 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896418;
        bh=G59B3UYJamT/5nmsYuetps5TNxpDFGTDLkZmy+eM9TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/auHruciavfFZ05/PWjQj5FKVgqPD0cw6tIfv7wtahcRS4bqE3vLVcj/uiugFUyj
         9CV9UvOcTICO4ZEm4OOzMKxkb/ZyYTTfvZEcf29Z6j3CDacasW3B9mTGfbFEZgolBF
         AK5BKGhaLYnCiAP0L+WOBK6Cune7z37e3sk/JL3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 177/313] powerpc/uaccess: fix warning/error with access_ok()
Date:   Mon, 11 Feb 2019 15:17:37 +0100
Message-Id: <20190211141905.187234738@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
index bac225bb7f64..23bea99bf8d5 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -63,7 +63,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 #endif
 
 #define access_ok(type, addr, size)		\
-	(__chk_user_ptr(addr),			\
+	(__chk_user_ptr(addr), (void)(type),		\
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
 
 /*
-- 
2.19.1



