Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0907FC65BD1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C072085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LueO4gYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C072085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJHM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:27:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44490 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJHM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:27:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so7261128pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 22:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Grlj/FQ9cweOqOjxqFN8YjGHsbjQMb8oVhL53KJP91s=;
        b=LueO4gYu8eTAVKO5pC+hXKqU+PwbA+dyP3f85qe+6Pwl6PLUnPUGcc/Oig+L0iM85Y
         dnnNo8/YlCNPZmy+BZdKFU+YSB1KNsHma/ppUPo3Ad15gRMqzbDMvStL0CYrJtER3SO8
         vI6sGxs20msGOGIkTJQongebFH/n4i9tTQXSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Grlj/FQ9cweOqOjxqFN8YjGHsbjQMb8oVhL53KJP91s=;
        b=PS3Og65MSyw5ZIN3cDQwsuAeUbN3xvZdrPUDLDmjchoSyUPA4PL/QLpLOKjo88B1J2
         BwRQwuezvjOHCOflEpzsPx2buvy9Cdm8nyk+i9dbKhNhv98pAf4RqinWXNgd7ujN7io9
         U4o59iRnpumb9EFE2e9DdddrG0Az1nDyO0Ky2+Txz7WqshQIfQvxQKg3OLqQlMEAxdbV
         aMW5Re/PfcvjBgw9kcsCMbpNReKz0RkjjuXT9lBuOemm7fQNJFSUEg18/D0l8IBZRcv/
         7MnKRJr455lCkBTAL/V9cfop0XDUlPreQX+Z/+sVQndv03BS84JLpO8FBj5LttUmvrut
         DfIw==
X-Gm-Message-State: ABuFfoj5jNrkBAwHospG974NWxUTv2rSVyI8G1pBGtrzePQ0Sa40mkZX
        FmsyXassZ2Zy39VUBKdE9Nuj9g==
X-Google-Smtp-Source: ACcGV63MotLBvT/8OTUm2dHfTG373Fg5rd0mlEqyGgWVQXtcRFN7f6hAWDMnaq0/SSSbQfmxzmr3AA==
X-Received: by 2002:a63:f64f:: with SMTP id u15-v6mr19907539pgj.258.1538975863369;
        Sun, 07 Oct 2018 22:17:43 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1875919pfi.137.2018.10.07.22.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Oct 2018 22:17:42 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 5/6] parisc: wire up rseq system call
Date:   Mon,  8 Oct 2018 10:46:40 +0530
Message-Id: <1538975801-13735-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 4e85293..4334bb7 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -349,4 +349,5 @@
 347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
 348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
 349     common  statx                           sys_statx
-350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
\ No newline at end of file
+350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+351	common	rseq				sys_rseq			compat_sys_rseq
-- 
1.9.1

