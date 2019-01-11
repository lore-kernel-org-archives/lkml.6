Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116C9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FC72063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218325;
	bh=23xDBMvWg5NBxDjDcri20brlUGzDC3aJxs+ljEsGjaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eF/iaI2lHAckWCbDT6D8h3DV+67HmYaEabJvi0E4lWuwES08sgP/XyuLQ8gWDW9LF
	 DspaCaWRXn/K0piyYyMThsg9g9y/bGiNmw+14LeZLLT6MoGW8E2bOL2x/Bt9IqRRGb
	 51DU8Y6B7L+P74oQDFjMNRoTMyu+HGgjpFdIbB00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390983AbfAKOjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403782AbfAKOjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0262133F;
        Fri, 11 Jan 2019 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217547;
        bh=23xDBMvWg5NBxDjDcri20brlUGzDC3aJxs+ljEsGjaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxfepgNHyIhc/sm3MFDOOaiC//HYwWp6kSrYXfEUud2hZioAo6JV1nIDIsekNSLXN
         UXEZB7Okn8qwUFMXFW1g3YX62mAPTUL7hFpv6UtRV/m2G8LmMhLbVe4Omd4uegoRJN
         3Hi1FZ4Lxg0ReYNOGoZQHDvpNYZuaFy7cgxyELnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.19 100/148] raid6/ppc: Fix build for clang
Date:   Fri, 11 Jan 2019 15:14:38 +0100
Message-Id: <20190111131118.221979576@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

From: Joel Stanley <joel@jms.id.au>

commit e213574a449f7a57d4202c1869bbc7680b6b5521 upstream.

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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/raid6/Makefile |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
+
+ifdef CONFIG_CC_IS_CLANG
+# clang ppc port does not yet support -maltivec when -msoft-float is
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


