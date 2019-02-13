Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CA1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB1B222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ezJ1X9DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbfBMHgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:36:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48082 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfBMHgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:36:17 -0500
Received: from [IPv6:2003:ec:2bcd:e800:6998:1e1e:4912:ac0f] (p200300EC2BCDE80069981E1E4912AC0F.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e800:6998:1e1e:4912:ac0f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46D051EC02FF;
        Wed, 13 Feb 2019 08:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550043375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrdCindAhT2300QSoYwTdRu+nH65dkTkoW67oq+TokQ=;
        b=ezJ1X9DZcaG3ugNE5tKqTZ76e9FbH5IqXHLNfhSwNXqDJGxJnTZklmCnTV3purq/JXbQWi
        sVeIKGZ6LjtEzrtNHvsFgSJA/QNoc3nkmfQiQemaIDOKmxZfccdaAXO7NyjQfXc/rcsEy3
        fFfgZVltCGHLslKNHGnSXdjzoM4vbR4=
Date:   Wed, 13 Feb 2019 08:36:12 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190213015429.GA12592@localhost.localdomain>
References: <20190211002220.GD14948@zn.tnic> <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com> <20190211095547.GB1651@localhost.localdomain> <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com> <20190211101011.GA5333@localhost.localdomain> <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com> <20190211102426.GA19618@zn.tnic> <20190211104254.GB19618@zn.tnic> <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com> <20190211112009.GE19618@zn.tnic> <20190213015429.GA12592@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in boot_params
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
From:   Boris Petkov <bp@alien8.de>
Message-ID: <CFAC8B79-54C1-4E74-8660-31B0B88BF749@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2019 2:54:29 AM GMT+01:00, Chao Fan <fanc=2Efnst@cn=2Efujit=
su=2Ecom> wrote:
>Yes, your PATCH really works well=2E I tried both efi32 OVMF and efi64
>OVMF, all boot=2E

What about the real hardware you are normally testing on? Boots there too?

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
