Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39C22192B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Dv3YYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfBPRGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:06:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42841 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfBPRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 12:06:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so6509454plp.9;
        Sat, 16 Feb 2019 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ja6mCcRLlYPsEVUIAvpllb4e3KJQWF+U3raMEkM81WA=;
        b=n9Dv3YYkhcHJajvQY58H1OcgiXeFtniUh7pwL93X6IO21Pgxy9LsH/hob3e9tTR2B7
         NuCfejpyNSGuF7O1nXy6p9jFIldGYL7sWUEyaiUk013K9LE1mfoT/GzcgfWOApEsOiNe
         y/DhBUFziXR+16MZ0ovyLWx3UYd9LaEupFr2142n91+U2O8jwrUGxo6oj72gwE58Vi7h
         UhJtjrM9w33PAC9gduL2KOE0CD0TgFSE/gMyZGbDJaEjTDr2VleYZRPOryuE0iFIq0Fd
         HzbIDE5tPdJBj+W8xWVsd0qq8VGPF5ndFv2Egl+3oBlvI+5vZOGunM0cupEd3+w72yzy
         hgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ja6mCcRLlYPsEVUIAvpllb4e3KJQWF+U3raMEkM81WA=;
        b=MNKNZjO5ngsocbZtP01pqjduRBTPl74sApGmv+RwXaUwG2tA5qajviIbT1mSkeme/m
         M/YFesnQeNfzvfYnXkGVO0xFdLzEc7VyGjKSzdvcuYLyEczAHczxGlzoI1Vf2+Zv6WJM
         1nDFEj/17DCGp3U7QPQPOdJ1+dh3fwLX+vgYeTTPd/eKpVDc/noIGqzAOdqf4Kr5Fevc
         cntjafi0TL69S/ktHZhjjKi7fHBwKc08nBsH/MtDw+/346P9JXyPu8yoMiiExPrH/3uo
         +7lZZPXDih2gkauoKvTcXf3qdpbO3iE5KHFzy/LYsE/MaCycyzunyqERZ2WHbJpvVKU/
         jlag==
X-Gm-Message-State: AHQUAuZcjrifd5vlZgDmsrvIc5EdLMIVc7pfvG633toMo5TNxcQXiBBU
        SyfxKpsdi/50fva0dZtBQK8=
X-Google-Smtp-Source: AHgI3IZfTLoHZuOBTtj+tPGxsaO1d9aaF92QN6NRLj30AVpQyKOBVF5ko/qopM+WhNn1qe49x4D1VA==
X-Received: by 2002:a17:902:509:: with SMTP id 9mr15342227plf.94.1550336790185;
        Sat, 16 Feb 2019 09:06:30 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e24sm11644429pfi.153.2019.02.16.09.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 09:06:29 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: powernv: fix missing check of return value in init_powernv_pstates()
Date:   Sat, 16 Feb 2019 12:06:23 -0500
Message-Id: <20190216170623.12634-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc() could fail, so insert a check of its return value. And
if it fails, returns -ENOMEM.

And remove (struct pstate_idx_revmap_data *) to fix coccinelle WARNING
by the way.

WARNING: casting value returned by memory allocation function to (struct
pstate_idx_revmap_data *) is useless.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 7e7ad3879c4e..d2230812fa4b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -244,6 +244,7 @@ static int init_powernv_pstates(void)
 	u32 len_ids, len_freqs;
 	u32 pstate_min, pstate_max, pstate_nominal;
 	u32 pstate_turbo, pstate_ultra_turbo;
+	int rc = -ENODEV;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
@@ -327,8 +328,11 @@ static int init_powernv_pstates(void)
 		powernv_freqs[i].frequency = freq * 1000; /* kHz */
 		powernv_freqs[i].driver_data = id & 0xFF;
 
-		revmap_data = (struct pstate_idx_revmap_data *)
-			      kmalloc(sizeof(*revmap_data), GFP_KERNEL);
+		revmap_data = kmalloc(sizeof(*revmap_data), GFP_KERNEL);
+		if (!revmap_data) {
+			rc = -ENOMEM;
+			goto out;
+		}
 
 		revmap_data->pstate_id = id & 0xFF;
 		revmap_data->cpufreq_table_idx = i;
@@ -357,7 +361,7 @@ static int init_powernv_pstates(void)
 	return 0;
 out:
 	of_node_put(power_mgt);
-	return -ENODEV;
+	return rc;
 }
 
 /* Returns the CPU frequency corresponding to the pstate_id. */
-- 
2.17.0

