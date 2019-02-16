Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D688C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1293222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FA8v36pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394520AbfBPEsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:48:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43948 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbfBPEsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:48:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so13451624qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 20:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4Ns8f1NOlbFa+bDM/2kc7cxt+HpGYEvJ8eNA1rANFU0=;
        b=FA8v36pl4Mv9lPhmby28TNRK60VyZdJkbx2Jcdsqj+tJv5sa07JsCytUigA4b/Ffpy
         r/kfBaE11V3b4nBX+LlV+AEqlHsdMi0oOh/fNYIZRFB0VAtBjL5j1nXf2+l+xtH964s2
         /RQWk6XGU1y+z5Stkoiqj4irKSmJmh3fct/23Ha0hEPGxuBnBYWlbtG2YslH0MmFiVGV
         MlS8oCkQjMLm1KN4KPwhqTEaF3kMAPP/jGpG4x9L19CPaLbn3cGG9sBFGTqvoCZbwsuf
         CnsC5HPeneACMGQ2gB4DLQ8AdAD32xA+Ysb/vlOj0XuoIvPREREg3YFeJsosSA9uwORh
         R0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Ns8f1NOlbFa+bDM/2kc7cxt+HpGYEvJ8eNA1rANFU0=;
        b=kjnxfQHdHPPRzuSuoztSaT+z96KRxv35o9vXEaNkiwepdSc5lwmGWe1bUpI63LrdvM
         Dv9VSfeDDkL0bdMh30DYZ67evz7ebgttDlBr8F/ggozqTSshZMcNoyghuqfZHUVucSgB
         rrUEAfCAUOk9IIccBOdQ5iOHh1Qb0mjAch/VO8QgFVDwf+JkJVoXRNYkycOSIKebxiyp
         Rj0Zc7rpbOVxDO4JXfiGcA06btP7JguzyRfZ+7aqFOzOcTeLzTQjYMc0B1QRP0Tlhfyo
         +lQu1TIl+wed8dndWdn75TZ3WYTJ89hZMx8c3snKq2jbIgOJPhecQVo8OAmrLEli/COM
         tO5Q==
X-Gm-Message-State: AHQUAuZOdfARSzdurMefvXbspTRVyNt/uyjv/D8gO7Xja9J0aCATEJBK
        MP9EwjKOfvVevfNu2zcdiBNgJQ==
X-Google-Smtp-Source: AHgI3Ib08PBuCodER4SLqWjIsyy4V7OygiJ7Fg6K/4bplyHXyUSAJoOegs5pXAusGu78AOsO3K2d4g==
X-Received: by 2002:a0c:9877:: with SMTP id e52mr9599309qvd.151.1550292489136;
        Fri, 15 Feb 2019 20:48:09 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a15sm3897809qtj.96.2019.02.15.20.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:48:08 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     will.deacon@arm.com, catalin.marinas@arm.com
Cc:     andreyknvl@google.com, aryabinin@virtuozzo.com,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/mm: skip hwasan callbacks for pgtable walker
Date:   Fri, 15 Feb 2019 23:47:35 -0500
Message-Id: <20190216044735.32315-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page table walkers trigger soft lockups below with KASAN_SW_TAGS outline
mode on a large ThunderX2 system, because there is too much overhead to
call check_memory_region() for every memory access where it needs to
dereference every byte of the corresponding KASAN shadow address for the
correct tag.

[   76.531328] watchdog: BUG: soft lockup - CPU#65 stuck for 23s! [swapper/0:1]
[   76.538372] Modules linked in:
[   76.541433] CPU: 65 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc6+ #62
[   76.557697] pstate: 60400009 (nZCv daif +PAN -UAO)
[   76.562491] pc : check_memory_region+0x64/0x94
[   76.566934] lr : __hwasan_load8_noabort+0x20/0x2c
[   76.571633] sp : 7eff808ba0247ca0
[   76.574943] x29: 7eff808ba0247cc0 x28: ffff068cef720000
[   76.580256] x27: ffff080000000000 x26: 0060000000000793
[   76.585568] x25: ffff068d00000000 x24: ffff800003537b98
[   76.590880] x23: 7eff808ba0247e08 x22: 0000000000000000
[   76.596192] x21: 7eff808ba0247e08 x20: 0000000000000008
[   76.601503] x19: ffff1000100a8d64 x18: 0000000000000000
[   76.606814] x17: 0000000001000100 x16: 0000000000000000
[   76.612125] x15: ffff100013805578 x14: ffff100014085000
[   76.617437] x13: 0000000030373a2e x12: 00f0000000000793
[   76.622749] x11: ffff808ba0247e0f x10: ffff0808ba0247e0
[   76.628060] x9 : ffff0808ba0247e0 x8 : 000000000000007e
[   76.633371] x7 : 0000000000000000 x6 : 0000000000000002
[   76.638682] x5 : 0000000000000000 x4 : 00e0000000000793
[   76.643994] x3 : ffff1000100a8d64 x2 : 0000000000000000
[   76.649305] x1 : 0000000000000008 x0 : 7eff808ba0247e08
[   76.654617] Call trace:
[   76.657066]  check_memory_region+0x64/0x94
[   76.661162]  __hwasan_load8_noabort+0x20/0x2c
[   76.665519]  note_page+0x84/0x708
[   76.668833]  walk_pgd+0x174/0x258
[   76.672147]  ptdump_check_wx+0x90/0xfc
[   76.675894]  mark_rodata_ro+0x38/0x44
[   76.679557]  kernel_init+0x48/0x180
[   76.683045]  ret_from_fork+0x10/0x18

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/mm/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 849c1df3d214..4b9a7a50faaf 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -12,3 +12,9 @@ KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n
+
+ifdef CONFIG_KASAN_SW_TAGS
+ifdef CONFIG_KASAN_OUTLINE
+KASAN_SANITIZE_dump.o		:= n
+endif
+endif
-- 
2.17.2 (Apple Git-113)

