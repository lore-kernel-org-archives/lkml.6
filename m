Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C94AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E770D20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E770D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeJWWmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeJWWmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE7CDB2CD;
        Tue, 23 Oct 2018 14:18:42 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 096AC76510;
        Tue, 23 Oct 2018 14:18:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] efi: Fix debugobjects warning on efi_rts_work
Date:   Tue, 23 Oct 2018 10:18:27 -0400
Message-Id: <1540304307-2806-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 23 Oct 2018 14:18:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi
page fault handler") converted efi_rts_work from an auto variable to a
global variable. However, when submitting the work, INIT_WORK_ONSTACK()
was still used causing the following complaint from debugobjects:

ODEBUG: object 00000000ed27b500 is NOT on stack 00000000c7d38760,
but annotated.

Change the macro to just INIT_WORK() to eliminate the warning.

Fixes: 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault handler")

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/firmware/efi/runtime-wrappers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index a19d845..8903b9c 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -67,7 +67,7 @@
 	}								\
 									\
 	init_completion(&efi_rts_work.efi_rts_comp);			\
-	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
+	INIT_WORK(&efi_rts_work.work, efi_call_rts);			\
 	efi_rts_work.arg1 = _arg1;					\
 	efi_rts_work.arg2 = _arg2;					\
 	efi_rts_work.arg3 = _arg3;					\
-- 
1.8.3.1

