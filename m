Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14804C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6151222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083400;
	bh=ZQ/VpiYT18CARV7PDY75fdOuIpq+xcU1ZPOnebo+MhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DNzpKWjT26YwHbV3IeYhCBxIhCCQrK8cfM2HMDD5GS+iszmNBX0Seq58Nnt0GzYUG
	 4wQzIXVvLQnInjgWEE2dnvKm1Ypj5heX6MN1l4qLPpitdHgvhn9BozBX2r4IB1EVUd
	 vVV5EbKS8pxZdB3mo3hrXNGdhsPnfre4udeVASt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393971AbfBMSnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405822AbfBMSnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC62222D9;
        Wed, 13 Feb 2019 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083392;
        bh=ZQ/VpiYT18CARV7PDY75fdOuIpq+xcU1ZPOnebo+MhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wDzemyld3VAFdI1he50PsNoANSLqU1I+kOwsVrD2PgziiqQSpt31gKC1SgixqAndr
         kZsf4s5+pphxrZrxf5q4Vdc7sD8rBAggII3oFR+fGsNo6gPxFCl/8Hd7+AO7HssyUD
         MLvS+ni2Eqp/lMlvnS4IdXjUgppr94PFF/SxIcGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4.19 22/44] mips: loongson64: remove unreachable(), fix loongson_poweroff().
Date:   Wed, 13 Feb 2019 19:38:23 +0100
Message-Id: <20190213183653.613005602@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yifeng Li <tomli@tomli.me>

commit 8a96669d77897ff3613157bf43f875739205d66d upstream.

On my Yeeloong 8089, I noticed the machine fails to shutdown
properly, and often, the function mach_prepare_reboot() is
unexpectedly executed, thus the machine reboots instead. A
wait loop is needed to ensure the system is in a well-defined
state before going down.

In commit 997e93d4df16 ("MIPS: Hang more efficiently on
halt/powerdown/restart"), a general superset of the wait loop for all
platforms is already provided, so we don't need to implement our own.

This commit simply removes the unreachable() compiler marco after
mach_prepare_reboot(), thus allowing the execution of machine_hang().
My test shows that the machine is now able to shutdown successfully.

Please note that there are two different bugs preventing the machine
from shutting down, another work-in-progress commit is needed to
fix a lockup in cpufreq / i8259 driver, please read Reference, this
commit does not fix that bug.

Reference: https://lkml.org/lkml/2019/2/5/908
Signed-off-by: Yifeng Li <tomli@tomli.me>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/common/reset.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/mips/loongson64/common/reset.c
+++ b/arch/mips/loongson64/common/reset.c
@@ -59,7 +59,12 @@ static void loongson_poweroff(void)
 {
 #ifndef CONFIG_LEFI_FIRMWARE_INTERFACE
 	mach_prepare_shutdown();
-	unreachable();
+
+	/*
+	 * It needs a wait loop here, but mips/kernel/reset.c already calls
+	 * a generic delay loop, machine_hang(), so simply return.
+	 */
+	return;
 #else
 	void (*fw_poweroff)(void) = (void *)loongson_sysconf.poweroff_addr;
 


