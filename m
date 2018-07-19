Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57972ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002E120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UAwOb8qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002E120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeGSXlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:41:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35446 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbeGSXlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7JzTgoxSHj8NXwJcn4MBYWwjY/bHOb0/fS+gg+hwDJI=; b=UAwOb8qNBsQ7LyLMdWhDym9W0
        MRICKOjJSZPwF19kkijace3bf7X08igZhhFxvIeMnJirfxjnRuplkyTBS8aKpRWAIGhwfailQeoJB
        aue22LQbWwgAvrEXQiJUtPH1d/9TZpsaRtpYYfdYFxaqTpCV4A3RcjEisbDbxVrt0Td6Q=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:36038)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fgHpn-0008CR-31; Thu, 19 Jul 2018 23:55:43 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fgHpk-0000vD-1u; Thu, 19 Jul 2018 23:55:40 +0100
Date:   Thu, 19 Jul 2018 23:55:38 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, hoeun.ryu@gmail.com,
        adobriyan@gmail.com, zhizhouzhang@asrmicro.com,
        suzuki.poulose@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        Abhimanyu Kapur <abhimany@codeaurora.org>
Subject: Re: [PATCH] ARM64: smp: Fix cpu_up() racing with sys_reboot
Message-ID: <20180719225538.GN17271@n2100.armlinux.org.uk>
References: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:18:46PM -0700, Venkata Narendra Kumar Gutta wrote:
> Nothing stops a process from hotplugging in a CPU concurrently
> with a sys_reboot() call. In such a situation we could have
> ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
> fact that the CPU is not really offline and call the
> CPU_UP_PREPARE notifier. When this happens stop_machine code will
> complain that the cpu thread already exists and BUG_ON().
> 
> CPU0                      CPU1
> 
>  sys_reboot()
>  kernel_restart()
>  machine_restart()
>  machine_shutdown()
>  smp_send_stop()
>  ...                   ipi_cpu_stop()
> 		       set_cpu_online(1, false)
>                        local_irq_disable()
>                        while(1)
>         <PREEMPT>
>  cpu_up()
>  _cpu_up()
>  if (!cpu_online(1))
>  __cpu_notify(CPU_UP_PREPARE...)
> 
>  cpu_stop_cpu_callback()
>  BUG_ON(stopper->thread)
> 
> This is easily reproducible by hotplugging in and out in a tight
> loop while also rebooting.
> 
> Since the CPU is not really offline and hasn't gone through the
> proper steps to be marked as such, let's mark the CPU as inactive.
> This is just as easily testable as online and avoids any possibility
> of _cpu_up() trying to bring the CPU back online when it never was
> offline to begin with. Based on the similar patchset by for arm
> targets 040c163( "ARM: smp: Fix cpu_up() racing with sys_reboot)"

You really need to use 12 digit commit IDs to refer to commits to
avoid:

$ git log 040c163
fatal: ambiguous argument '040c163': unknown revision or path not in the working tree.

because 7 digits are just too short and given the size of the kernel,
result in conflicting references.

I can find no trace of "040c163" touching arch/arm/kernel/smp.c,
nor can I find a commit with "racing with sys_reboot" touching the
same file.

The commit you reference doesn't seem to be in mainline.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
