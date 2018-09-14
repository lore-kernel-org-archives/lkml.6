Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D909ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB7C2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB7C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeINVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINVAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:00:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD37430832F2;
        Fri, 14 Sep 2018 15:45:10 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01C3B67645;
        Fri, 14 Sep 2018 15:45:07 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 02/11] x86/time: Implement clocksource_arch_init()
References: <20180914125006.349747096@linutronix.de>
        <20180914125118.293161327@linutronix.de>
Date:   Fri, 14 Sep 2018 17:45:06 +0200
In-Reply-To: <20180914125118.293161327@linutronix.de> (Thomas Gleixner's
        message of "Fri, 14 Sep 2018 14:50:08 +0200")
Message-ID: <87zhwk6q2l.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Sep 2018 15:45:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Runtime validate the VCLOCK_MODE in clocksource::archdata and disable
> VCLOCK if invalid, which disables the VDSO but keeps the system running.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/Kconfig       |    1 +
>  arch/x86/kernel/time.c |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -48,6 +48,7 @@ config X86
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ANON_INODES
>  	select ARCH_CLOCKSOURCE_DATA
> +	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_DISCARD_MEMBLOCK
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>  	select ARCH_HAS_DEBUG_VIRTUAL
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -10,6 +10,7 @@
>   *
>   */
>
> +#include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -105,3 +106,18 @@ void __init time_init(void)
>  {
>  	late_time_init = x86_late_time_init;
>  }
> +
> +/*
> + * Sanity check the vdso related archdata content.
> + */
> +void clocksource_arch_init(struct clocksource *cs)
> +{
> +	if (cs->archdata.vclock_mode == VCLOCK_NONE)
> +		return;
> +
> +	if (cs->archdata.vclock_mode >= VCLOCK_MAX) {

It should be '>' as VCLOCK_MAX == VCLOCK_HVCLOCK == 3

> +		pr_warn("clocksource %s registered with invalid vclock_mode %d. Disabling vclock.\n",
> +			cs->name, cs->archdata.vclock_mode);
> +		cs->archdata.vclock_mode = VCLOCK_NONE;
> +	}
> +}

-- 
  Vitaly
