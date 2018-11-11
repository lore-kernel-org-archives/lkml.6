Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CBFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36A320862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKUieIuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36A320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbeKLJGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389776AbeKLIVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9994B2241B;
        Sun, 11 Nov 2018 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975501;
        bh=jl1u2M7G8tLaWmYBwCEaFbJ/ZZE4WphcmzsIrZ+V3nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKUieIukjkb0BkZTKdemVqj6WHUHtbkf/BSTHehdJNPNUudg79YNLie3WuFTeQ0zA
         riaAHCj6NeexJgl78OVXX/W8XMxIBHYsfn35ixfu6AjlnMsx6GUxH2du0RaN2AxHkQ
         fnWPx2/A/tOOSZxircFNq01M1Wa4Vkk741/0pu08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.18 278/350] rtc: cmos: Fix non-ACPI undefined reference to `hpet_rtc_interrupt
Date:   Sun, 11 Nov 2018 14:22:22 -0800
Message-Id: <20181111221719.670012354@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

commit d197a253855d2d8e507a003880aab35c4e2473db upstream.

Fix a commit 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm
instead of HPET") `rtc-cmos' regression causing a link error:

drivers/rtc/rtc-cmos.o: In function `cmos_platform_probe':
rtc-cmos.c:(.init.text+0x33c): undefined reference to `hpet_rtc_interrupt'
rtc-cmos.c:(.init.text+0x3f4): undefined reference to `hpet_rtc_interrupt'

with non-ACPI platforms using this driver.  The cause is the change of
the condition guarding the use of `hpet_rtc_interrupt'.

Previously it was a call to `is_hpet_enabled'.  That function is static
inline and has a hardcoded 0 result for non-ACPI platforms, which imply
!HPET_EMULATE_RTC.  Consequently the compiler optimized the whole block
away including the reference to `hpet_rtc_interrupt', which never made
it to the link stage.

Now the guarding condition is a call to `use_hpet_alarm', which is not
static inline and therefore the compiler may not be able to prove that
it actually always returns 0 for non-ACPI platforms.  Consequently the
build breaks with an unsatisfied reference, because `hpet_rtc_interrupt'
is nowhere defined at link time.

Fix the problem by marking `use_hpet_alarm' inline.  As the `inline'
keyword serves as an optimization hint rather than a requirement the
compiler is still free to choose whether inlining will be beneficial or
not for ACPI platforms.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org # 4.18+
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-cmos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -167,7 +167,7 @@ static inline int hpet_unregister_irq_ha
 #endif
 
 /* Don't use HPET for RTC Alarm event if ACPI Fixed event is used */
-static int use_hpet_alarm(void)
+static inline int use_hpet_alarm(void)
 {
 	return is_hpet_enabled() && !use_acpi_alarm;
 }


