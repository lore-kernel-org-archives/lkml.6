Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37373C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40FA2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40FA2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbeHGVJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388973AbeHGVJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:44 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E60673EE;
        Tue,  7 Aug 2018 18:54:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Eduardo Valentin <eduval@amazon.com>
Subject: [PATCH 4.14 17/21] intel_idle: Graceful probe failure when MWAIT is disabled
Date:   Tue,  7 Aug 2018 20:51:31 +0200
Message-Id: <20180807172331.744857338@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Len Brown <len.brown@intel.com>

commit a4c447533a18ee86e07232d6344ba12b1f9c5077 upstream.

When MWAIT is disabled, intel_idle refuses to probe.
But it may mis-lead the user by blaming this on the model number:

intel_idle: does not run on family 6 modesl 79

So defer the check for MWAIT until after the model# white-list check succeeds,
and if the MWAIT check fails, tell the user how to fix it:

intel_idle: Please enable MWAIT in BIOS SETUP

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/idle/intel_idle.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1061,7 +1061,7 @@ static const struct idle_cpu idle_cpu_dn
 };
 
 #define ICPU(model, cpu) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&cpu }
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_NEHALEM_EP,		idle_cpu_nehalem),
@@ -1125,6 +1125,11 @@ static int __init intel_idle_probe(void)
 		return -ENODEV;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
+		pr_debug("Please enable MWAIT in BIOS SETUP\n");
+		return -ENODEV;
+	}
+
 	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
 		return -ENODEV;
 


