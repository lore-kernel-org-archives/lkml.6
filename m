Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EAEC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A162621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfBMDNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:13:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6449 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728098AbfBMDNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:13:04 -0500
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="54212734"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Feb 2019 11:13:02 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 4C4984C4BCDC;
        Wed, 13 Feb 2019 11:13:03 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Feb 2019 11:13:05 +0800
Subject: Re: [PATCH] x86/boot: minor improvement in kaslr
To:     Kees Cook <keescook@chromium.org>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
References: <20190201054853.28541-1-caoj.fnst@cn.fujitsu.com>
 <CAGXu5jJ+1==nCOCOwL=-UPfZ8rBA_u_Y82dpD75gxzdBOTK+Gw@mail.gmail.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <f2278379-07cf-6ad4-aff8-2473b7545e80@cn.fujitsu.com>
Date:   Wed, 13 Feb 2019 11:10:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ+1==nCOCOwL=-UPfZ8rBA_u_Y82dpD75gxzdBOTK+Gw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 4C4984C4BCDC.A8EF6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 4:20 PM, Kees Cook wrote:
> On Fri, Feb 1, 2019 at 6:51 PM Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>
>> comments fix: input_size is ZO image size which just don't count .bss
>> in, but has .text, .data, etc;
>> drop unecessary alignment: minimum is either 512M or output, both are
>> CONFIG_PHYSICAL_ALIGN aligned(output is aligned in head_32/64.S). But
>> mention it in earlier comments.
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/kaslr.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index 9ed9709d9947..a947c5aba34e 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -360,7 +360,7 @@ static void handle_mem_options(void)
>>   * (i.e. it does not include its run size). This range must be avoided
>>   * because it contains the data used for decompression.
>>   *
>> - * [input+input_size, output+init_size) is [_text, _end) for ZO. This
>> + * [input+input_size, output+init_size) is [_bss, _end) for ZO. This
> 
> This isn't right. The comment was correct before. See
> arch/x86/boot/compressed/vmlinux.lds.S for the layout of the ZO image:
> after the compressed image is _text, _rodata, _got, _data, _bss,
> _pgtable, and _end. "[_text, _end)" correctly identifies the span
> used.
> 

Finally see why I am wrong here, I mixed up with the input_size & ZO
image file size. Sorry for the noise, and thanks very much for your
hint, Kees!

-- 
Sincerely,
Cao jin


