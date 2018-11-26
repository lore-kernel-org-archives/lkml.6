Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E28DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79B62089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x6IjnMQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79B62089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeKZVsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeKZVsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D69A2089F;
        Mon, 26 Nov 2018 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229679;
        bh=BC7zFL+GDZwK1xfYTcMWHumUwYGX4HGMmH+x+VT++ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6IjnMQrkT/TaD3eOSVRrH5Btq0LGMKSTm4acj5vPHKJbfE0y/B+w+SIJ+ynQtL/i
         kDBUNyyXR+d0UF2lVKPhvLFc49QH5uu9jXDvarPKGHkWEMCvY7rNUYbiEoy4DAL77n
         uSYKrXqrIGswQORIkHz+7fomIU4RIl1uVt1dQwpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Davidson <md@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 30/70] crypto, x86: aesni - fix token pasting for clang
Date:   Mon, 26 Nov 2018 11:50:45 +0100
Message-Id: <20181126105049.705533129@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Davidson <md@google.com>

commit fdb2726f4e61c5e3abc052f547d5a5f6c0dc5504 upstream.

aes_ctrby8_avx-x86_64.S uses the C preprocessor for token pasting
of character sequences that are not valid preprocessor tokens.
While this is allowed when preprocessing assembler files it exposes
an incompatibilty between the clang and gcc preprocessors where
clang does not strip leading white space from macro parameters,
leading to the CONCAT(%xmm, i) macro expansion on line 96 resulting
in a token with a space character embedded in it.

While this could be resolved by deleting the offending space character,
the assembler is perfectly capable of doing the token pasting correctly
for itself so we can just get rid of the preprocessor macros.

Signed-off-by: Michael Davidson <md@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
+++ b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
@@ -65,7 +65,6 @@
 #include <linux/linkage.h>
 #include <asm/inst.h>
 
-#define CONCAT(a,b)	a##b
 #define VMOVDQ		vmovdqu
 
 #define xdata0		%xmm0
@@ -92,8 +91,6 @@
 #define num_bytes	%r8
 
 #define tmp		%r10
-#define	DDQ(i)		CONCAT(ddq_add_,i)
-#define	XMM(i)		CONCAT(%xmm, i)
 #define	DDQ_DATA	0
 #define	XDATA		1
 #define KEY_128		1
@@ -131,12 +128,12 @@ ddq_add_8:
 /* generate a unique variable for ddq_add_x */
 
 .macro setddq n
-	var_ddq_add = DDQ(\n)
+	var_ddq_add = ddq_add_\n
 .endm
 
 /* generate a unique variable for xmm register */
 .macro setxdata n
-	var_xdata = XMM(\n)
+	var_xdata = %xmm\n
 .endm
 
 /* club the numeric 'id' to the symbol 'name' */


