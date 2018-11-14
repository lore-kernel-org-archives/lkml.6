Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5735FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2989D223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2989D223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeKOEhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:37:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbeKOEhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:37:35 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RuRSoldjOf2u; Wed, 14 Nov 2018 19:33:14 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B7521EC037D;
        Wed, 14 Nov 2018 19:33:14 +0100 (CET)
Date:   Wed, 14 Nov 2018 19:33:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181114183315.GJ13926@zn.tnic>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
 <20181113175150.GK10502@zn.tnic>
 <20181114015450.GA2875@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114015450.GA2875@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 09:54:50AM +0800, Chao Fan wrote:
> CONFIG_KEXEC is only needed in this function.
> 
> When searching RSDP, there are three methods in order:
> 1. When booting from KEXEC, 'acpi_rsdp' is added to cmdline by KEXEC,
>    so it can be parsed and used. CONFIG_KEXEC is needed here.

But theoretically acpi_rsdp can be supplied by the first kernel too,
right?

So you don't need that CONFIG_KEXEC here at all?

> >Ok, let's recap: so far, for your use case you need:
> >
> >CONFIG_MEMORY_HOTREMOVE
> >CONFIG_RANDOMIZE_BASE
> >and now
> >CONFIG_KEXEC
> >
> >So, you can clean up all that ifdeffery by defining a new config item
> >CONFIG_EARLY_PARSE_RSDP or so which depends on all those three items and
> >then you can do
> >
> >vmlinux-objs-$(CONFIG_EARLY_PARSE_RSDP) += $(obj)/acpitb.o
> >
> >and get rid of the most of the ifdeffery.

Regardless of CONFIG_KEXEC - you still need to define a CONFIG_ symbol
for your use case. We won't be parsing RSDP early on !MEMORY_HOTREMOVE
machines, which is the majority.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
