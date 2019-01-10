Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0729C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABB3206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rCfqXSJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfAJKxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:53:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33774 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfAJKxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:53:49 -0500
Received: from zn.tnic (p200300EC2BC5CF00E0BB3AAFA35C49DB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:e0bb:3aaf:a35c:49db])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76E881EC047F;
        Thu, 10 Jan 2019 11:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547117627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UOHGl8Mr2k3j9sC85+ioN0Bx8EmFViP29gcUbCjXs3Y=;
        b=rCfqXSJnh+YBRBY7+isBTAvr7GVZzU7SHW07FgWrI4TDR9Gh/OhksSjSxklB0Gv6UkCg47
        D9F/w+urUF4YbVpPkLVuQ//XQhkq7fwyXwN/9PxjkEz1c0xscF0YSozgzubZQs0faS0jN/
        Lgvqu/mi9w1yya1UDHLEkgkb2cvjIMY=
Date:   Thu, 10 Jan 2019 11:53:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Tony Luck <tony.luck@gmail.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, X86-ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Subject: Re: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host
 issue
Message-ID: <20190110105339.GC17621@zn.tnic>
References: <20181220134046.7916-1-vkuznets@redhat.com>
 <20181220161722.GD31403@zn.tnic>
 <51dcb13a-4751-47f5-1e01-f6731a2c6f3c@intel.com>
 <20521afe-09af-7acf-6f32-3f6e9a971091@intel.com>
 <20190109113915.GB15665@zn.tnic>
 <87bm4qoww4.fsf@vitty.brq.redhat.com>
 <20190109121445.GC15665@zn.tnic>
 <CA+8MBbLh2JyWg=AF-cftrCfDB8QgRwJ2sKV-S24Jqtu_y1qZrg@mail.gmail.com>
 <87woncol9s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87woncol9s.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:32:47AM +0100, Vitaly Kuznetsov wrote:
> The other thing is: how can we be sure that there's no hypervisor
> exposing these feature already? Even if open-source hypervisors like
> KVM/Xen don't do it it doesn't prove anything: there are numerous
> proprietary hypervisors and who knows what they do.

Well, we have this thing called CPUID which enumerates features -
regardless of running on baremetal or on a hypervisor. But apparently
some Intel CPUs dropped the ball there. Which caused the f*ckup we are
in right now.

If you really want to not foreclose that feature for guests - and it
sounds like you do - the other thing I can think of is an early quirk
*setting* those feature bits for those Intel CPUs which "forgot" to set
them and then changing the resctrl code to test CPUID bits first.

This way, the kernel is presented with a unified view on what is
supported by the underlying machine - and that machine can be a HV or
baremetal - kernel doesn't care.

> The original issue which triggered the discussion was discovered on
> AWS Xen where the host is buggy and I suggested a simple short-term
> workaround

And I'm sick'n'tired of simple-short term workarounds and band-aids and
the kernel always bending because people dropped the ball and those
being perpetuated, because, sure, we'll add one more "fix" on the pile,
who cares... :-\

If AWS xen is broken, then that should be fixed - not the kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
