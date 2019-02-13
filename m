Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C855AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EDD222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083565;
	bh=qMnelwY010Rk5ajCtSKpBzK8nV4ItgG4WFdaS9Txuo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oy3aGP8KYlBbH97WFMqBv5l22n8r2tD9GdzpHgfymtXi3/ImFUIXvNgCwonPEpqb5
	 OTDevAHpo78ESS/PZ7KEz8z/U30Q9HgdAG6JLIhoISumLIs517GE9cYH+kbO7e/L3L
	 0Ys0VZRyn/bJ8BkhFWbS0erp3Q/4cZkK6axXEga8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406370AbfBMSqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbfBMSqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13ED20811;
        Wed, 13 Feb 2019 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083561;
        bh=qMnelwY010Rk5ajCtSKpBzK8nV4ItgG4WFdaS9Txuo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMcO+5+GramXaFruw6i2B9IwD5Jk2ouJHmcm8sSn4hZuOZHnwll4lHYNaLPxtzDI3
         J97mH80wUd1u8gOLHtBG2wLmvX8Ckm4hF8mwlUf90ljHZjKmelP6ZPNbO71nl7znKT
         i2VlIBfafiQiLbcrKlyuFQwgu14kANX5dZ8v4Pto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 33/50] powerpc/papr_scm: Use the correct bind address
Date:   Wed, 13 Feb 2019 19:38:38 +0100
Message-Id: <20190213183658.371944412@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver O'Halloran <oohall@gmail.com>

commit 5a3840a470c41ec0b85cd36ca80370330656b163 upstream.

When binding an SCM volume to a physical address the hypervisor has the
option to return early with a continue token with the expectation that
the guest will resume the bind operation until it completes. A quirk of
this interface is that the bind address will only be returned by the
first bind h-call and the subsequent calls will return
0xFFFF_FFFF_FFFF_FFFF for the bind address.

We currently do not save the address returned by the first h-call. As a
result we will use the junk address as the base of the bound region if
the hypervisor decides to split the bind across multiple h-calls. This
bug was found when testing with very large SCM volumes where the bind
process would take more time than they hypervisor's internal h-call time
limit would allow. This patch fixes the issue by saving the bind address
from the first call.

Cc: stable@vger.kernel.org
Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/papr_scm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -43,6 +43,7 @@ static int drc_pmem_bind(struct papr_scm
 {
 	unsigned long ret[PLPAR_HCALL_BUFSIZE];
 	uint64_t rc, token;
+	uint64_t saved = 0;
 
 	/*
 	 * When the hypervisor cannot map all the requested memory in a single
@@ -56,6 +57,8 @@ static int drc_pmem_bind(struct papr_scm
 		rc = plpar_hcall(H_SCM_BIND_MEM, ret, p->drc_index, 0,
 				p->blocks, BIND_ANY_ADDR, token);
 		token = ret[0];
+		if (!saved)
+			saved = ret[1];
 		cond_resched();
 	} while (rc == H_BUSY);
 
@@ -64,7 +67,7 @@ static int drc_pmem_bind(struct papr_scm
 		return -ENXIO;
 	}
 
-	p->bound_addr = ret[1];
+	p->bound_addr = saved;
 
 	dev_dbg(&p->pdev->dev, "bound drc %x to %pR\n", p->drc_index, &p->res);
 


