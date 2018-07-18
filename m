Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDE5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBC52075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="INTKYZO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBC52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbeGRCMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:12:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52943 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRCMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:12:09 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so1885205itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 18:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e6iQQiub3CqZpaeDplnkewPha5KTya4Tkoh2k4AIatQ=;
        b=INTKYZO5FQ7HUhkhLL5zuxgK4NkFtt+bA5DLPEPIczYEmn57zqDCvMj2qjKJkNxmi8
         nMBLDPj6b2MzbeBUBVZaHPdsIfaOR+TrFcM7r9HHecuqDwvdbjQsTbXAx0/Y3wGTAyQO
         hD7yy7OrRDq7XuJuW6plclz5xUW4mAN3cQlWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e6iQQiub3CqZpaeDplnkewPha5KTya4Tkoh2k4AIatQ=;
        b=LCaSsw8WEmsq9O486hGZqzozgBSsp4VcxmHnzWeDoSFJP9zyxxZTPVFT7eRXEPLAMi
         pYFRmL00+4kkCVxIWoKTOL+61HxFRK4oWO6PP1BYpqRq13CZhzBMpLuT1aKYg9ATs/6+
         qvx5HwOyKnuVVwypc0hLFYaWFRMdbedXNd5Iur75egfiZjrKQdeEFwX6c95Rtcx3/bnT
         VLBFDpHCGRMz7A9MKkJ0KNTic64bSiBTU6QJnxzrKR0Hr/lydJAkt6+0OB0ObbSseISe
         ND5gVo/M4xGERKy56DKm1WKekp4dlxSp0DOPhNGJYVp8mPQdnf+Dl5U56fJxXHUV5wrE
         hKbg==
X-Gm-Message-State: AOUpUlHoe3kknLY+ZfAL80cFHPgEAgGl1mZj8vxGI2XpSQSRQR6v/jx/
        t3KN0AhSSCKP29lbOjHp6kla1tw4D0M=
X-Google-Smtp-Source: AAOMgpfCMvEbLFOOzC81yCgdvo14ksjAbVmJ0tJsrqAyw6FzMFjzKYcf8vZr/U/m8PXJZD+9dmqnWw==
X-Received: by 2002:a24:1a11:: with SMTP id 17-v6mr436166iti.66.1531877808080;
        Tue, 17 Jul 2018 18:36:48 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id p21-v6sm1124251iog.70.2018.07.17.18.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 18:36:47 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH 0/2] turbostat: Improve support for AMD Zen CPUs (RAPL, CPUID)
Date:   Tue, 17 Jul 2018 21:36:40 -0400
Message-Id: <20180718013642.10344-1-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the documentation provided in AMD's Open-Source
Register Reference For AMD Family 17h Processors:
https://support.amd.com/TechDocs/56255_OSRR.pdf

I've added support for reading Cores and Package energy usage from AMD's
"RAPL" MSRs. In order to correctly detect the AMD processor generation,
I've also had to update the CPUID code to handle AMD's extended family
field.

Here's some example output from my (idle) Ryzen 3 2200G test system:

turbostat version 17.06.23 - Len Brown <lenb@kernel.org>
CPUID(0): AuthenticAMD 13 CPUID levels; family:model:stepping 0x17:11:0 (23:17:0)
CPUID(1): SSE3 MONITOR - - - TSC MSR - -
CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
CPUID(7): No-SGX
RAPL: 364 sec. Joule Counter Range, at 180 Watts
cpu2: POLL: CPUIDLE CORE POLL IDLE
cpu2: C1: ACPI FFH INTEL MWAIT 0x0
cpu2: C2: ACPI IOPORT 0x414
cpu2: cpufreq driver: acpi-cpufreq
cpu2: cpufreq governor: schedutil
cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000977 sec.)
Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	C1	C2	C1%	C2%	CorWatt	PkgWatt
-	-	33	2.20	1485	3500	5073	1263	3694	2.75	95.12	0.03	3.29
0	0	33	2.20	1483	3500	1213	354	886	2.96	94.89	0.01	3.29
1	1	25	1.67	1474	3500	907	197	682	1.55	96.80	0.01
2	2	33	2.24	1478	3500	1674	450	1175	4.16	93.70	0.01
3	3	40	2.67	1501	3500	1279	262	951	2.33	95.07	0.01


Calvin Walton (2):
  turbostat: Read extended processor family from CPUID
  turbostat: Add support for AMD Fam 17h (Zen) RAPL

 tools/power/x86/turbostat/turbostat.c | 184 ++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 28 deletions(-)

-- 
2.18.0

