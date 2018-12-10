Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C892084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="p+zJMHij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C892084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeLJUtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:49:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJUtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:49:21 -0500
Received: from zn.tnic (p200300EC2BCAD0002992494E33A10E64.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:2992:494e:33a1:e64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B6961EC0322;
        Mon, 10 Dec 2018 21:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544474959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=im/HPAMpva0SD6RJpQWAEDKLyRT050cB1ZM+ElO9QF0=;
        b=p+zJMHijxOpotETaasvR6g+QcKF8318PYbs1nr3mlQUsSc8OCnZSUvNVbuXAoJ14yAQ+uS
        R05xd7LBg1RbKV8CU0B7gfbGLmv4KlqoRVt7nMiyfQsQ6bAnV3ZnK/H0JFoy7sXyqgpNsU
        2Tknw7P8Wh1q/ZAn87gDv1Niw167Wz4=
Date:   Mon, 10 Dec 2018 21:49:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Ensure usage of CPUs are locked while needed
Message-ID: <20181210204915.GH5482@zn.tnic>
References: <725073a1f4448e3c45ed7102229e6946ca2526d8.1543428144.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <725073a1f4448e3c45ed7102229e6946ca2526d8.1543428144.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:22:07AM -0800, Reinette Chatre wrote:
> The user triggers the creation of a pseudo-locked region when writing
> the requested schemata to the schemata resctrl file. The pseudo-locking
> of a region is required to be done on a CPU that is associated with the
> cache on which the pseudo-locked region will reside. In order to run the
> locking code on a specific CPU the needed CPU has to be selected and
> ensured to remain online during the entire locking sequence.
> 
> At this time the cpu_hotplug_lock is not taken during the pseudo-lock
> region creation and it is thus possible for a CPU to be selected to run
> the pseudo-locking code and then that CPU to go offline before the
> thread is able to run on it.
> 
> Fix this by ensuring that the cpu_hotplug_lock is taken while the CPU on
> which code has to run needs to be controlled. Since the cpu_hotplug_lock
> is always taken before rdtgroup_mutex the lock order is maintained.
> 
> Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++++
>  1 file changed, 4 insertions(+)

This looks like it wants to go in now, right?

If so, pls redo this patch against tip/x86/urgent which has the old
filenames, before the resctrl rename and reorg.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
