Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5EE2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5EE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeIRE34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:29:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIRE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:29:55 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D20A4CB2;
        Mon, 17 Sep 2018 23:00:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>
Subject: [PATCH 4.14 019/126] crypto: aes-generic - fix aes-generic regression on powerpc
Date:   Tue, 18 Sep 2018 00:41:07 +0200
Message-Id: <20180917211705.936630964@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 6e36719fbe90213fbba9f50093fa2d4d69b0e93c upstream.

My last bugfix added -Os on the command line, which unfortunately caused
a build regression on powerpc in some configurations.

I've done some more analysis of the original problem and found slightly
different workaround that avoids this regression and also results in
better performance on gcc-7.0: -fcode-hoisting is an optimization step
that got added in gcc-7 and that for all gcc-7 versions causes worse
performance.

This disables -fcode-hoisting on all compilers that understand the option.
For gcc-7.1 and 7.2 I found the same performance as my previous patch
(using -Os), in gcc-7.0 it was even better. On gcc-8 I could see no
change in performance from this patch. In theory, code hoisting should
not be able make things better for the AES cipher, so leaving it
disabled for gcc-8 only serves to simplify the Makefile change.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Link: https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg30418.html
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83651
Fixes: 148b974deea9 ("crypto: aes-generic - build with -Os on gcc-7+")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -98,7 +98,7 @@ obj-$(CONFIG_CRYPTO_TWOFISH_COMMON) += t
 obj-$(CONFIG_CRYPTO_SERPENT) += serpent_generic.o
 CFLAGS_serpent_generic.o := $(call cc-option,-fsched-pressure)  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79149
 obj-$(CONFIG_CRYPTO_AES) += aes_generic.o
-CFLAGS_aes_generic.o := $(call cc-ifversion, -ge, 0701, -Os) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
+CFLAGS_aes_generic.o := $(call cc-option,-fno-code-hoisting) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
 obj-$(CONFIG_CRYPTO_AES_TI) += aes_ti.o
 obj-$(CONFIG_CRYPTO_CAMELLIA) += camellia_generic.o
 obj-$(CONFIG_CRYPTO_CAST_COMMON) += cast_common.o


