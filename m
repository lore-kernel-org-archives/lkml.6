Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DCAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C6620879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693928;
	bh=Z051twEqX6IRlFTohqRGgD2tlRYqH/uIIo/vKZGIle4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A6s3X3iIi/XMaajcnts8ql2le9sIza4b4U/IWCPkuGeFstfT0I2paUTLlU5vDGYKY
	 KZCKa0qhrTlUK9QdgDfeFR3AEjkdo7QP8g9YBQXKx4psZ95GriOqbA/QApx7n+K8sa
	 fcMLcuJAa4ItdLusdMkkCFys1NnuF4vLbcqH7LwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbfA1QWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbfA1QWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23F62084A;
        Mon, 28 Jan 2019 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692561;
        bh=Z051twEqX6IRlFTohqRGgD2tlRYqH/uIIo/vKZGIle4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMker0GQLrrbn55E+PQ6kLfcQzNC5PlNPcXc91tYbZOuE8JEJ6vmz03N5Obw/ilau
         e4sZ5T0jcAwfx1SQbvwJywqgTTFuqTV+uXleN9kYEZOreN+rBxqgCy8SkdXZ2l/00x
         jnzR6lwcJwBHU83kPLgsSM7jysn3XNJj4gYY2GMQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 064/107] powerpc/uaccess: fix warning/error with access_ok()
Date:   Mon, 28 Jan 2019 11:19:04 -0500
Message-Id: <20190128161947.57405-64-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

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
index c266227fdd5b..31913b3ac7ab 100644
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

