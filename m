Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F034C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17E0208E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7CaXPW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17E0208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933881AbeGFR2m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:28:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41685 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933090AbeGFR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:28:39 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so10576203qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6Fkve6Q13jFjpxemJYxQElXnD4OKMhoNo62lFkcseoc=;
        b=P7CaXPW4fwmN0Pi2zAPVNnZYADQBzkqo8/z13VqFi6wRTmplzt6AZRu54WLJxoISO8
         zTpPA7lc7csA+5V7XKnwdEwtYJu1Pz6pZvMFvTkYkCm9EmgxnJYr7/P39sMRxzpkY9zH
         xwj2SDY9ZTVS1C+80fdVBfJE/VF6ga6seIaDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Fkve6Q13jFjpxemJYxQElXnD4OKMhoNo62lFkcseoc=;
        b=V8CUjRCfChbKxYePXuyyuPRJj4Wb9YesCVwZeEe8u1lovJvzMJGYG0se9L5G9XGUbw
         2FLosue6HUtgnJwp6tMe7XZfEWb00CbIdA0Y5nO7UrFT7F7gV8vuG0T1Fd9N9+C8jHFE
         TZKIG+xvjZ780WWVSR4j36olg3g5cg0w+90JzeGKV7/Bi3CUcjKiscyOvot+eIsK6ytJ
         fjI6In08bwWfxVLWWSFdJBX2PBxiOvH1MuU4wl162qpteUmF1RfNuvYNQ5z9isK5J8r6
         MR5kC7kpwIkXOluNEvxM0UyytcJzWRvCJrenOgmOwtGSFN39Ife1Eu+XFEJJYDygWyJR
         QjdQ==
X-Gm-Message-State: APt69E1kJDmyMcZ65Ist3YLm7urthBOQ62zIC+4EjszEM392CQB9ZtLt
        4i05CdE1nWatA+VL5pn5M+DAg5cUl7Y=
X-Google-Smtp-Source: AAOMgpdpXyqCrU8mlz5EOGnzvPpzyuK8EafeTePn8YP2CZhUsiWLxg+whkLTK9pJRxXE+PVmRZq8jg==
X-Received: by 2002:ac8:37b4:: with SMTP id d49-v6mr10225788qtc.369.1530898118348;
        Fri, 06 Jul 2018 10:28:38 -0700 (PDT)
Received: from workstation.celeiro.br ([138.204.25.70])
        by smtp.gmail.com with ESMTPSA id g84-v6sm5709500qkb.91.2018.07.06.10.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 10:28:37 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, puck.chen@hisilicon.com,
        lee.jones@linaro.org, john.stultz@linaro.org, ltp@lists.linux.it,
        lkft-triage@lists.linaro.org
Subject: [PATCH] mfd: hi655x: Fix regmap area declared size for hi655x
Date:   Fri,  6 Jul 2018 14:28:33 -0300
Message-Id: <20180706172833.533-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: https://bugs.linaro.org/show_bug.cgi?id=3903

LTP Functional tests have caused a bad paging request when triggering
the regmap_read_debugfs() logic of the device PMIC Hi6553 (reading
regmap/f8000000.pmic/registers file during read_all test):

Unable to handle kernel paging request at virtual address ffff0
[ffff00000984e000] pgd=0000000077ffe803, pud=0000000077ffd803,0
Internal error: Oops: 96000007 [#1] SMP
...
Hardware name: HiKey Development Board (DT)
...
Call trace:
 regmap_mmio_read8+0x24/0x40
 regmap_mmio_read+0x48/0x70
 _regmap_bus_reg_read+0x38/0x48
 _regmap_read+0x68/0x170
 regmap_read+0x50/0x78
 regmap_read_debugfs+0x1a0/0x308
 regmap_map_read_file+0x48/0x58
 full_proxy_read+0x68/0x98
 __vfs_read+0x48/0x80
 vfs_read+0x94/0x150
 SyS_read+0x6c/0xd8
 el0_svc_naked+0x30/0x34
Code: aa1e03e0 d503201f f9400280 8b334000 (39400000)

Investigations have showed that, when triggered by debugfs read()
handler, the mmio regmap logic was reading a bigger (16k) register area
than the one mapped by devm_ioremap_resource() during hi655x-pmic probe
time (4k).

This commit changes hi655x's max register, according to HW specs, to be
the same as the one declared in the pmic device in hi6220's dts, fixing
the issue.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc: <stable@vger.kernel.org> #v4.9 #v4.14 #v4.16 #v4.17
---
 drivers/mfd/hi655x-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index c37ccbfd52f2..96c07fa1802a 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -49,7 +49,7 @@ static struct regmap_config hi655x_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = HI655X_STRIDE,
 	.val_bits = 8,
-	.max_register = HI655X_BUS_ADDR(0xFFF),
+	.max_register = HI655X_BUS_ADDR(0x400) - HI655X_STRIDE,
 };
 
 static struct resource pwrkey_resources[] = {
-- 
2.18.0

