Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A424C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EA82443A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="chm94ZHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EA82443A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966649AbeF2Sxp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:53:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45541 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965133AbeF2Sxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:53:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so4357446pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2DG/5w6Dxd7+uRXoJiukSZBJ06/larGXTMIu73bwg+I=;
        b=chm94ZHqBEI+jP8CiIB3T0TmbKc/jLXAkiSmN+A9JgNm2njN+TtvJ7GHs2EVfsg/mE
         tDQjKpIamiufBC/7RXMi/MABEh8fD/q2GHGBo0CIJBLRc5lEnX/X1BKLIPv//WlTuIvO
         8nabxLuBQD1ERmUjjQ7foBQeQHjRmO66P1QCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2DG/5w6Dxd7+uRXoJiukSZBJ06/larGXTMIu73bwg+I=;
        b=ghIuOp+Hkl98Kep5hoo+1eEm2ahIhunzPT3KMNUcKG9mbInSrrmpsXsKpPTR8cDNzV
         61lZxeBd6fJ5NZP/lFrORU2194q/zlIBqkTfEs60mesc9MW2ggKSf38ob92PhHNW8pKa
         Ufigfvvi6Ft2PrAm8kENQ1K8YLKlctrt40j2LByaQDKhytFYGxwBVYhq2AxiHfCAAUmw
         usqLKUOAKmMGtaqXhjEu2U2OmUlZNyV+gdzIEV+J9cEXfYnVDfAovUPoBCWY8nbMq75R
         nYnBfKCxrtPDG1k4o39FTV6drUdvvOR7PQhTybpGkHAga1rSnyxnd1OngnqnG4Hciuq3
         DBxg==
X-Gm-Message-State: APt69E0IfRIPlQ5ntNhGyLPAnsKNWJBrwne87x0VR2RuXcanZ/U5J5KC
        aV07fyq1xiaSNOhPgk/wfnMs2g==
X-Google-Smtp-Source: ADUXVKLAfThP20T3YHm3LV4Ln/c4BacxaoGLPORntVF0KuEL9c0plKg9hzMT/20DsorQTKDjVHD7tw==
X-Received: by 2002:a63:920c:: with SMTP id o12-v6mr13635812pgd.233.1530298421163;
        Fri, 29 Jun 2018 11:53:41 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q188-v6sm3447859pfb.141.2018.06.29.11.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:53:40 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:53:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anatolij Gustschin <agust@denx.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: mpc5200: Remove VLA usage
Message-ID: <20180629185339.GA37582@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a stack size large enough for the saved routine and
adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/platforms/52xx/mpc52xx_pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index 31d3515672f3..b23da85fa73c 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -117,7 +117,10 @@ int mpc52xx_pm_enter(suspend_state_t state)
 	u32 intr_main_mask;
 	void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
 	unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
-	char saved_0x500[mpc52xx_ds_cached_size];
+	char saved_0x500[256];
+
+	if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
+		return -ENOMEM;
 
 	/* disable all interrupts in PIC */
 	intr_main_mask = in_be32(&intr->main_mask);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
