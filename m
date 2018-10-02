Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AEEC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6902083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6902083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJBUKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJBUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:04 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2EB05266;
        Tue,  2 Oct 2018 13:26:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 023/228] s390/mm: correct allocate_pgste proc_handler callback
Date:   Tue,  2 Oct 2018 06:22:00 -0700
Message-Id: <20181002132500.628387158@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 5bedf8aa03c28cb8dc98bdd32a41b66d8f7d3eaa ]

Since proc_dointvec does not perform value range control,
proc_dointvec_minmax should be used to limit value range, which is
clearly intended here, as the internal representation of the value:

unsigned int alloc_pgste:1;

In fact it currently works, since we have

      mm->context.alloc_pgste = page_table_allocate_pgste || ...

... since commit 23fefe119ceb5 ("s390/kvm: avoid global config of vm.alloc_pgste=1")

Before that it was

       mm->context.alloc_pgste = page_table_allocate_pgste;

which was broken. That was introduced with commit 0b46e0a3ec0d7 ("s390/kvm:
remove delayed reallocation of page tables for KVM").

Fixes: 0b46e0a3ec0d7 ("s390/kvm: remove delayed reallocation of page tables for KVM")
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/mm/pgalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -28,7 +28,7 @@ static struct ctl_table page_table_sysct
 		.data		= &page_table_allocate_pgste,
 		.maxlen		= sizeof(int),
 		.mode		= S_IRUGO | S_IWUSR,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &page_table_allocate_pgste_min,
 		.extra2		= &page_table_allocate_pgste_max,
 	},


