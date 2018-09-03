Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B71C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7407620658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7407620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbeICV7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:59:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeICV7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:59:02 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2410CA95;
        Mon,  3 Sep 2018 17:37:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.18 093/123] s390/purgatory: Fix crash with expoline enabled
Date:   Mon,  3 Sep 2018 18:57:17 +0200
Message-Id: <20180903165723.458137274@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Rudo <prudo@linux.ibm.com>

commit ad03b821fbc30395b72af438f5bb41676a5f891d upstream.

When the kernel is built with CONFIG_EXPOLINE=y and a compiler with
indirect branch mitigation enabled the purgatory crashes. The reason for
that is that the macros defined for expoline are used in mem.S. These
macros define new sections (.text.__s390x_indirect_*) which are marked
executable. Due to the missing linker script those sections are linked to
address 0, just as the .text section. In combination with the entry point
also being at address 0 this causes the purgatory load code
(kernel/kexec_file.c: kexec_purgatory_setup_sechdrs) to update the entry
point twice. Thus the old kernel jumps to some 'random' address causing the
crash.

To fix this turn off expolines for the purgatory. There is no problem with
this in this case due to the fact that the purgatory only runs once and the
tlb is purged (diag 308) in the end.

Fixes: 840798a1f5299 ("s390/kexec_file: Add purgatory")
Cc: <stable@vger.kernel.org> # 4.17
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/purgatory/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -23,6 +23,7 @@ KBUILD_CFLAGS += -Wno-pointer-sign -Wno-
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
+KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)


