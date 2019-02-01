Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A26C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B0820863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYruMBcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfBAO3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:29:16 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36650 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBAO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:29:15 -0500
Received: by mail-yb1-f193.google.com with SMTP id 64so2724658ybf.3;
        Fri, 01 Feb 2019 06:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=41Adg7DB31aKVRgt8DbNhNlbpU9yjOns/3+6Ddh3bPY=;
        b=lYruMBcsM5UnhhfGTGZqPkx+jYeW7F9UhX8vJf6BSLTxnuktw9xM3HpsSN5pKEI3OC
         rxsDdE1px84mDmEc9jTXvjSvFtDXSXyJCs982INcjDoEqir3P8DFi3Avqh7DBgPe5j5w
         0ZX1BN/YNq5pi6CIMcFcFKF+nxykMj3eEXB4l9f9oCeP5CRBfTY6hcEKy6ueP0XSV4Fy
         tpKPqa31m2yM5sAhk80+sA9BTJdsWEL1TvELBhv/6seTmIfuYa1Rd+W8ZBYawF2YoZRc
         gVK4HqSnLyIQ6XViUUNIr5PYiHZkwEVK6mNB5JJLaMYCLxxh4Y9ZolghgjD8LWDdb2ic
         vOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41Adg7DB31aKVRgt8DbNhNlbpU9yjOns/3+6Ddh3bPY=;
        b=prJXUKZDs8egHkQASqf+7vus6bgrWn4JtOzOvlm1El1btTnu8PBGb/oJvToFNQjnfq
         +jx8sCCT5rKe97jqPce3wE0jefiXyUGI7gYNYD1ZUEoW5OTxI6YLjhXEV8YB9Cfhp8PY
         wVldBop5v87HzTAtyeNiPs8ENniolPM0cbn+RrQAtzxFPQqxE9Z+xOfItVMBelKWgTBB
         9bLtoUqkncXv+l+TgZztwk+LHbGfT+zWqqwFApqbmj22iRwtp8RtNZmPrIThF8iAHUFD
         TxBmjNjo7Sn88h3Zj5VbxmCNNjvMS32L5A5hkrroIN7ysRJh5teNsSSlsvb3UJJUZBL4
         kQ8g==
X-Gm-Message-State: AHQUAubgnc1xMkUF8BdgS9yYEBcoYuG/Srbj+DrhtZr0mBIEHVUwVgZH
        9YyKuwuCRaNYfldijof5U3FcD5vs2is=
X-Google-Smtp-Source: AHgI3IZa2/dj4MKAvHhDmqTGFCyCXjPHCAoSRAd2FgzAWnlT1Mx0a2KiKHPiz7UcqKYRJO/ifSXjnQ==
X-Received: by 2002:a25:d896:: with SMTP id p144mr25585042ybg.225.1549031354829;
        Fri, 01 Feb 2019 06:29:14 -0800 (PST)
Received: from [192.168.100.2] ([187.38.229.162])
        by smtp.gmail.com with ESMTPSA id z186sm2608936ywd.107.2019.02.01.06.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 06:29:14 -0800 (PST)
Subject: Re: [PATCH] iio:potentiostat:lmp91000: solve codestyle WARNINGs and
 CHECKs
To:     Joe Perches <joe@perches.com>, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
References: <20190129183656.15656-1-lucasseikioshiro@gmail.com>
 <a8ae5209f676171a97cae7211411e7ced3ebefbc.camel@perches.com>
From:   LSO <lucasseikioshiro@gmail.com>
Message-ID: <d2c70e04-f20c-6847-9740-d883c327c55f@gmail.com>
Date:   Fri, 1 Feb 2019 12:29:11 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a8ae5209f676171a97cae7211411e7ced3ebefbc.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 29/01/2019 20:48, Joe Perches wrote:
> On Tue, 2019-01-29 at 16:36 -0200, Lucas Oshiro wrote:
>> Solve most of the checkpatch.pl WARNINGs and CHECKs on lmp9100.c. They
>> are the following:
>>
>> lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
>> lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'
>> lmp91000.c:214: CHECK: braces {} should be used on all arms of this statement
>> lmp91000.c:216: CHECK: Unbalanced braces around else statement
>> lmp91000.c:258: WARNING: line over 80 characters
>> lmp91000.c:279: CHECK: Please don't use multiple blank lines
> 
> Some will say this is too many things to do at once.
> I think it's mostly fine, but there are a few nits
> that also could use fixing.
> 
>> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> []
>> @@ -211,9 +211,9 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>>   
>>   	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>>   	if (ret) {
>> -		if (of_property_read_bool(np, "ti,external-tia-resistor"))
>> +		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
>>   			val = 0;
>> -		else {
>> +		} else {
>>   			dev_err(dev, "no ti,tia-gain-ohm defined");
>>   			return ret;
>>   		}
> 
> This could use inverting the test
> 
> 	if (ret) {
> 		if (!of_property_read_bool(...)) {
> 			dev_err(dev, "no ti,ti-gain-ohm defined\n");
> 			return ret;
> 		}
> 		val = 0;
> 	}
>
Thanks for the suggestion, I'll do that in the next version.

> Also the dev_err is missing a '\n' termination

My aim in this patch was only solve style problems, but I
can put that missing '\n' too. Do you think it could be done
in the same commit or it's a better idea do it in another
commit and send both as a patchset?
> 
> 
