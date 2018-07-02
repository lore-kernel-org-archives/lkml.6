Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8001C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D922560F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VodLd5ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D922560F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeGBCQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:16:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39419 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932182AbeGBCQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:16:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so7150020plq.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 19:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fwMCR5Z3a0wt4EK6mfbmR9coFp89MgRXywU6DGk/uDM=;
        b=VodLd5ra5xymI4efH0V3dyeq6wKdfv3JJJyoSY+la7I+T7jCbuKkP7nkKbAgCXPIgg
         60wzE8VwxwFOt6RzjLscvW2VepHkGfgD8d9rB48+UX/AI44Bcrjklzwhg+Mjg73fUbpc
         PEk+l85MGI/eYDME1Fdmm2FWpXGbZTE9c8vghk0ZBw89e3OXzrP6Q6cAr1FKmPYH778R
         8yt2NbYqqq31fikAxriaQc7Co9c6aY8I8l2VZ+VEUCEfoIjVeVlFSPnAijo33nCLKY7p
         kZEeD7Y2ktbts8Ki/y+DbEDvkfy01Vs+sQ6/Nl0FXPlYX022WIQJNh3DVaYRTjM6eYtQ
         eavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fwMCR5Z3a0wt4EK6mfbmR9coFp89MgRXywU6DGk/uDM=;
        b=e9iYrvaz0aJ5OK/p/I0xO//dflmoVRzdUqN0lStcCSQ5uBTlz22tCsuq1OpHhm7wI+
         YNs6WoNwDptFd59K821WJ482/th06rQfv56xNTek8LlABrjgkVr7muaZWvgUQZH3CNIy
         Ip2+fy60ncIUlC0kC8XwjW1HeWs4Kc7YzkMfRkQzVPRqhdbTW23QA/EV7lssSiA62cfT
         wyBvKbYgw79wr8+qmeDTbIaLTLInekl6P4aTOihqQ3dVxaeaq7dbJGSSVui+B5HTLQa4
         1uHRNLewToKpmSSgeEDKqhaPn4gqkNcxo54+un42hjfN8S4ehlq8VpqIdeIVrRz/tiFo
         ciYg==
X-Gm-Message-State: APt69E1REJvyFfIVleVUIad0UnHbg/CraFPOlQrHkl7RKk4KfyJRbFck
        OkQFJMWAduJ3dpJBL6KhDBYWLg==
X-Google-Smtp-Source: ADUXVKKgNOz+37EWTorcQ4Ibc93wBYc4eth+pD397z6hxJDj5/++tOmYbZ4S0wN/XhDAlDvUqIy+FA==
X-Received: by 2002:a17:902:a989:: with SMTP id bh9-v6mr24487948plb.245.1530497800320;
        Sun, 01 Jul 2018 19:16:40 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r90-v6sm25156643pfl.162.2018.07.01.19.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 19:16:39 -0700 (PDT)
Subject: Re: [PATCH] f2fs: Replace strncpy with memcpy
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
 <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <367fb12b-3ae0-4a6a-b59e-31d3a360bf05@roeck-us.net>
Date:   Sun, 1 Jul 2018 19:16:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2018 06:53 PM, Chao Yu wrote:
> On 2018/7/2 4:57, Guenter Roeck wrote:
>> gcc 8.1.0 complains:
>>
>> fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
>> fs/f2fs/namei.c:257:3: warning:
>> 	'strncpy' output truncated before terminating nul copying
>> 	as many bytes from a string as its length
>> fs/f2fs/namei.c:249:3: warning:
>> 	'strncpy' output truncated before terminating nul copying
>> 	as many bytes from a string as its length
>>
>> Using strncpy() is indeed less than perfect since the length of data to
>> be copied has already been determined with strlen(). Replace strncpy()
>> with memcpy() to address the warning and optimize the code a little.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   fs/f2fs/namei.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 231b7f3ea7d3..e75607544f7c 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
>>   		return -EINVAL;
>>   
>>   	if (hot) {
>> -		strncpy(extlist[count], name, strlen(name));
>> +		memcpy(extlist[count], name, strlen(name));
> 
> How about replacing with strcpy(extlist[count], name)? Because name length has
> already been checked before f2fs_update_extension_list, it should be valid, and
> will not cause overflow during copying.
> 

Your call; feel free to submit an alternative. Since it is different files, static
analysis might not know and complain, though. You might want to make sure that this
doesn't happen, and also add a comment explaining the reason for using strcpy().

Thanks,
Guenter
