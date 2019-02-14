Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44162080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="anzzR5Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfBNSA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:00:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36656 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390777AbfBNSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:00:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so3474118pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q7Cx/Crhp0no8GWc+NeB1APfLt8OgYRtu//UB0ro46A=;
        b=anzzR5SaedAZk06QdlqvK+8aQPBhG9BdoVepDvnS3cjH3q/C1I5PR3laMdjNkIk79t
         zl1HnLZEudBmNNMcb+DXfd16DadgKrUA196LSd4LQDkvkoCp2GushiA4nOle4eoLEbtb
         LKTWP75+TYEBq3Cu0Sn7n49S7ZaJjee0qz7Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q7Cx/Crhp0no8GWc+NeB1APfLt8OgYRtu//UB0ro46A=;
        b=rS1NKbuV+rBRcVAB8oMm7UBuBNkjl4/gjMo/MZgNACxq0kMr4zeThEHnrPnbJ6IOSx
         P+VqCuqRDTNkTziMmvO2MjYeagoOh0eAroyU53ueVervTXwuLBDKKN6wwdLBgM5mROEL
         WYvqPsfmnl1jjkpCqdREhOVEtp391X0XzL+HiaDo3MdQ83mkec8bU7pIicHaaSFPTErk
         aRR/sx65m2537X6lsOfPm8tVz6k6Na7ws/xV+awk+2pFIgRwCqft/8pnZWUTRgqCYDgL
         LFjU0g2323yqdBEnrZZgI/lPPa9l60gzjQN0j9nEFrgBT58FDq7JgXfBmQNV+cjG/Ydv
         pmtA==
X-Gm-Message-State: AHQUAub3WIBrb07Hq1E6ItexOiYuPnlClteB2/9jNufHdpWM1NY5mV7g
        T/wHjKiYlrWz2XVTnPjwgLY4hw==
X-Google-Smtp-Source: AHgI3IbBRg4BeV7A2tfIPWRmuJqA1lhebwzeYtQKTwpatkwrrACg9uMGbIVwx0n641kDDjpl+u8dSA==
X-Received: by 2002:a65:610f:: with SMTP id z15mr1043149pgu.153.1550167255854;
        Thu, 14 Feb 2019 10:00:55 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m7sm7238498pfj.162.2019.02.14.10.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:00:54 -0800 (PST)
Subject: Re: [PATCH] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush
 timeout issue
To:     Scott Branden <scott.branden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190204192129.93533-1-ray.jui@broadcom.com>
 <dc8e7d9b-51fb-d216-d85c-915dda7d18ae@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c1307907-47ce-7081-547f-1a3f5fe1633b@broadcom.com>
Date:   Thu, 14 Feb 2019 10:00:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <dc8e7d9b-51fb-d216-d85c-915dda7d18ae@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

Have you had a chance to review this fix? This is a critical fix for a
crash during driver shutdown.

Regards,

Ray

On 2/4/2019 11:22 AM, Scott Branden wrote:
> Fix looks good.
> 
> On 2019-02-04 11:21 a.m., Ray Jui wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> RING_CONTROL reg was not written due to wrong address, hence all
>> the subsequent ring flush was timing out.
>>
>> Fixes: a371c10ea4b3 ("mailbox: bcm-flexrm-mailbox: Fix FlexRM ring
>> flush sequence")
>>
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c
>> b/drivers/mailbox/bcm-flexrm-mailbox.c
>> index d713271ebf7c..a64116586b4c 100644
>> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
>> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
>> @@ -1396,9 +1396,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
>>         /* Clear ring flush state */
>>       timeout = 1000; /* timeout of 1s */
>> -    writel_relaxed(0x0, ring + RING_CONTROL);
>> +    writel_relaxed(0x0, ring->regs + RING_CONTROL);
>>       do {
>> -        if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
>> +        if (!(readl_relaxed(ring->regs + RING_FLUSH_DONE) &
>>                 FLUSH_DONE_MASK))
>>               break;
>>           mdelay(1);
