Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C7FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC0720840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC0720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeKILZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:25:37 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17972 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727336AbeKILZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:25:37 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47624000"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Nov 2018 09:47:14 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 71C724B71EB5;
        Fri,  9 Nov 2018 09:47:13 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.408.0; Fri, 9 Nov 2018 09:47:16 +0800
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
To:     Peter Maydell <peter.maydell@linaro.org>, <x86@kernel.org>,
        <hpa@zytor.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>
CC:     QEMU Developers <qemu-devel@nongnu.org>,
        Philip Li <philip.li@intel.com>, <zhijianx.li@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
Date:   Fri, 9 Nov 2018 09:47:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 71C724B71EB5.AC066
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/08/2018 07:06 PM, Peter Maydell wrote:
> On 8 November 2018 at 10:59, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>> x86/x86_64 has alredy supported 4G initrd.
>>
>> linux/arch/x86/boot/header.S:
>>   # (Header version 0x0203 or later) the highest safe address for the contents
>>   # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
>>   # avoid possible bootloader bugs.
>>
>> CC: Philip Li <philip.li@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   hw/i386/pc.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index cd5029c..e1b910f 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -913,6 +913,12 @@ static void load_linux(PCMachineState *pcms,
>>       /* highest address for loading the initrd */
>>       if (protocol >= 0x203) {
>>           initrd_max = ldl_p(header+0x22c);
>> +        if (initrd_max == 0x7fffffff) {
>> +            /* for some reasons, initrd_max is hard code with 0x7fffffff
>> +             * hard code to 4G - 1 to allow 4G initrd
>> +             */
>> +            initrd_max = UINT32_MAX - 1;
>> +        }
> I don't understand this. If the header of the file we're using
> says "this is the maximum", then we should trust the header to
> in fact not be lying to us, shouldn't we ?
>
> If the kernel initrd creation process creates an initrd which
> is larger than 2GB and also claims that it can't be placed
> with any part of it above 2GB, then that sounds like a bug
> in the initrd creation process...

Exactly, it's a real problem.

Add x86 maintainers and LKML:

The background is that QEMU want to support up to 4G initrd. but linux header (
initrd_addr_max field) only allow 2G-1.
Is one of the below approaches reasonable:
1) change initrd_addr_max to 4G-1 directly simply(arch/x86/boot/header.S)?
2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header said 2G-1
3) any else






>
>>       } else {
>>           initrd_max = 0x37ffffff;
>>       }
> This patch should come last in the series: only after we have fixed all
> of QEMU's internal plumbing to handle larger initrd sizes should we
> enable it.

Got it.

Thanks
Zhijian

>
> thanks
> -- PMM
>
>
>



