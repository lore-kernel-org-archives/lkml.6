Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA64C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641462086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641462086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIKW2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:28:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45451 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeIKW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:28:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id g44-v6so29047148qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aOL5qmgeiuDuN0JS8Zgz+3H3T6uZdosMbUhAIM4NdZM=;
        b=gEpsEOuUsEyVD9CX0RKwqxvbWHZh2v2NSBU/Wy+CETal+te8TNxZZqYjeUIti9ja+p
         XXHx9qJAxkOJpVUEYIj0hdPxEIEUILxzPaaPQGHpiTX177qIttMGoOwhi4erpX0qiGPt
         mSiT/iDZYgo1AUWRptXf/Zrqz6pggAzJRcYjBbE1C3zIhfteSc6HEdZn38DZcMHh/lLv
         HBWP/2x8P3lnqR/ueMQ4XZ4ZI2MZOemMrAk7QCVAO0UPoISNS69MYTtcSAT0hdQt7E/E
         zde67QL2qE/BWuUvvoT/AtRtoKWq1CK5ACINzChgTE463uxXuTZFi1T9FWb7yX2g+WDu
         STbw==
X-Gm-Message-State: APzg51CYXEf5z5HbfvSwL+eYvvXGqxPl3pAljyiEq7CNrOasyBuvIDbV
        lhOYQWqc2c4HmmSn2QkOfWggrFjW27w=
X-Google-Smtp-Source: ANB0VdbazMPxne4NjWlyBd81w7x2XJdDLMdcxxgIRjU/cJG4Rk7D8u/BBW0p4m1HMwqH0k1Abb/E7A==
X-Received: by 2002:a0c:c503:: with SMTP id x3-v6mr19123088qvi.82.1536686903730;
        Tue, 11 Sep 2018 10:28:23 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::42c3? ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id n8-v6sm10463841qte.25.2018.09.11.10.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 10:28:22 -0700 (PDT)
Subject: Re: [PATCH] misc: kgdbts: Fix restrict error
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180910230456.9220-1-labbott@redhat.com>
 <20180911091940.roriqov64ayk7mfs@holly.lan>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <8d149627-6550-4a5c-b136-6acdb713b724@redhat.com>
Date:   Tue, 11 Sep 2018 10:28:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911091940.roriqov64ayk7mfs@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 02:19 AM, Daniel Thompson wrote:
> On Mon, Sep 10, 2018 at 04:04:56PM -0700, Laura Abbott wrote:
>> kgdbts current fails when compiled with restrict:
>>
>> drivers/misc/kgdbts.c: In function ‘configure_kgdbts’:
>> drivers/misc/kgdbts.c:1070:2: error: ‘strcpy’ source argument is the same as destination [-Werror=restrict]
>>    strcpy(config, opt);
>>    ^~~~~~~~~~~~~~~~~~~
>>
>> As the error says, config is being used in both the source and destination.
>> Refactor the code to only do the copy when needed.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   drivers/misc/kgdbts.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
>> index 6193270e7b3d..4447ad68ea39 100644
>> --- a/drivers/misc/kgdbts.c
>> +++ b/drivers/misc/kgdbts.c
>> @@ -1061,20 +1061,23 @@ static void kgdbts_run_tests(void)
>>   	configured = 0;
>>   }
>>   
>> -static int kgdbts_option_setup(char *opt)
>> +static void kgdbts_set_verbose(void)
>>   {
>> -	if (strlen(opt) >= MAX_CONFIG_LEN) {
>> -		printk(KERN_ERR "kgdbts: config string too long\n");
>> -		return -ENOSPC;
>> -	}
>> -	strcpy(config, opt);
>> -
>>   	verbose = 0;
>>   	if (strstr(config, "V1"))
>>   		verbose = 1;
>>   	if (strstr(config, "V2"))
>>   		verbose = 2;
>> +}
>>   
>> +static int kgdbts_option_setup(char *opt)
>> +{
>> +	if (strlen(opt) >= MAX_CONFIG_LEN) {
>> +		printk(KERN_ERR "kgdbts: config string too long\n");
>> +		return -ENOSPC;
>> +	}
>> +	strcpy(config, opt);
>> +	kgdbts_set_verbose();
> 
> I know this is honouring the existing code paths but I think
> kgdbts_set_verbose() is redundant here. Directly setting up verbose from
> kgdbts_run_tests() where the rest of the config string is parsed should
> be sufficient.
> 
> Having said that I don't want to bounce perfectly correct fixes just
> because they could have done more. Do you want to send a v2 or prefer me
> to put further clean up on my TODO list?
> 
> 

I'll go ahead and send a v2

> Daniel.
> 
>>   	return 0;
>>   }
>>   
>> @@ -1086,9 +1089,7 @@ static int configure_kgdbts(void)
>>   
>>   	if (!strlen(config) || isspace(config[0]))
>>   		goto noconfig;
>> -	err = kgdbts_option_setup(config);
>> -	if (err)
>> -		goto noconfig;
>> +	kgdbts_set_verbose();
>>   
>>   	final_ack = 0;
>>   	run_plant_and_detach_test(1);
>> -- 
>> 2.17.1
>>

