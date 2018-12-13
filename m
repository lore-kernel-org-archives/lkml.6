Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE7C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5F220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5F220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeLMEjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:39:15 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54179 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728651AbeLMEjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:39:12 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07451554|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01534;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.DWhK5Rk_1544675945;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DWhK5Rk_1544675945)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 13 Dec 2018 12:39:06 +0800
Subject: Re: [PATCH] pstore: fix crypto dependencies of 842/zstd compression
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1544603038-9373-1-git-send-email-liaoweixiong@allwinnertech.com>
 <CAGXu5j+nTVoD=AMvOcn2bvA4C0mw=LKDbVnDWhUkL3c6mJye_g@mail.gmail.com>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <liaoweixiong@allwinnertech.com>
Message-ID: <44ffbb80-37ab-b597-459b-1037f42d726d@allwinnertech.com>
Date:   Thu, 13 Dec 2018 12:39:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+nTVoD=AMvOcn2bvA4C0mw=LKDbVnDWhUkL3c6mJye_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fast, there is no any failure while building or configuring on the 
newest codes.

The patch of commit 58eb5b670747 ("pstore: fix crypto dependencies") 
makes the pstore itself select the crypto core if PSTORE_COMPRESS is 
set. This fixes the dependence bug at all in my tests.
But this patch also turns the sub-options from 'bool' into 'tristate'. 
It's ok, but makes sub-options different between deflate, lzo, lz4, 
lz4hc and 842, zstd. So, my patch just keeps them in line.
How about to make all these sub-options as 'bool'? These compressions 
are just  function options but not module.  Otherwise, it's not about 
fixing crypto dependencies.

在 2018年12月13日 02:43, Kees Cook 写道:
> On Wed, Dec 12, 2018 at 12:24 AM liaoweixiong
> <liaoweixiong@allwinnertech.com> wrote:
>>
>> Reference to commit 58eb5b670747 ("pstore: fix crypto dependencies"),
>> which fixed crypto dependencies of deflate, lzo, lz4 and lz4hc
>> compression, but omitted 842 and newer compression zstd from
>> commit 1021bcf44d0e ("pstore: add zstd compression support")
>>
>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> 
> Were you seeing build or config failures without this patch?
> 
> -Kees
> 
>> ---
>>   fs/pstore/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>> index 0d19d19..7068f45 100644
>> --- a/fs/pstore/Kconfig
>> +++ b/fs/pstore/Kconfig
>> @@ -44,14 +44,14 @@ config PSTORE_LZ4HC_COMPRESS
>>            This option enables LZ4HC (high compression) mode algorithm.
>>
>>   config PSTORE_842_COMPRESS
>> -       bool "842 compression"
>> +       tristate "842 compression"
>>          depends on PSTORE
>>          select CRYPTO_842
>>          help
>>            This option enables 842 compression algorithm support.
>>
>>   config PSTORE_ZSTD_COMPRESS
>> -       bool "zstd compression"
>> +       tristate "zstd compression"
>>          depends on PSTORE
>>          select CRYPTO_ZSTD
>>          help
>> --
>> 1.9.1
>>
> 
> 
