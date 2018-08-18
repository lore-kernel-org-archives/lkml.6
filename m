Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF3C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C238721877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C238721877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeHRMdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:33:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:33:42 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5461B941;
        Sat, 18 Aug 2018 09:26:42 +0000 (UTC)
Date:   Sat, 18 Aug 2018 11:26:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.14.65
Message-ID: <20180818092639.GB5549@kroah.com>
References: <20180818092635.GA5549@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818092635.GA5549@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 025156791e90..7995690ff1aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 64
+SUBLEVEL = 65
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/x86/include/asm/pgtable-invert.h b/arch/x86/include/asm/pgtable-invert.h
index 44b1203ece12..a0c1525f1b6f 100644
--- a/arch/x86/include/asm/pgtable-invert.h
+++ b/arch/x86/include/asm/pgtable-invert.h
@@ -4,9 +4,18 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * A clear pte value is special, and doesn't get inverted.
+ *
+ * Note that even users that only pass a pgprot_t (rather
+ * than a full pte) won't trigger the special zero case,
+ * because even PAGE_NONE has _PAGE_PROTNONE | _PAGE_ACCESSED
+ * set. So the all zero case really is limited to just the
+ * cleared page table entry case.
+ */
 static inline bool __pte_needs_invert(u64 val)
 {
-	return !(val & _PAGE_PRESENT);
+	return val && !(val & _PAGE_PRESENT);
 }
 
 /* Get a mask to xor with the page table entry to get the correct pfn. */
