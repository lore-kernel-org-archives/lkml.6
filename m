Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FD6C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB52133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="nOAS6c5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BB52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeLNL56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:57:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55158 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNL55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:57:57 -0500
Received: from zn.tnic (p200300EC2BCFEF009546D97CB482D082.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:ef00:9546:d97c:b482:d082])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A258C1EC0C1D;
        Fri, 14 Dec 2018 12:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544788676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oH/29INGsD1Dv8T17pjTTxy4cUaLLSe49tjPIkhaeB8=;
        b=nOAS6c5ATe+M0Z4/GmVQpjv5u7VOzijnBfLEdqejiPI2y2OVOhmXCPhq85xc8RCM/p8qYS
        cR5JWcAzUfjRf9Xfh7++/dr85GU9uMXwvd/RTYmTfD61JKZTG/wM/YDfDVTZ42WMNaxOQh
        iPujb5pz18fjdurZvzvqMSlw4pE3HCk=
Date:   Fri, 14 Dec 2018 12:57:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181214115749.GC11710@zn.tnic>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181213125059.GC25287@zn.tnic>
 <20181214025917.GF24409@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214025917.GF24409@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:59:17AM +0800, Chao Fan wrote:
> Cant't use div_u64() in math64.h directly, because  that will cause ld error.

Ok, I see it now.

> Even in 64-bit environment, arch/x86/boot/*.o will be built as 32-bit
> binary. In 64-bit binary, the dividend is handled as 64-bit value,
> that's OK, but in 32-bit binary, that's wrong. So it's necessary
> to separate the dividend to upper and lower in 32-bit binary.
> That's why copy the needed div_u64() here.

You could've written this in the commit message. This is an important
piece of information.

> So just like Baoquan said, it's a good choice to use simple_strtoull()
> for now.

So, we tried a little, we encountered a problem and now we're giving up?
Is that what you're trying to tell me?

Please explain what are we in a hurry for and why aren't we doing it
right?

Btw, one more thing I noticed:

> +static acpi_physical_address get_acpi_rsdp(void)
> +{
> +#ifdef CONFIG_KEXEC
> +       unsigned long long res;
> +       int len = 0;
> +       char val[MAX_ADDRESS_LENGTH+1];
> +
> +       len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
> +       if (len > 0) {
> +               val[len] = 0;
> +               return (acpi_physical_address)kstrtoull(val, 16, &res);

This would've never worked because the parsed integer gets returned in
res but you're returning the kstrtoull() return value, which is

"Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error."

So this could not have been tested successfully, if at all...

So let's please slow down, think about it good, do it right and test it
properly before sending next time, ok?

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
