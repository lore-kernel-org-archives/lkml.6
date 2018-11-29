Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3724E21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TObjm8fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3724E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbeK3BZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731270AbeK3BZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:25:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245A821104;
        Thu, 29 Nov 2018 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501201;
        bh=5RB+Ge78ujoLgfRhw2DPUxe/6ymReWdIoDcPEcLiNQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TObjm8fdKmxPOrdUH0V/yBOj+7dzj6J+QqmfdGcvRAMBtLLk626gm6L5WohgD2ev7
         vg2dX+/Bq1T4xGG3zHnX2eG2WkMb0bl4/u1VhvlrS9vfo+Tvs+DRcCFFag7/z+EzBg
         HILBw2zuOp8Pu6f3Zmit9vaIpya8gdgRc4886UPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.4 85/86] s390/mm: Check for valid vma before zapping in gmap_discard
Date:   Thu, 29 Nov 2018 15:12:50 +0100
Message-Id: <20181129140116.504805310@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janosch Frank <frankja@linux.ibm.com>

commit 1843abd03250115af6cec0892683e70cf2297c25 upstream.

Userspace could have munmapped the area before doing unmapping from
the gmap. This would leave us with a valid vmaddr, but an invalid vma
from which we would try to zap memory.

Let's check before using the vma.

Fixes: 1e133ab296f3 ("s390/mm: split arch/s390/mm/pgtable.c")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Message-Id: <20180816082432.78828-1-frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/mm/pgtable.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -637,6 +637,8 @@ void gmap_discard(struct gmap *gmap, uns
 		vmaddr |= gaddr & ~PMD_MASK;
 		/* Find vma in the parent mm */
 		vma = find_vma(gmap->mm, vmaddr);
+		if (!vma)
+			continue;
 		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
 		zap_page_range(vma, vmaddr, size, NULL);
 	}


