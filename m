Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55FFC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEB42188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEB42188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeHRMef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:34:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:34:35 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D66303EE;
        Sat, 18 Aug 2018 09:27:34 +0000 (UTC)
Date:   Sat, 18 Aug 2018 11:27:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.4.150
Message-ID: <20180818092732.GB5694@kroah.com>
References: <20180818092726.GA5694@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818092726.GA5694@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index e7c46ece5f27..7789195c6a59 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 4
-SUBLEVEL = 149
+SUBLEVEL = 150
 EXTRAVERSION =
 NAME = Blurry Fish Butt
 
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
