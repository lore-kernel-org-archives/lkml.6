Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74217C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16807208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gwC+1U+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16807208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964852AbeFNP2f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:28:35 -0400
Received: from mail.efficios.com ([167.114.142.138]:49202 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936025AbeFNP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:28:33 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0EA9522A6AC;
        Thu, 14 Jun 2018 11:28:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id N_3xWb_x2L6c; Thu, 14 Jun 2018 11:28:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9EA0E22A6A8;
        Thu, 14 Jun 2018 11:28:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9EA0E22A6A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528990111;
        bh=BisWm1fQID4Ru64d20mSYq/lL2qy3S/S7gIbdg1Z0rM=;
        h=From:To:Date:Message-Id;
        b=gwC+1U+1/y0z0lhAv1rhrNOZP+E66jA3VaIvU79gm6v6bwX2m2kFjKMqeDTFhqE8g
         9ZS4qQdWKHy7xj5cnMTzdibzYXGrmAYp19M+zOLkNN7pG66wqrcwcuHrh53VxqKp2A
         FlGSA1PDQCkJLrJOoxk91kUR9hj3pR4emvkyQlCPEqMQ43g9wjlqQ999g6ioAwjHiU
         fqXKkKGiH4g+w3gMhVOUloHkPwNUF0V8YoTiJ4+9ZQ54f3LxWslnFD/NAu6dXwFOFq
         NEOpEfv3+zANLscWd3R5raoDegn11hPEQ9vyHSDtCrwELd1biCWEsE69H/CqNX/Y44
         jP+ODN28xu/Og==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 18yAey9-EJYF; Thu, 14 Jun 2018 11:28:31 -0400 (EDT)
Received: from laptop-mjeanson.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 6126022A6A3;
        Thu, 14 Jun 2018 11:28:31 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kumar Gala <galak@kernel.crashing.org>,
        Vakul Garg <vakul.garg@nxp.com>, Scott Wood <swood@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] powerpc/e500mc: Set assembler machine type to e500mc
Date:   Thu, 14 Jun 2018 11:27:42 -0400
Message-Id: <20180614152742.21075-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 95813df90801..bb2523b4bd8f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -251,6 +251,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
-- 
2.17.1

