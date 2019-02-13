Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEE2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9C3222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="erIHHLaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390842AbfBMIuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:50:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfBMIuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:50:20 -0500
Received: from zn.tnic (p200300EC2BCDE800B80E9BCAB03A01F8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e800:b80e:9bca:b03a:1f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C33351EC023E;
        Wed, 13 Feb 2019 09:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550047818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F8lDuxR0Zzowpeue5HPMUzUWSF56tIFg7gorz0aafkU=;
        b=erIHHLaYtJWH6DIxK91FbaYxWU7x0EZZMM0X7aOAPs/k3lW8ZAyIK3UEve3sqj4cEtlafY
        0j3Lq8xKdECwqQgTE0hfMJSvF0yCRYrKgOeDbFX5IZnbtldHrjY2+poPEHHSJJ1e25omhV
        7iIi371oMsvPz6rapO93+JI7fVLJMyo=
Date:   Wed, 13 Feb 2019 09:50:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        caoj.fnst@cn.fujitsu.com, Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190213085010.GA30103@zn.tnic>
References: <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic>
 <20190211104254.GB19618@zn.tnic>
 <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com>
 <20190211112009.GE19618@zn.tnic>
 <20190213015429.GA12592@localhost.localdomain>
 <CFAC8B79-54C1-4E74-8660-31B0B88BF749@alien8.de>
 <20190213075825.GA1624@localhost.localdomain>
 <CAKv+Gu9WWKZtgtdwv0y8giieiwzuKHdZ0Qaa2UA7WXZRkcEJNg@mail.gmail.com>
 <20190213081221.GB1624@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190213081221.GB1624@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:12:21PM +0800, Chao Fan wrote:
> Yes, I tried the 32-bit OVMF and rootfs from Guenter.

Ok, thanks.

Final version of the fix coming up...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
