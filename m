Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE293ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DDE208D9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DDE208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeIWXgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 19:36:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726280AbeIWXgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 19:36:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C262ACE2;
        Sun, 23 Sep 2018 17:38:10 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH] xen: x86: make asm/xen/events.h include xen/xen.h
Date:   Sun, 23 Sep 2018 19:38:02 +0200
Message-Id: <20180923173802.10339-1-nstange@suse.de>
X-Mailer: git-send-email 2.13.7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/include/asm/xen/events.h references xen_hvm_domain() from the
inlined xen_support_evtchn_rebind().

xen_hvm_domain() gets #defined in include/xen/xen.h and
arch/x86/include/asm/xen/events.h doesn't include that.

On current Linus' tree, everything works fine though, because of the
following inclusion chain

  include/xen/events.h
   arch/x86/include/asm/xen/hypercall.h
    arch/x86/include/asm/pgtable.h
     arch/x86/include/asm/fixmap.h
      arch/x86/include/asm/acpi.h
       arch/x86/include/asm/realmode.h
        arch/x86/include/asm/io.h
         include/xen/xen.h
   asm/xen/events.h

which has been established in commit f991376e444a ("x86/mm: Correct fixmap
header usage on adaptable MODULES_END") resp. commit ef37bc361442
("x86/headers: Simplify asm/fixmap.h inclusion into asm/pgtable*.h").

Stable 4.9 lacks both of these and backporting them wouldn't really make
sense.

In consequence, the backport of commit 447ae3166702 ("x86: Don't include
linux/irq.h from asm/hardirq.h") to stable 4.9 broke compilation with
errors like

  In file included from include/xen/events.h:11:0,
                   from arch/x86/xen/irq.c:9:
  arch/x86/include/asm/xen/events.h: In function
    ‘xen_support_evtchn_rebind’:
  arch/x86/include/asm/xen/events.h:31:2: error: implicit declaration of
    function ‘xen_hvm_domain’ [-Werror=implicit-function-declaration]
    return (!xen_hvm_domain() || xen_have_vector_callback);
    ^

Facilitate backporting to the stable trees by making
arch/x86/include/asm/xen/events.h include xen/xen.h.

Fixes: 447ae3166702 ("x86: Don't include linux/irq.h from asm/hardirq.h")
Cc: <stable@vger.kernel.org> # 4.9.x
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 arch/x86/include/asm/xen/events.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/xen/events.h b/arch/x86/include/asm/xen/events.h
index d383140e1dc8..068d9b067c83 100644
--- a/arch/x86/include/asm/xen/events.h
+++ b/arch/x86/include/asm/xen/events.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_XEN_EVENTS_H
 #define _ASM_X86_XEN_EVENTS_H
 
+#include <xen/xen.h>
+
 enum ipi_vector {
 	XEN_RESCHEDULE_VECTOR,
 	XEN_CALL_FUNCTION_VECTOR,
-- 
2.13.7

