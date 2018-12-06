Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A1E20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="xFn+U2S8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A1E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbeLFPDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:03:22 -0500
Received: from mail.servus.at ([193.170.194.20]:42442 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFPDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:03:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 09EC53000677;
        Thu,  6 Dec 2018 16:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1544108595; x=1545922996; bh=cZU1VIYFLEmizqfIsx0jsIbFJg4eMU6C+gj
        dJRdAXhM=; b=xFn+U2S8aMCQzz2rn7IB4LRD5eYwTkLPsB8aB9buPJWqRqpQ8TD
        s9c9cqzT2nVCiItX8HS8gooCQhzKEKaUJ9zHH7SIyc52CQ079T0TFtP95roOWVWB
        9rIsmbZMfGw/Mwm/HFzgfvjRdGBTmb5LfXpZVSpk6JpbxMiz0UyCA4aE=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RtW1H1XHm4ih; Thu,  6 Dec 2018 16:03:15 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id 32F87300067D;
        Thu,  6 Dec 2018 16:03:13 +0100 (CET)
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
To:     Yueyi Li <liyueyi@live.com>, "dsterba@suse.cz" <dsterba@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <5C0654EE.5040001@oberhumer.com>
 <SN1PR13MB030484F09EE8A00DB094CDFADFA80@SN1PR13MB0304.namprd13.prod.outlook.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
Message-ID: <5C093A30.4020705@oberhumer.com>
Date:   Thu, 6 Dec 2018 16:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <SN1PR13MB030484F09EE8A00DB094CDFADFA80@SN1PR13MB0304.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yueyi,

yes, my LZO patch works for all cases.

The reason behind the issue in the first place is that if KASLR
includes the very last page 0xfffffffffffff000 then we do not have a
valid C "pointer to an object" anymore because of address wraparound.

Unrelated to my patch I'd argue that KASLR should *NOT* include the
very last page - indeed that might cause similar wraparound problems
in lots of code.

Eg, look at this simple clear_memory() implementation:

void clear_memory(char *p, size_t len) {
        char *end = p + len;
        while (p < end)
                *p++= 0;
}

Valid code like this will fail horribly when (p, len) is the very
last virtual page (because end will be the NULL pointer in this case).

Cheers,
Markus



On 2018-12-05 04:07, Yueyi Li wrote:
> Hi Markus,
> 
> Thanks for your review.
> 
> On 2018/12/4 18:20, Markus F.X.J. Oberhumer wrote:
>> Hi,
>>
>> I don't think that address space wraparound is legal in C, but I
>> understand that we are in kernel land and if you really want to
>> compress the last virtual page 0xfffffffffffff000 the following
>> small patch should fix that dubious case.
> 
> I guess the VA 0xfffffffffffff000 is available because KASLR be
> enabled. For this case we can see:
> 
> crash> kmem 0xfffffffffffff000
>        PAGE               PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffffbfffffffc0        1fffff000 ffffffff1655ecb9  7181fd5  2 
> 8000000000064209 locked,uptodate,owner_priv_1,writeback,reclaim,swapbacked
> 
>> This also avoids slowing down the the hot path of the compression
>> core function.
>>
>> Cheers,
>> Markus
>>
>>
>>
>> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
>> index 236eb21167b5..959dec45f6fe 100644
>> --- a/lib/lzo/lzo1x_compress.c
>> +++ b/lib/lzo/lzo1x_compress.c
>> @@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
>>   
>>          while (l > 20) {
>>                  size_t ll = l <= (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
>> -               uintptr_t ll_end = (uintptr_t) ip + ll;
>> -               if ((ll_end + ((t + ll) >> 5)) <= ll_end)
>> +               // check for address space wraparound
>> +               if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <= (uintptr_t) ip)
>>                          break;
>>                  BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
>>                  memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
> I parsed panic ramdump and loaded CPU register values,  can see:
> 
> -000|lzo1x_1_do_compress(
>      |    in = 0xFFFFFFFFFFFFF000,
>      |  ?,
>      |    out = 0xFFFFFFFF2E2EE000,
>      |    out_len = 0xFFFFFF801CAA3510,
>      |  ?,
>      |    wrkmem = 0xFFFFFFFF4EBC0000)
>      |  dict = 0xFFFFFFFF4EBC0000
>      |  op = 0x1
>      |  ip = 0x9
>      |  ii = 0x9
>      |  in_end = 0x0
>      |  ip_end = 0xFFFFFFFFFFFFFFEC
>      |  m_len = 0
>      |  m_off = 1922
> -001|lzo1x_1_compress(
>      |    in = 0xFFFFFFFFFFFFF000,
>      |    in_len = 0,
>      |    out = 0xFFFFFFFF2E2EE000,
>      |    out_len = 0x00000001616FB7D0,
>      |    wrkmem = 0xFFFFFFFF4EBC0000)
>      |  ip = 0xFFFFFFFFFFFFF000
>      |  op = 0xFFFFFFFF2E2EE000
>      |  l = 4096
>      |  t = 0
>      |  ll = 4096
> 
> ll = l = in_len = 4096 in lzo1x_1_compress,  so your patch is working 
> for this panic case, but, I`m
> not sure, is it possible that in = 0xFFFFFFFFFFFFF000 and  in_len < 4096?
> 
> 
> Thanks,
> Yueyi
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
