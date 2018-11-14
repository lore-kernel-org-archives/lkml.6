Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD68C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1662243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Etkmskss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1662243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeKOEAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:00:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41649 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOEAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:00:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so8275245pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tnZwtrfeIUnwSLpePAskWrTsX9/DkfDA/SpLBYEMRCI=;
        b=EtkmskssHmg/ybwGqTO6Q8uNrMj7Ek+1vALJlR+v9S1NCcWRFFg9ZhTfmcRwOG7Rom
         T/YRErv3HhlCx8wb4dwXsXjzt/dfUlYPDLDpn0Pwk0qrwmgs4nsAO8D6u4v3Ls27DP3Y
         B+GSAs+M0qoMAyB8PTZoRK7rqPK7sPOY7ZPUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tnZwtrfeIUnwSLpePAskWrTsX9/DkfDA/SpLBYEMRCI=;
        b=NnStwprG+oSlZEeWGsEsCRbWl40eBidZLqIDX7kafzs58kI9FExEsEvZdFDQItpvjk
         JPwQoNdVgFwRqQ7TMkUPPG857rrNvxjgWPseJDmGe4vqxkp/ohdjtU7aSugIYwaILzrn
         Hafw3Hxv1m0fWiODvssRGS7azgd3awt88OrZWFLgzlAzYhuMdM1O+nry5CPUljSmBAwm
         OyCpaUGsUQTVibNUD8iTQBlHRtQACRQOx7LNLpfx+JUYkUO0lVe52lFzgXXHPpLL3PGq
         cc59GAfJHr3braFj2Lwn88iixmuQ2AiqGOkRrP0Of27PcDZZA1fZMGCyifGMclrEgtCw
         rdUQ==
X-Gm-Message-State: AGRZ1gIHl8WnSPsOBACW8rtGJiXYyn6WEIn9TGathcKHIHnPni10LjNL
        BBQ51Z/omOiOy9Mza2M5iBhh2VZ9zowu4g==
X-Google-Smtp-Source: AJdET5djZIBQPnUdHtkKdOPP7fYjrPRiK2YPDtUe1kZNHLfHF2T253lvNARoegY1Z6xkJxCrrvmdSg==
X-Received: by 2002:a63:2a4a:: with SMTP id q71mr2649533pgq.374.1542218157974;
        Wed, 14 Nov 2018 09:55:57 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id i2-v6sm21301738pgq.35.2018.11.14.09.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:55:57 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Waiman Long <longman@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] efi: Fix debugobjects warning on efi_rts_work
Date:   Wed, 14 Nov 2018 09:55:40 -0800
Message-Id: <20181114175544.12860-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

The commit 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi
page fault handler") converted efi_rts_work from an auto variable to a
global variable. However, when submitting the work, INIT_WORK_ONSTACK()
was still used causing the following complaint from debugobjects:

ODEBUG: object 00000000ed27b500 is NOT on stack 00000000c7d38760,
but annotated.

Change the macro to just INIT_WORK() to eliminate the warning.

Fixes: 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault handler")
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index a19d845bdb06..8903b9ccfc2b 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -67,7 +67,7 @@ struct efi_runtime_work efi_rts_work;
 	}								\
 									\
 	init_completion(&efi_rts_work.efi_rts_comp);			\
-	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
+	INIT_WORK(&efi_rts_work.work, efi_call_rts);			\
 	efi_rts_work.arg1 = _arg1;					\
 	efi_rts_work.arg2 = _arg2;					\
 	efi_rts_work.arg3 = _arg3;					\
-- 
2.17.1

