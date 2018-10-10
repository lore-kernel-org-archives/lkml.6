Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA25C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAD720835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAD720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJJQUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:20:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33476 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJQUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:20:40 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZBHJqpgPW6Yi; Wed, 10 Oct 2018 10:59:27 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BA991EC00E8;
        Wed, 10 Oct 2018 10:59:27 +0200 (CEST)
Date:   Wed, 10 Oct 2018 10:59:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181010085920.GB5533@zn.tnic>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:41:16PM +0800, Chao Fan wrote:
> ***Background:
> People reported that kaslr may randomly chooses some positions
> which are located in movable memory regions. This will break memory
> hotplug feature and make the movable memory chosen by KASLR can't be
> removed.
> 
> ***Solutions:
> There should be a method to limit kaslr to choosing immovable memory
> regions, so there are 2 solutions:
> 1) Add a kernel parameter to specify the memory regions.
> 2) Get the information of memory hot-remove, then kaslr will know the
>    right regions.
> In method 2, information about memory hot-remove is in ACPI
> tables, which will be parsed after start_kernel(), kaslr can't get
> the information.
> In method 1, users should know the regions address and specify in
> kernel parameter.
> 
> In the earliest time, I tried to dig ACPI tabls to solve this problem.
> But I didn't splite the code in 'compressed/' and ACPI code, so the patch
> is hard to follow so refused by community.
> Somebody suggest to add a kernel parameter to specify the
> immovable memory so that limit kaslr in these regions. Then I make
> a new patchset. After several versions, Ingo gave a suggestion:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1634024.html
> Follow Ingo's suggestion, imitate the ACPI code to parse the acpi
> tables, so that the kaslr can get necessary memory information in
> ACPI tables.
> I think ACPI code is an independent part, so copy the codes
> and functions to 'compressed/' directory, so that kaslr won't
> influence the initialization of ACPI.

... and we just picked up

https://lkml.kernel.org/r/20181001140843.26137-1-msys.mizuma@gmail.com

and without having looked at the rest of your stuff, if people accept
your solution, we don't need the silly parameter anymore, right?

Which means, we should not rush the whole thing yet until the whole
KASLR vs movable memory gets solved properly.

Ingo, Thomas?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
