Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7FECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C852148E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU+kD0p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C852148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbeKIHsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbeKIHsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:48:00 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C4D20989;
        Thu,  8 Nov 2018 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715028;
        bh=Yu5faCKIDDs5zOjbfuH6L83JWni1bzQkvUmlBQsFSQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MU+kD0p6DozDnwDKHPctXJ4hQuaGK08KM6/91n3s8TqUqGS6yfFYKKCjmBrTLvSYQ
         oNvBTPOpmqvsYyfQqyfbTIC5abQ5B15XQ5qLUsGc9DPjhD+4JAeKLRJOxT610Lbqlj
         h7bXhnUQ6sK0QHoBKpam0QQpBMR4osbql0iB38cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhimin Gu <kookoo.gu@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 30/34] x86, hibernate: Fix nosave_regions setup for hibernation
Date:   Thu,  8 Nov 2018 13:52:59 -0800
Message-Id: <20181108215140.736117265@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
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

From: Zhimin Gu <kookoo.gu@intel.com>

commit cc55f7537db6af371e9c1c6a71161ee40f918824 upstream.

On 32bit systems, nosave_regions(non RAM areas) located between
max_low_pfn and max_pfn are not excluded from hibernation snapshot
currently, which may result in a machine check exception when
trying to access these unsafe regions during hibernation:

[  612.800453] Disabling lock debugging due to kernel taint
[  612.805786] mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 Bank 6: fe00000000801136
[  612.814344] mce: [Hardware Error]: RIP !INEXACT! 60:<00000000d90be566> {swsusp_save+0x436/0x560}
[  612.823167] mce: [Hardware Error]: TSC 1f5939fe276 ADDR dd000000 MISC 30e0000086
[  612.830677] mce: [Hardware Error]: PROCESSOR 0:306c3 TIME 1529487426 SOCKET 0 APIC 0 microcode 24
[  612.839581] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
[  612.846394] mce: [Hardware Error]: Machine check: Processor context corrupt
[  612.853380] Kernel panic - not syncing: Fatal machine check
[  612.858978] Kernel Offset: 0x18000000 from 0xc1000000 (relocation range: 0xc0000000-0xf7ffdfff)

This is because on 32bit systems, pages above max_low_pfn are regarded
as high memeory, and accessing unsafe pages might cause expected MCE.
On the problematic 32bit system, there are reserved memory above low
memory, which triggered the MCE:

e820 memory mapping:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d160cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d160d000-0x00000000d1613fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d1614000-0x00000000d1a44fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d1a45000-0x00000000d1ecffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d1ed0000-0x00000000d7eeafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d7eeb000-0x00000000d7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d8000000-0x00000000d875ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d8760000-0x00000000d87fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d8800000-0x00000000d8fadfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d8fae000-0x00000000d8ffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d9000000-0x00000000da71bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000da71c000-0x00000000da7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000da800000-0x00000000dbb8bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dbb8c000-0x00000000dbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df1fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041edfffff] usable

Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
This fix does not impact 64bit system because on 64bit max_low_pfn
is the same as max_pfn.

Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1258,7 +1258,7 @@ void __init setup_arch(char **cmdline_p)
 	x86_init.hyper.guest_late_init();
 
 	e820__reserve_resources();
-	e820__register_nosave_regions(max_low_pfn);
+	e820__register_nosave_regions(max_pfn);
 
 	x86_init.resources.reserve_resources();
 


