Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69254C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F482086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfBAJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:41:58 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25412 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728565AbfBAJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:41:57 -0500
X-IronPort-AV: E=Sophos;i="5.56,547,1539619200"; 
   d="scan'208";a="53397825"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Feb 2019 17:41:55 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 17D0E4C4BB9B;
        Fri,  1 Feb 2019 17:41:53 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 1 Feb 2019 17:41:54 +0800
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
Message-ID: <7463228f-3749-8cab-c727-433bba4131b4@cn.fujitsu.com>
Date:   Fri, 1 Feb 2019 17:41:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ+1==nCOCOwL=-UPfZ8rBA_u_Y82dpD75gxzdBOTK+Gw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 17D0E4C4BB9B.AD5B8
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

I am confused, doesn't input_size = ZO image size = .head.text +
.rodata..compressed + .rodata + .got + .data + .pgtable ? As I know,
.bss don't occupy any space in file, and ZO's full run size is against
the end of buffer, so I think the tiny gap here is just .bss, which is
also the stack and heap. Do I get it wrong?

>>   * range includes ZO's heap and stack, and must be avoided since it
>>   * performs the decompression.
>>   *
>> @@ -763,9 +763,6 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
>>                 return 0;
>>         }
>>
>> -       /* Make sure minimum is aligned. */
>> -       minimum = ALIGN(minimum, CONFIG_PHYSICAL_ALIGN);
>> -
> 
> I would prefer to keep this runtime calculation since it enforces the
> requirement instead of making leaving it in a comment. When this goes
> wrong, you get an unbootable kernel, which is very frustrating to
> debug.
> 

I find that I maybe wrong here. It is said that CONFIG_PHYSICAL_ALIGN
must be a multiple of 0x200000 on 64-bit, so it could be 2M, 4M, 6M, 8M,
12M, 14M, 16M, while 512M can't be divided by 6, 10, 12, 14 without
remainder.

-- 
Sincerely,
Cao jin


