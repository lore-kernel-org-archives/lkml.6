Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8654C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8654C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbeIHCWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:22:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeIHCWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:22:20 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 247FDEC3;
        Fri,  7 Sep 2018 21:39:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4.4 13/47] x86/mm/pat: Fix L1TF stable backport for CPA, 2nd call
Date:   Fri,  7 Sep 2018 23:10:09 +0200
Message-Id: <20180907210905.764844643@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
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

From: Jiri Slaby <jslaby@suse.cz>

Mostly recycling the commit log from adaba23ccd7d which fixed
populate_pmd, but did not fix populate_pud. The same problem exists
there.

Stable trees reverted the following patch:
  Revert "x86/mm/pat: Ensure cpa->pfn only contains page frame numbers"

    This reverts commit 87e2bd898d3a79a8c609f183180adac47879a2a4 which is
    commit edc3b9129cecd0f0857112136f5b8b1bc1d45918 upstream.

but the L1TF patch 02ff2769edbc backported here

  x86/mm/pat: Make set_memory_np() L1TF safe

    commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream

    set_memory_np() is used to mark kernel mappings not present, but it has
    it's own open coded mechanism which does not have the L1TF protection of
    inverting the address bits.

assumed that cpa->pfn contains a PFN. With the above patch reverted
it does not, which causes the PUD to be set to an incorrect address
shifted by 12 bits, which can cause various failures.

Convert the address to a PFN before passing it to pud_pfn().

This is a 4.4 stable only patch to fix the L1TF patches backport there.

Cc: stable@vger.kernel.org # 4.4-only
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pageattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1079,7 +1079,7 @@ static int populate_pud(struct cpa_data
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
 	while (end - start >= PUD_SIZE) {
-		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn >> PAGE_SHIFT,
 				   canon_pgprot(pud_pgprot))));
 
 		start	  += PUD_SIZE;


