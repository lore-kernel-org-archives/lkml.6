Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27420685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB27420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbeGWNq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:46:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbeGWNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:46:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73D90C0A;
        Mon, 23 Jul 2018 12:43:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        kvm@vger.kernel.org, pbonzini@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 032/107] x86/speculation: Correct Speculation Control microcode blacklist again
Date:   Mon, 23 Jul 2018 14:41:26 +0200
Message-Id: <20180723122414.447651362@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit d37fc6d360a404b208547ba112e7dabb6533c7fc upstream.

Arjan points out that the Intel document only clears the 0xc2 microcode
on *some* parts with CPUID 506E3 (INTEL_FAM6_SKYLAKE_DESKTOP stepping 3).
For the Skylake H/S platform it's OK but for Skylake E3 which has the
same CPUID it isn't (yet) cleared.

So removing it from the blacklist was premature. Put it back for now.

Also, Arjan assures me that the 0x84 microcode for Kaby Lake which was
featured in one of the early revisions of the Intel document was never
released to the public, and won't be until/unless it is also validated
as safe. So those can change to 0x80 which is what all *other* versions
of the doc have identified.

Once the retrospective testing of existing public microcodes is done, we
should be back into a mode where new microcodes are only released in
batches and we shouldn't even need to update the blacklist for those
anyway, so this tweaking of the list isn't expected to be a thing which
keeps happening.

Requested-by: Arjan van de Ven <arjan.van.de.ven@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1518449255-2182-1-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/cpu/intel.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -40,13 +40,14 @@ struct sku_microcode {
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },


