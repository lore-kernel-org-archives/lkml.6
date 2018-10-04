Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB1CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CC62098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CC62098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeJDPLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:11:52 -0400
Received: from foss.arm.com ([217.140.101.70]:60204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJDPLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:11:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593A980D;
        Thu,  4 Oct 2018 01:19:48 -0700 (PDT)
Received: from [10.4.13.99] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E8FD3F5A0;
        Thu,  4 Oct 2018 01:19:47 -0700 (PDT)
Subject: Re: kernel BUG at arch/arm/kvm/coproc.c:1406!
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>, christoffer.dall@arm.com
References: <6b134030-f9a4-1983-caac-5cfcc2be9776@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <3d719d5f-d7b9-9bba-4fa8-61175a9b05a9@arm.com>
Date:   Thu, 4 Oct 2018 09:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6b134030-f9a4-1983-caac-5cfcc2be9776@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 04/10/18 04:02, Florian Fainelli wrote:
> Hi,
> 
> Seeing the following BUG_ON() being triggered on a Lamobo R1
> (SUN7I/Cortex-A7), did not have the time to run a bisection since I was
> chasing another regression. My guess would be that
> 3e8a8a50c7ef1a4f71921731f0e1748a7f70ddaa ("KVM: arm: vgic-v3: Add
> support for ICC_SGI0R and ICC_ASGI1R accesses") is the culprit since it
> does add new entries to cp15_regs[].

OK, this is quite embarrassing. I remember fixing that exact bug before
the 4.19 merge window, and was 100% convinced that I had merged the fix.

Turns out I didn't. 

Can you verify that the following patch works for you?

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 450c7a4fbc8a..cb094e55dc5f 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -478,15 +478,15 @@ static const struct coproc_reg cp15_regs[] = {
 
 	/* ICC_SGI1R */
 	{ CRm64(12), Op1( 0), is64, access_gic_sgi},
-	/* ICC_ASGI1R */
-	{ CRm64(12), Op1( 1), is64, access_gic_sgi},
-	/* ICC_SGI0R */
-	{ CRm64(12), Op1( 2), is64, access_gic_sgi},
 
 	/* VBAR: swapped by interrupt.S. */
 	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c12_VBAR, 0x00000000 },
 
+	/* ICC_ASGI1R */
+	{ CRm64(12), Op1( 1), is64, access_gic_sgi},
+	/* ICC_SGI0R */
+	{ CRm64(12), Op1( 2), is64, access_gic_sgi},
 	/* ICC_SRE */
 	{ CRn(12), CRm(12), Op1( 0), Op2(5), is32, access_gic_sre },
 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
