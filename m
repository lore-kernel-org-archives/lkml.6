Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C593C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B05B206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qD4u8DbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfAILj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:39:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33060 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbfAILjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:39:25 -0500
Received: from zn.tnic (p200300EC2BEA1000E56F05EB9FFDE1E7.dip0.t-ipconnect.de [IPv6:2003:ec:2bea:1000:e56f:5eb:9ffd:e1e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85EE71EC00E5;
        Wed,  9 Jan 2019 12:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547033963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O64S/Pgx+ufo7VPMedv5rxFREieQ/PwtcyPrmYesS3I=;
        b=qD4u8DbUKDZu+JCtDXJzI5EMUaXKXutQyYVuev+AIrCJpf5K5Sf33WY8g8YdSksT3eLDPz
        cLyXu8MEAwqjQD6HfX3TeFbigjkuSMbtjMOeBb2d12kNpMMsxr4qklu42WLS9JWxP9hYfk
        cWK7XY65eT9wqXRnGfNX2QkTKhpaf4g=
Date:   Wed, 9 Jan 2019 12:39:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Babu Moger <Babu.Moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Subject: Re: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host
 issue
Message-ID: <20190109113915.GB15665@zn.tnic>
References: <20181220134046.7916-1-vkuznets@redhat.com>
 <20181220161722.GD31403@zn.tnic>
 <51dcb13a-4751-47f5-1e01-f6731a2c6f3c@intel.com>
 <20521afe-09af-7acf-6f32-3f6e9a971091@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20521afe-09af-7acf-6f32-3f6e9a971091@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:39:46PM -0800, Reinette Chatre wrote:
> To clarify please the last sentence applies to real Haswell server CPUs
> (not virtualized as prompted this work, my apologies for the confusion)
> that support Intel RDT but does not have CPUID enumeration for this
> feature. With Vitaly's patch this hardware would still be detected as
> supporting CAT but if CPUID enumeration is moved earlier then from what
> I can tell this hardware would be considered as not supporting the
> feature anymore.

Ok, so hw "forgot" to add CPUID again. And CPU guys should know better
but everytime we hear "important reasons" why they dropped the ball
there.

So, assuming RDT is not going to be supported in a guest, we need a
proper fix to disable it when in a guest. So the RDT init path needs
something like this then:

---
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c3a9dc63edf2..1e5a1cb49e9c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -969,6 +969,9 @@ static int __init resctrl_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
 
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	/*
 	 * Initialize functions(or definitions) that are different
 	 * between vendors here.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
