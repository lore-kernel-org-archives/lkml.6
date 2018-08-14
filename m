Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98156C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591122150F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591122150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403777AbeHNUfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:35:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390379AbeHNUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:35:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D07F6CB5;
        Tue, 14 Aug 2018 17:47:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 28/43] x86/speculation/l1tf: Make sure the first page is always reserved
Date:   Tue, 14 Aug 2018 19:18:04 +0200
Message-Id: <20180814171518.959322808@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
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

From: Andi Kleen <ak@linux.intel.com>

commit 10a70416e1f067f6c4efda6ffd8ea96002ac4223 upstream

The L1TF workaround doesn't make any attempt to mitigate speculate accesses
to the first physical page for zeroed PTEs. Normally it only contains some
data from the early real mode BIOS.

It's not entirely clear that the first page is reserved in all
configurations, so add an extra reservation call to make sure it is really
reserved. In most configurations (e.g.  with the standard reservations)
it's likely a nop.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/setup.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -851,6 +851,12 @@ void __init setup_arch(char **cmdline_p)
 	memblock_reserve(__pa_symbol(_text),
 			 (unsigned long)__bss_stop - (unsigned long)_text);
 
+	/*
+	 * Make sure page 0 is always reserved because on systems with
+	 * L1TF its contents can be leaked to user processes.
+	 */
+	memblock_reserve(0, PAGE_SIZE);
+
 	early_reserve_initrd();
 
 	/*


