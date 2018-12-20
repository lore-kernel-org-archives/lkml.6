Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC13C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1193E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNVaC280"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbeLTRt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:49:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46107 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbeLTRt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:49:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so2001108lfc.13;
        Thu, 20 Dec 2018 09:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9PD5IUtbrUQOAUKV5EkOEWfoDu9dse6LjWVMzTkzTzA=;
        b=uNVaC280eFpeI3adOgwn5GC6b7w/FIdMufAADPXoDlo6WEoI9J10Y+FWhHXh2dwU0M
         fhBsfZ6PbzPd2cllGUS0X+3bSTiuq7fxfbR0BcCTC9DiiLNtHDvfSZcqKw0+bId0XbKr
         dHMrxIBBfO8v9TRy7barwV/CT6Le47/AjmOWrrnnAYjDgQjJmfc72rWywAQ3xOwvX8Sx
         KIKz8RH5y/PHM8iIUDV/i/uf8+5HKaIcSu/Z1gJHk1VokqNfNgXkpJHYzx48lGtH+5LH
         9HXfnA7eDjoOCbBr69K4MHJgupPv51QNWM2CElp0JlH95NCw1GKPNd/X8kyIW3lvimNI
         3dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9PD5IUtbrUQOAUKV5EkOEWfoDu9dse6LjWVMzTkzTzA=;
        b=CI1bTkj9AG8LnOOnqkOEkUGHq7qI9Q7ZFmVAgl+GgSLidqBNdRU+9nxwm4ZPtD180d
         f2nnhPqlyOc9JqL0efKyemGfVJpAHOR7z9SfrI6I67mHHeuZ2/68rXaZ0xqALVn58cI3
         rSesj+C2RRtEwjoxSwGBdvI1jYhSsZWwYTAPjmkbDslu0PIlY7IbOPcXHMhGtVSMu/fi
         Um1JOOcbrd/mNL0qUXTas49+Q0Ey4WmbDxCRhyrnthdNQim+oh1aPCBY91T8jQmu8BlQ
         8IPn73W006KtVGj3SGy5qaYsiPJk+q7dQ4ceWJ6gPlI4GhADVuTilDY6VHNO/z5PZ7IY
         mfvw==
X-Gm-Message-State: AA+aEWYtUts0WJvXxpnb5KuTsAuWMmE5de2Xf+HKt4gdOqRoU4oruISf
        WSYqLF+L+80DWeyLERlNsvzg2LndTQ8=
X-Google-Smtp-Source: AFSGD/XyEyilPnztbosq7KHrRr3/7fKCjTF2BWRtxoBtOnDl5w3XyTaO39b/h459Bd/l6y3IEZ3mNQ==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr16372028lfe.45.1545328195537;
        Thu, 20 Dec 2018 09:49:55 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id e14-v6sm4093717ljb.31.2018.12.20.09.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:49:54 -0800 (PST)
Subject: Re: [PATCH 11/12] IMA: turn ima_policy_flags into __wr_after_init
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-12-igor.stoppa@huawei.com>
 <87pntwumw6.fsf@morokweng.localdomain>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <bb8cb502-d958-c4b4-eb82-603799079b63@gmail.com>
Date:   Thu, 20 Dec 2018 19:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87pntwumw6.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/12/2018 19:30, Thiago Jung Bauermann wrote:
> 
> Hello Igor,
> 
> Igor Stoppa <igor.stoppa@gmail.com> writes:
> 
>> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
>> index 59d834219cd6..5f4e13e671bf 100644
>> --- a/security/integrity/ima/ima_init.c
>> +++ b/security/integrity/ima/ima_init.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/scatterlist.h>
>>   #include <linux/slab.h>
>>   #include <linux/err.h>
>> +#include <linux/prmem.h>
>>
>>   #include "ima.h"
>>
>> @@ -98,9 +99,9 @@ void __init ima_load_x509(void)
>>   {
>>   	int unset_flags = ima_policy_flag & IMA_APPRAISE;
>>
>> -	ima_policy_flag &= ~unset_flags;
>> +	wr_assign(ima_policy_flag, ima_policy_flag & ~unset_flags);
>>   	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
>> -	ima_policy_flag |= unset_flags;
>> +	wr_assign(ima_policy_flag, ima_policy_flag | unset_flags);
>>   }
>>   #endif
> 
> In the cover letter, you said:
> 
>> As the name implies, the write protection kicks in only after init()
>> is completed; before that moment, the data is modifiable in the usual
>> way.
> 
> Given that, is it still necessary or useful to use wr_assign() in a
> function marked with __init?

I might have been over enthusiastic of using the wr interface.
You are right, I can drop these two. Thank you.

--
igor
