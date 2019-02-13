Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B452222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389456AbfBMH6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:58:46 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15336 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731829AbfBMH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:58:45 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="54233033"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Feb 2019 15:58:39 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 99B454B4030E;
        Wed, 13 Feb 2019 15:58:36 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Feb 2019 15:58:45 +0800
Date:   Wed, 13 Feb 2019 15:58:25 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Boris Petkov <bp@alien8.de>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <caoj.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-tip-commits@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190213075825.GA1624@localhost.localdomain>
References: <20190211095547.GB1651@localhost.localdomain>
 <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain>
 <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic>
 <20190211104254.GB19618@zn.tnic>
 <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com>
 <20190211112009.GE19618@zn.tnic>
 <20190213015429.GA12592@localhost.localdomain>
 <CFAC8B79-54C1-4E74-8660-31B0B88BF749@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CFAC8B79-54C1-4E74-8660-31B0B88BF749@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 99B454B4030E.A9BA2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:36:12AM +0100, Boris Petkov wrote:
>On February 13, 2019 2:54:29 AM GMT+01:00, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>Yes, your PATCH really works well. I tried both efi32 OVMF and efi64
>>OVMF, all boot.
>
>What about the real hardware you are normally testing on? Boots there too?

I testet it in a real EFI machine, it booted, but from command:
> cat /sys/firmware/efi/fw_platform_size
64

We can see it's a 64-bit EFI firmware, and there is no 32-bit EFI firmware available.

Thanks,
Chao Fan

>
>Thx.
>
>-- 
>Sent from a small device: formatting sux and brevity is inevitable.
>
>


