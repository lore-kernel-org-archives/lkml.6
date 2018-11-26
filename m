Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D74AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E8E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpW+HeTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E8E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbeKZV7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730901AbeKZV7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F58D20645;
        Mon, 26 Nov 2018 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230336;
        bh=a7StgSna6CfcJ6C/dZhCtokbZc1vtK6Ct2PicEtoSw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpW+HeTfdzR7YGRNNPI85/M5tV2sTe8f+Gh7QbJ5fsoyuVG4Vwn2LGHfHFvlhDz3c
         OuhszS/SPkLU3AXf34OUrE9mh4ubIo83tDk9kNADIQs17rBbOs5URYjIWd9Py1VvzK
         2tokHS8hbVAV5sRWtoe0H4IBCiHDPv+e3O+n2TGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH 4.19 097/118] RISC-V: Fix raw_copy_{to,from}_user()
Date:   Mon, 26 Nov 2018 11:51:31 +0100
Message-Id: <20181126105105.592696262@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olof Johansson <olof@lixom.net>

commit 21f70d4abf9e17c2e3d7e64b7bfa3424e017f176 upstream.

Sparse highlighted it, and appears to be a pure bug (from vs to).

./arch/riscv/include/asm/uaccess.h:403:35: warning: incorrect type in argument 1 (different address spaces)
./arch/riscv/include/asm/uaccess.h:403:39: warning: incorrect type in argument 2 (different address spaces)
./arch/riscv/include/asm/uaccess.h:409:37: warning: incorrect type in argument 1 (different address spaces)
./arch/riscv/include/asm/uaccess.h:409:41: warning: incorrect type in argument 2 (different address spaces)

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/include/asm/uaccess.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -400,13 +400,13 @@ extern unsigned long __must_check __asm_
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __asm_copy_to_user(to, from, n);
+	return __asm_copy_from_user(to, from, n);
 }
 
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __asm_copy_from_user(to, from, n);
+	return __asm_copy_to_user(to, from, n);
 }
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);


