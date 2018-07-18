Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD0DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502CF2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="axRU5Aib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502CF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeGRXHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:07:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35681 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRXHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:07:10 -0400
Received: by mail-it0-f67.google.com with SMTP id q20-v6so6638799ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x5dA3v3I4Rm8HWCZJ+rRo3s36abrnsb07aqbqkvben8=;
        b=axRU5AibtMkZNHoWc63R5X4xYO1f0tBh1dUrDKAe1XXqWj2WTJK7WWWvtvqYTOAGUT
         K5O5aCs1xKzZthRm93N8kYTysT0cvbvyoguKhUVwiKCpME6/cPEslyympeDEYVu4iIgH
         FjA9etv1ycDoYnJvTdluhAghadXnFFfAe+WSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x5dA3v3I4Rm8HWCZJ+rRo3s36abrnsb07aqbqkvben8=;
        b=BIsOzWAbRNThP07bOoixdkHuSImz7CBhWFHEouUHqGJLhlD8o+YLhtZuUuyEHLgzgZ
         4+asJJ2UU5ICTE9S9sE6wINj0FYSndvlv7fU6QgFWQ+Q/AxljIasDUbnwmdL+xZMKa83
         raHosKaZmar2fo82XEN4UrJGtstvLugeydMI4VR9Ai7VubVcKA/DGMoEDWUARqhoh6xw
         1vb8nMD49JMaUd6kRQVrE/LzKajYv7/N6G6WnjqQThsumjI7UEEP4rnV8FdebgerinMX
         c2sK99pMmjypSbvr2Cbcl5bdVq53r9+0DOIq36q+DnNxg3NegwejrkmIEuy+zjPdjvwR
         o9DA==
X-Gm-Message-State: AOUpUlGfQ/TAX1+J5WFyp3JldD6FXvSz1G5eqjcu5dfdP4VCCQoRALAe
        ZU5LKmDY8cTHZ9JhpsMxIA6DIUUZ8C76VA==
X-Google-Smtp-Source: AAOMgpcZxA5VMA96CdMZzmitMO606+Vcgn6j8liuFOoh6XwNdfZiH5FXFqVSSzkeh/0hBLYy7pQ/oA==
X-Received: by 2002:a24:738a:: with SMTP id y132-v6mr3694036itb.137.1531952830082;
        Wed, 18 Jul 2018 15:27:10 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id j11-v6sm2060803itj.6.2018.07.18.15.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:27:09 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH 0/2] turbostat: Improve support for AMD Zen CPUs (RAPL, CPUID) (Resend)
Date:   Wed, 18 Jul 2018 18:26:54 -0400
Message-Id: <20180718222656.11795-1-calvin.walton@kepstin.ca>
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

I've resent this including the linux-pm mailing list per Rafael's
suggestion (I wasn't sure who to send this to initially - maybe the
MAINTAINERS file should be updated so get_maintainer.pl gives better
results). The patches are unchanged from my previous submission.

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

