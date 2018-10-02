Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6988C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73172082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73172082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeJBUfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:35:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbeJBUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:16:47 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1315B2F;
        Tue,  2 Oct 2018 13:33:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 068/137] MIPS: boot: fix build rule of vmlinux.its.S
Date:   Tue,  2 Oct 2018 06:24:29 -0700
Message-Id: <20181002132503.345019177@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 67e09db507db3e1642ddce512a4313d20addd6e5 ]

As Documentation/kbuild/makefile.txt says, it is a typical mistake
to forget the FORCE prerequisite for the rule invoked by if_changed.

Add the FORCE to the prerequisite, but it must be filtered-out from
the files passed to the 'cat' command.  Because this rule generates
.vmlinux.its.S.cmd, vmlinux.its.S must be specified as targets so
that the .cmd file is included.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Patchwork: https://patchwork.linux-mips.org/patch/19097/
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/Makefile |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -118,10 +118,12 @@ ifeq ($(ADDR_BITS),64)
 	itb_addr_cells = 2
 endif
 
+targets += vmlinux.its.S
+
 quiet_cmd_its_cat = CAT     $@
-      cmd_its_cat = cat $^ >$@
+      cmd_its_cat = cat $(filter-out $(PHONY), $^) >$@
 
-$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS))
+$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS)) FORCE
 	$(call if_changed,its_cat)
 
 quiet_cmd_cpp_its_S = ITS     $@


