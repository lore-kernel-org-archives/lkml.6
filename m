Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5BAC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39845213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk/sgHPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfBYOM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:12:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBYOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:12:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id g37so1760600plb.5;
        Mon, 25 Feb 2019 06:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6qvnskmMUFW0zbwZtqSVIaahBoxgxJBYahvA+gxuQqQ=;
        b=sk/sgHPaCJ2uJ253Fq4fhleXyTsqf5s/EsYnWLA+ajuefxgNLgQexpg8Zjdiw5yb9k
         nusLP0twPUqfqXSPykHMrDryeakqjsGkWnbGr6lwsx7vfQGeZjm7i4G+j9mXtkQ1bdXm
         xPPymvvRttZmHLPDSRj7xlB8UojpzgNCjQCR8ca7112Ju3LsmogbuRaouXOR2SdpAWee
         PKqr7+JhpJNZLWly9SNtQhriU3QNhoKyoLyrPWKReZ/m+ggl2fA2D0Wo4+2MUBrUG2CC
         +1lf8FbjB8hr70CxI0SDU6oL1ij6Dh0YXprS7XmwreC4YiWITFnoGeMBsWl671vMKWxT
         kYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6qvnskmMUFW0zbwZtqSVIaahBoxgxJBYahvA+gxuQqQ=;
        b=BGH08QtYq2ngi5VLWs6ELHRdNQQ/GgPhxr2U1cmd7NUg5bECbU+KL5KLy9lgMs5Rt7
         L7xD9ciJipvI8EB+yKk71Mq9/lCQuRE2gmXdOfLixfRKyAgr2DBWlmhPLo1CZ4LPWp/A
         F/vQGjzJ3eCeLZMtkIPI0MtxH6xQrNDgNo7tTXvYf6oUUmSNp5M+ws3P0beetRKUMGoc
         ki4Q8+BaNDvVEh2YKUim2U4WCbSltMTiCaijPYboUC4QRQ7qvW1SjPWXmhn3pUOOL1ZK
         TnNP8EJshJhs1a9NmXf9Bp6hI7HNNtRtTuLbKxedjOwxr6OJnyuHchcpzf4E6MeSissH
         ezow==
X-Gm-Message-State: AHQUAubQ7mFifEfZQuAfKlENSiUC6Ox2ibc2a519cBmK3vfG+/PmspDU
        vtpCSTfRt+pfTSJFW6i8A38=
X-Google-Smtp-Source: AHgI3Ib2DWDsgHgTtOMJE+McRUnHCCUSe3BtlnZqM65d0T5WHWj8rTPiZVjfeEhKq4CiQ2o+jmy5WQ==
X-Received: by 2002:a17:902:2ae8:: with SMTP id j95mr20552262plb.292.1551103947913;
        Mon, 25 Feb 2019 06:12:27 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id v15sm16650212pfa.75.2019.02.25.06.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:12:26 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [Update PATCH] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
Date:   Mon, 25 Feb 2019 22:12:14 +0800
Message-Id: <20190225141214.4848-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The max flush rep count of HvFlushGuestPhysicalAddressList hypercall
is equal with how many entries of union hv_gpa_page_range can be populated
into the input parameter page. The origin code lacks parenthesis around
PAGE_SIZE - 2 * sizeof(u64). This patch is to fix it.

Cc: <stable@vger.kernel.org>
Fixs: cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 705dafc2d11a..2bdbbbcfa393 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -841,7 +841,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT (PAGE_SIZE - 2 * sizeof(u64) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
-- 
2.14.4

