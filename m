Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BBEC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD8D21654
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD8D21654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeHOLAh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:00:37 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:50994 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeHOLAh (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Wed, 15 Aug 2018 07:00:37 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 15 Aug 2018 02:09:27 -0600
Message-Id: <5B73DFB602000078001DE35E@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Wed, 15 Aug 2018 02:09:26 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Alok Kataria" <akataria@vmware.com>
Cc:     "Linux Virtualization" <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: [PATCH RESEND] x86-64: use RIP-relative calls for paravirt
 indirect ones
References: <5B30C3F102000078001CD6F1@prv1-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This saves one insn byte per instance, summing up to a savings of over
4k in my (stripped down) configuration. No variant of to be patched in
replacement code relies on the one byte larger size.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
Resend to include x86 maintainers, who aren't listed explicitly for the
file changed.
---
 arch/x86/include/asm/paravirt_types.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- 4.18/arch/x86/include/asm/paravirt_types.h
+++ 4.18-x86_64-pvops-call-RIPrel/arch/x86/include/asm/paravirt_types.h
@@ -393,9 +393,15 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
+#ifdef CONFIG_X86_32
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
 	"call *%c[paravirt_opptr];"
+#else
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr](%%rip);"
+#endif
 
 /*
  * These macros are intended to wrap calls through one of the paravirt


