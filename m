Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A219FC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030CD20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukcOrHEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030CD20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeJaMYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:24:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35012 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeJaMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:24:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id n4-v6so5989466plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkiQMuZb68Bws7nm5qJb3wroH0iBRmJTrQHyerd/nO4=;
        b=ukcOrHEVCv2LEMCZE//ejDKs7a5piuP2u4nyoWJQcmu/xXveMEECC3WuhN8BSs1TYc
         0dXKTKHhpRZ/c7YD13HmHtFbxebdOXABl5qWgPt5k3WIu3PrmEReQ0i7YIFU2a8HDHK8
         HPhVzrFWmKSAyDoaxX9+1aAmIMcQFIC+rJ7niHGoQo+9HxuR7NpdiKfJE6JfcAAsbzYD
         0dks3Pv6QSOVRrNGqo/BasXMTCDyOLWk9AzIYDGdP8Bt7YVqKwwVXCCJ7Q49QIgDQ9dx
         FCzimZViXPmStK/FVmxOGfChOF1coZ12IwaIi+wmWaQDUBHiekPieDv0Ho9sTyYpULwb
         1OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hkiQMuZb68Bws7nm5qJb3wroH0iBRmJTrQHyerd/nO4=;
        b=tQeTV6etf4dneC/oBUv/aMwtAX5GnJcdr7x7bgH8LLLaYm6DfimJzTIZqRA0IvyVSD
         mE1w1X9FfmWCPvhghyRe1NL9UbmhKa0VvtpqnJ/DnhthI2RvffEcJv5S4nXjct+nBQz2
         T1M6LdM7HfF+IO4eYxyZmV8oW5awghT3M80rCHR7KmJzS0Zh3TBJSfaTNhWU/KHFxVe2
         XETs++19Alp9r0Hu7niC8De/OGkUSBrl6b1lmdQORqfxf9FSeSMRtDnTyHKWqi9kekv8
         jf31lAkZtkTPo6bdw92kz1sGYnOVsg1wNFxLREfjZ9lMGfzYfeY6x0yjJgxhIwQTr6Il
         +qWg==
X-Gm-Message-State: AGRZ1gJlXLa4X9i73wJnzF0VORxC4A7UElxJaL8DpcnsC8oaxlcrE2Go
        X02fyPEs9jQ3GAlwHdjsCPI=
X-Google-Smtp-Source: AJdET5ekT1N4gQefzp/9Q2i4Yh1OE/2oSEa0bXUqfygddbX/1/Tx44yxD2f4cIDbdA4tf1f2mRSWLQ==
X-Received: by 2002:a17:902:6909:: with SMTP id j9-v6mr1439240plk.221.1540956520142;
        Tue, 30 Oct 2018 20:28:40 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id b62-v6sm27195786pfa.159.2018.10.30.20.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 20:28:38 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Wed, 31 Oct 2018 13:58:31 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jinsong Ji <jji@us.ibm.com>
Subject: [PATCH] raid6/ppc: Fix build for clang
Date:   Wed, 31 Oct 2018 13:58:29 +1030
Message-Id: <20181031032829.18131-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot build these files with clang as it does not allow altivec
instructions in assembly when -msoft-float is passed.

Jinsong Ji <jji@us.ibm.com> wrote:
> We currently disable Altivec/VSX support when enabling soft-float.  So
> any usage of vector builtins will break.
>
> Enable Altivec/VSX with soft-float may need quite some clean up work, so
> I guess this is currently a limitation.
>
> Removing -msoft-float will make it work (and we are lucky that no
> floating point instructions will be generated as well).

This is a workaround until the issue is resolved in clang.

Link: https://bugs.llvm.org/show_bug.cgi?id=31177
Link: https://github.com/ClangBuiltLinux/linux/issues/239
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 lib/raid6/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 2f8b61dfd9b0..3a844e6fd01c 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+
+ifdef CONFIG_CC_IS_CLANG
+# clang ppc port does not yet support -maltifec when -msoft-float is
+# enabled. A future release of clang will resolve this
+# https://bugs.llvm.org/show_bug.cgi?id=31177
+CFLAGS_REMOVE_altivec1.o  += -msoft-float
+CFLAGS_REMOVE_altivec2.o  += -msoft-float
+CFLAGS_REMOVE_altivec4.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_altivec8.o  += -msoft-float
+CFLAGS_REMOVE_vpermxor1.o += -msoft-float
+CFLAGS_REMOVE_vpermxor2.o += -msoft-float
+CFLAGS_REMOVE_vpermxor4.o += -msoft-float
+CFLAGS_REMOVE_vpermxor8.o += -msoft-float
+endif
 endif
 
 # The GCC option -ffreestanding is required in order to compile code containing
-- 
2.19.1

