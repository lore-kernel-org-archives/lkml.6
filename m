Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B333DECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E2F214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E2F214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeIRFgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:36:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46258 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:36:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Xl-0004Pa-Eh; Mon, 17 Sep 2018 18:07:05 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23XV-0002Qk-J6; Mon, 17 Sep 2018 18:07:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:31 +0200
Message-Id: <20180918000546.12552-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23XV-0002Qk-J6;;;mid=<20180918000546.12552-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19XdJ0eDitbob/vOph80lE+8WbVyVyX4C4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 05/20] signal/x86: In trace_mpx_bounds_register_exception add __user annotations
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value passed in to addr_referenced is of type void __user *, so update
the addr_referenced parameter in trace_mpx_bounds_register_exception to match.

Also update the addr_referenced paramater in TP_STRUCT__entry as it again
holdes the same value.

I don't know why this was missed earlier but sparse was complaining when
testing test branch so fix this now.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/include/asm/trace/mpx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/trace/mpx.h b/arch/x86/include/asm/trace/mpx.h
index 7bd92db09e8d..54133017267c 100644
--- a/arch/x86/include/asm/trace/mpx.h
+++ b/arch/x86/include/asm/trace/mpx.h
@@ -11,12 +11,12 @@
 
 TRACE_EVENT(mpx_bounds_register_exception,
 
-	TP_PROTO(void *addr_referenced,
+	TP_PROTO(void __user *addr_referenced,
 		 const struct mpx_bndreg *bndreg),
 	TP_ARGS(addr_referenced, bndreg),
 
 	TP_STRUCT__entry(
-		__field(void *, addr_referenced)
+		__field(void __user *, addr_referenced)
 		__field(u64, lower_bound)
 		__field(u64, upper_bound)
 	),
-- 
2.17.1

