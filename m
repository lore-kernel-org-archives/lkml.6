Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E39C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F28B20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F28B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeIFAKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:10:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39654 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeIFAJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:33 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so15917959oig.6;
        Wed, 05 Sep 2018 12:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L6E6vVywGO46HqOghl5n+w7OMYLN/eyqP7WNYCEryGg=;
        b=EtiCVm6YGav73ifd6rnm5MoR//WaykKyKC+O5/sLWVhguYTnoDLYhWOuM2H3AidYht
         CnwWhyLyI/WlDKrj3T0s8HLyfmxcFXHDlhSR1lvd0080oaSwKOKSOFrcJ9+WOlQmarQU
         vHGVsmw9xJeUDyROeQ7weOlEVu9AVgZ4hqY5vZqYpj6UOxJNz+26Svylyyf9Dmz5vnbc
         3j1kQGSSzCXmBFI1QmnLSjVSdoR1KF5GNafNGNeyDYvvRQwkfDvsUsLX+rj1cytCGDkT
         CH2L4Ge2uzCJoniSj5cvdVXN32Rz9k8MnWbWqSPGKbjshoSUoIQ08sgv6s89tpWOqctf
         E4VA==
X-Gm-Message-State: APzg51B984xSwVEUWB+0rKm/YGNlzaz4XJVkno+LMTgrsM9Mt28A7vxa
        AgozP4xPoe2NHV+9MlYGkQqvxq4=
X-Google-Smtp-Source: ANB0VdZDlbE7DYOnktc6E1aF/4lvQpqiHDT+LBuMazKHEw7KVEkA7WJnorqr0hmXPyLb0xGnRgssVg==
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr30022899oia.294.1536176275757;
        Wed, 05 Sep 2018 12:37:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Bordug <vitb@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/21] powerpc: 8xx: get cpu node with of_get_cpu_node
Date:   Wed,  5 Sep 2018 14:37:30 -0500
Message-Id: <20180905193738.19325-14-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"device_type" use is deprecated for FDT though it has continued to be used
for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
node names by default. This will allow the eventually removal of cpu
device_type properties.

Also, fix a leaked reference and add a missing of_node_put.

Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/powerpc/platforms/8xx/m8xx_setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 027c42d8966c..f1c805c8adbc 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -66,7 +66,7 @@ static int __init get_freq(char *name, unsigned long *val)
 	int found = 0;

 	/* The cpu node should have timebase and clock frequency properties */
-	cpu = of_find_node_by_type(NULL, "cpu");
+	cpu = of_get_cpu_node(0, NULL);

 	if (cpu) {
 		fp = of_get_property(cpu, name, NULL);
@@ -147,8 +147,9 @@ void __init mpc8xx_calibrate_decr(void)
 	 * we have to enable the timebase).  The decrementer interrupt
 	 * is wired into the vector table, nothing to do here for that.
 	 */
-	cpu = of_find_node_by_type(NULL, "cpu");
+	cpu = of_get_cpu_node(0, NULL);
 	virq= irq_of_parse_and_map(cpu, 0);
+	of_node_put(cpu);
 	irq = virq_to_hw(virq);

 	sys_tmr2 = immr_map(im_sit);
--
2.17.1
