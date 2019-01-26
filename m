Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061EAC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB28C2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fo6MQzTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfAZRuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:50:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42119 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfAZRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:50:01 -0500
Received: by mail-qk1-f195.google.com with SMTP id 68so7237683qke.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 09:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kz5hMqpBJ08DljNyIpwo1FEv4YJJ2z1dbudyzgBlS2I=;
        b=fo6MQzTlsV3XN98LpE0a+WLN6qyq7wVW0CHQxxCEo300ix4DCjuFtv3Rm7GW9jDSm2
         wHV3b6l3p5HGSwilMzi9UtZ13mhTLxPp2KQxB10DTbB9grTCx2zrYm6MB7muGNQcN5nF
         DA27hUH6wOeTVnxm1O63orUM7QMFLkJnVBG+gsctFNI5N0SOk8FLk6EibA1qBD2qcO7w
         SaTJ0BysuC5U9Uo6hVBTmW0qe6GomdAOckBqAmNJTPZ5KsL0JL4ztoxi9uwR/dVIanAr
         NnTyeGS+4MgqtJpXtpAlQi/zm16XKzVzu3OPS05DhaguuXDyhlZ8FwxQUWWLqTTwJzLK
         /DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kz5hMqpBJ08DljNyIpwo1FEv4YJJ2z1dbudyzgBlS2I=;
        b=gvaOMIvLjYtcqSN/0/aZf2ZHXak6f3Un6z/9sbPrYJWi3aa5dk5s0OmF85DU6kutsP
         FtdNg/YuB/yoX18YfCQ7TY8jv0lGonPiQz9eoCcnPR9Y33VYyMKbXSU1bjwhHLyzLxlx
         Tpt4bu4ZzGIXyD76T6wLDokLBK1pG9NeFOuYrKwOdKyXL1kWbtWA4m6lsJPnuoWiKf2g
         C6A1VpQePO7KoZGKcH5MtdfqlJYvU/IFjyGFAz2R99voIHeLQiaKJ0Cs5aUUNsXvGiyf
         u1exKFKQHM9IsBz1ZTcl09lR9xMfxcjIvbl0HOdsqsks9cMzSK+8YmrrO8LeA/Ro5PuP
         KXLA==
X-Gm-Message-State: AJcUukdZO4Sr+4k7+ZvLdlyyQ3E9sMYakwEzNqdozBYUmFLG8yuZH6Uf
        7FIIapjW4Fr1bqoiVUb8S7ykTA==
X-Google-Smtp-Source: ALg8bN4YsXmlgBsQ6A35DJ8ZXxcHAv1sNkqfDykC9BoH00Zd3pgsPSdd06mOK6i6OOJs131gQD8wFg==
X-Received: by 2002:a37:6005:: with SMTP id u5mr13260701qkb.219.1548524999900;
        Sat, 26 Jan 2019 09:49:59 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o135sm13321225qka.47.2019.01.26.09.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 09:49:59 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, nuxi@vault24.org, carnil@debian.org,
        t.glaser@tarent.de, asmadeus@codewreck.org
Subject: [PATCH] x86/kvmclock: set offset for kvm unstable clock
Date:   Sat, 26 Jan 2019 12:49:56 -0500
Message-Id: <20190126174956.22769-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMs may show incorrect uptime and dmesg printk offsets on hypervisors with
unstable clock. The problem is produced when VM is rebooted without exiting
from qemu.

The fix is to calculate clock offset not only for stable clock but for
unstable clock as well, and use kvm_sched_clock_read() which substracts
the offset for both clocks.

This is safe, because pvclock_clocksource_read() does the right thing and
makes sure that clock always goes forward, so once offset is calculated
with unstable clock, we won't get new reads that are smaller than offset,
and thus won't get negative results.

Thank you Jon DeVree for helping to reproduce this issue.

Fixes: 857baa87b642 ("sched/clock: Enable sched clock early")

Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kernel/kvmclock.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index e811d4d1c824..d908a37bf3f3 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -104,12 +104,8 @@ static u64 kvm_sched_clock_read(void)
 
 static inline void kvm_sched_clock_init(bool stable)
 {
-	if (!stable) {
-		pv_ops.time.sched_clock = kvm_clock_read;
+	if (!stable)
 		clear_sched_clock_stable();
-		return;
-	}
-
 	kvm_sched_clock_offset = kvm_clock_read();
 	pv_ops.time.sched_clock = kvm_sched_clock_read;
 
-- 
2.20.1

