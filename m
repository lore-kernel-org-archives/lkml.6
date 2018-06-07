Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NDNsIPtIGVuPTAAAmS7hNA
	; Thu, 07 Jun 2018 15:02:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3A83C608B8; Thu,  7 Jun 2018 15:02:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A0E6F601C3;
	Thu,  7 Jun 2018 15:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0E6F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933103AbeFGPCj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:02:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41444 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934909AbeFGPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:02:35 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005hL-Pl; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002tC-8v; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "James Hogan" <jhogan@kernel.org>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.538040447@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 144/410] MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 5f2483eb2423152445b39f2db59d372f523e664e upstream.

Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
separate files, so none of these files get cleaned up by make clean.
List the files separately instead.

Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make clean"")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18491/
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/boot/compressed/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -117,4 +117,8 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFL
 vmlinuz.srec: vmlinuz
 	$(call cmd,objcopy)
 
-clean-files := $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files += $(objtree)/vmlinuz
+clean-files += $(objtree)/vmlinuz.32
+clean-files += $(objtree)/vmlinuz.ecoff
+clean-files += $(objtree)/vmlinuz.bin
+clean-files += $(objtree)/vmlinuz.srec
