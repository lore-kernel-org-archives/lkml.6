Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F3C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7602146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7602146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeIMSkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:40:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIMSkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:40:47 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C580D19;
        Thu, 13 Sep 2018 13:31:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <JBeulich@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Guenter Roeck <linux@roeck-us.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 01/60] x86/speculation/l1tf: Fix up pte->pfn conversion for PAE
Date:   Thu, 13 Sep 2018 15:30:08 +0200
Message-Id: <20180913131745.340659928@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.cz>

commit e14d7dfb41f5807a0c1c26a13f2b8ef16af24935 upstream.

Jan has noticed that pte_pfn and co. resp. pfn_pte are incorrect for
CONFIG_PAE because phys_addr_t is wider than unsigned long and so the
pte_val reps. shift left would get truncated. Fix this up by using proper
types.

[Just one chunk, again, needed here.  Thanks to Ben and Guenter for
finding and fixing this. - gregkh]

Fixes: 6b28baca9b1f ("x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation")
Reported-by: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -385,7 +385,7 @@ static inline pmd_t pfn_pmd(unsigned lon
 
 static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
 {
-	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PHYSICAL_PUD_PAGE_MASK;
 	return __pud(pfn | massage_pgprot(pgprot));


