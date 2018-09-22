Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC756C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3DE2157F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3DE2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391909AbeIVGKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44082 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391849AbeIVGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BZ-Mr; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000ql-GV; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Nadav Amit" <namit@cs.technion.ac.il>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.898602430@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 14/63] KVM: x86: Emulator ignores LDTR/TR extended
 base on LLDT/LTR
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@cs.technion.ac.il>

commit e37a75a13cdae5deaa2ea2cbf8d55b5dd08638b6 upstream.

The current implementation ignores the LDTR/TR base high 32-bits on long-mode.
As a result the loaded segment descriptor may be incorrect.

Signed-off-by: Nadav Amit <namit@cs.technion.ac.il>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/emulate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1467,6 +1467,7 @@ static int __load_segment_descriptor(str
 	ulong desc_addr;
 	int ret;
 	u16 dummy;
+	u32 base3 = 0;
 
 	memset(&seg_desc, 0, sizeof seg_desc);
 
@@ -1597,9 +1598,14 @@ static int __load_segment_descriptor(str
 		ret = write_segment_descriptor(ctxt, selector, &seg_desc);
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
+	} else if (ctxt->mode == X86EMUL_MODE_PROT64) {
+		ret = ctxt->ops->read_std(ctxt, desc_addr+8, &base3,
+				sizeof(base3), &ctxt->exception);
+		if (ret != X86EMUL_CONTINUE)
+			return ret;
 	}
 load:
-	ctxt->ops->set_segment(ctxt, selector, &seg_desc, 0, seg);
+	ctxt->ops->set_segment(ctxt, selector, &seg_desc, base3, seg);
 	if (desc)
 		*desc = seg_desc;
 	return X86EMUL_CONTINUE;

