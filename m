Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA95BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871DE24885
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871DE24885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031711AbeGAQjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:39:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031202AbeGAQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:39:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 575A992B;
        Sun,  1 Jul 2018 16:39:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kumar Gala <galak@kernel.crashing.org>,
        Vakul Garg <vakul.garg@nxp.com>, Scott Wood <swood@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4.17 057/220] powerpc/e500mc: Set assembler machine type to e500mc
Date:   Sun,  1 Jul 2018 18:21:21 +0200
Message-Id: <20180701160910.725914226@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Jeanson <mjeanson@efficios.com>

commit 69a8405999aa1c489de4b8d349468f0c2b83f093 upstream.

In binutils 2.26 a new opcode for the "wait" instruction was added for the
POWER9 and has precedence over the one specific to the e500mc. Commit
ebf714ff3756 ("powerpc/e500mc: Add support for the wait instruction in
e500_idle") uses this instruction specifically on the e500mc to work around
an erratum.

This results in an invalid instruction in idle_e500 when we build for the
e500mc on bintutils >= 2.26 with the default assembler machine type.

Since multiplatform between e500 and non-e500 is not supported, set the
assembler machine type globaly when CONFIG_PPC_E500MC=y.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Vakul Garg <vakul.garg@nxp.com>
CC: Scott Wood <swood@redhat.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
CC: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -251,6 +251,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)


