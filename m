Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871CCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4593C208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nXbP/mKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeH0Wqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37808 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeH0Wqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8-v6so10126pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=q8pTD7qGJnI8ElvmN5WMBhM58Y9r9Xo6Cc36+rVicmo=;
        b=nXbP/mKeb2yrB2AzA0zDpYjw1S2pWaq9/qIFkgAb3tHLXFGROIhtTTUaOeuKeF5O/Q
         PKpXlzXxA32yIOLd1myTKzBhWjhDZuijTS3AydUorGYoBTkL/dqMvx62IX5eRuIM5cOE
         hcgxhBlGoB3CNXJbyq/iu6vbYxS+OtcGZXdSf0cr2uYeIuKkF/JTGa+UkRFahEFzbSCm
         aI7UzTNB4XkxQb/I86KLZKRtSVPya8CtBTYhqfpCP42Ep7oyZcUOjVPGfaq4kGQ/xD5J
         pLNZxnrXrlwkurGx5lM/vbaZ1jqscZVGmfCCJ5NtVVw0ogNswInJY5ochYs4hMw3FgTt
         e55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=q8pTD7qGJnI8ElvmN5WMBhM58Y9r9Xo6Cc36+rVicmo=;
        b=nqf79zszNDV/KA4cALA8I3ILCHJ2kkGWKy0LmT0gOZT0T/6JWZKel3wCtrWKxQ19vy
         Gy+s/W2t9tKvYcN1+YnKST51ySx4IgnXDel0DJ0wFrCEdMNvMaUde7Q5PEXiKGMNv07x
         BKdXVwl+0DxIxhD0npEJOJV66s25bSfael8mlzkoG/xbQ3MXMXkjyCiMtkwM153ty3zx
         me4vaXm8X0IM9/GEudadP388Y3fIsnE98JXQtxM9pqt/69Nz6TkviBhquycMILjNN7Fc
         38qjR1hxJ2vUwxeOHhanQ5DOfJ7rnTyiZkB7Fu3AlV5jUSqDM6VIqKn2TExTVqGK5amK
         8mdw==
X-Gm-Message-State: APzg51Azbb7rkKak1JDi3FC+9Og0Un3DERp95GiEuaPAfxxug0J5osB5
        1qnXu2GQ32gq0ID7ROAC7an1yQ==
X-Google-Smtp-Source: ANB0VdY8jBSCPJUuHlsh++DKwylQhHnDPUaXaAuPJWQVlFnNOLprB3Oz4xPLTv1qedr229lsr/e+FA==
X-Received: by 2002:a63:144b:: with SMTP id 11-v6mr13052808pgu.219.1535396332796;
        Mon, 27 Aug 2018 11:58:52 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m15-v6sm27099178pfj.171.2018.08.27.11.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:51 -0700 (PDT)
Subject: [PATCH 7/8] RISC-V: Comment on the TLB flush in smp_callin()
Date:   Mon, 27 Aug 2018 11:42:42 -0700
Message-Id: <20180827184243.25344-8-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827184243.25344-1-palmer@sifive.com>
References: <20180827184243.25344-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, atish.patra@wdc.com,
        dmitriy@oss-tech.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        jeremy.linton@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't readily apparent from reading the code.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/smpboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 5437a04babcd..953bc540207d 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -107,6 +107,8 @@ asmlinkage void __init smp_callin(void)
 	trap_init();
 	notify_cpu_starting(smp_processor_id());
 	set_cpu_online(smp_processor_id(), 1);
+	/* Remote TLB flushes are ignored while the CPU is offline, so emit a local
+	 * TLB flush right now just in case. */
 	local_flush_tlb_all();
 	local_irq_enable();
 	preempt_disable();
-- 
2.16.4

