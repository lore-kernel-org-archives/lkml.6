Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DABDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106F520645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106F520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeIHB6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbeIHB6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:17 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35427F07;
        Fri,  7 Sep 2018 21:15:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 035/145] powerpc/nohash: fix pte_access_permitted()
Date:   Fri,  7 Sep 2018 23:08:21 +0200
Message-Id: <20180907210907.350519233@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 810e9f86f36f59f1d6f6710220c49afe0c705f38 upstream.

Commit 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper
for other platforms") replaced generic pte_access_permitted() by an
arch specific one.

The generic one is defined as
(pte_present(pte) && (!(write) || pte_write(pte)))

The arch specific one is open coded checking that _PAGE_USER and
_PAGE_WRITE (_PAGE_RW) flags are set, but lacking to check that
_PAGE_RO and _PAGE_PRIVILEGED are unset, leading to a useless test
on targets like the 8xx which defines _PAGE_RW and _PAGE_USER as 0.

Commit 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted
for hugetlb access check") replaced some tests performed with
pte helpers by a call to pte_access_permitted(), leading to the same
issue.

This patch rewrites powerpc/nohash pte_access_permitted()
using pte helpers.

Fixes: 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper for other platforms")
Fixes: 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/nohash/pgtable.h |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -51,17 +51,14 @@ static inline int pte_present(pte_t pte)
 #define pte_access_permitted pte_access_permitted
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
-	unsigned long pteval = pte_val(pte);
 	/*
 	 * A read-only access is controlled by _PAGE_USER bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
-	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
-
-	if (write)
-		need_pte_bits |= _PAGE_WRITE;
+	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
+		return false;
 
-	if ((pteval & need_pte_bits) != need_pte_bits)
+	if (write && !pte_write(pte))
 		return false;
 
 	return true;


