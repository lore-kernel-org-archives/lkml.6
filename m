Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31370C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E440B20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E440B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbeKLG1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:27:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49718 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730067AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000oF-Aq; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001ZD-PE; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        "Scott Wood" <swood@redhat.com>,
        "Kumar Gala" <galak@kernel.crashing.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Vakul Garg" <vakul.garg@nxp.com>,
        "Michael Jeanson" <mjeanson@efficios.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Paul Mackerras" <paulus@samba.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.467550280@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 153/366] powerpc/e500mc: Set assembler machine type
 to e500mc
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -205,6 +205,7 @@ endif
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= -Wa,-maltivec
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
+cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)

