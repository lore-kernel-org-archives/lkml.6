Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D4C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A00920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeJNXns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:43:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35733 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727157AbeJNXLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:46 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cm-Hw; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000MZ-6a; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, rjw@rjwysocki.net,
        "Thomas Gleixner" <tglx@linutronix.de>, hpa@zytor.com,
        len.brown@intel.com, "Dou Liyang" <douly.fnst@cn.fujitsu.com>,
        "Li RongQing" <lirongqing@baidu.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.592973187@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 164/366] x86/acpi: Prevent X2APIC id 0xffffffff from
 being accounted
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

commit 10daf10ab154e31237a8c07242be3063fb6a9bf4 upstream.

RongQing reported that there are some X2APIC id 0xffffffff in his machine's
ACPI MADT table, which makes the number of possible CPU inaccurate.

The reason is that the ACPI X2APIC parser has no sanity check for APIC ID
0xffffffff, which is an invalid id in all APIC types. See "Intel® 64
Architecture x2APIC Specification", Chapter 2.4.1.

Add a sanity check to acpi_parse_x2apic() which ignores the invalid id.

Reported-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180412014052.25186-1-douly.fnst@cn.fujitsu.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -227,6 +227,11 @@ acpi_parse_x2apic(struct acpi_subtable_h
 
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
+
+	/* Ignore invalid ID */
+	if (apic_id == 0xffffffff)
+		return 0;
+
 #ifdef CONFIG_X86_X2APIC
 	/*
 	 * We need to register disabled CPU as well to permit

