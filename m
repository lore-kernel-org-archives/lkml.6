Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED81C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3DB2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5tDvRLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439223AbfBNObX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:31:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44269 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439209AbfBNObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:31:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so3177868pfh.11;
        Thu, 14 Feb 2019 06:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I8Ik0YH4DDrW+a6thIGf2C23HRpkqbBiYZr2uZywPpY=;
        b=Y5tDvRLhZ6rQkbiRs7d3HKRyS24zoQClPpfWDl+Spr3VuYuamhZ3mVJ6qy/QAy/1jT
         DpSKz6D6ewQNhVTJnsD0jJRXPLUW+DiaQKH5FF0aMSTR+7oDEZvV6CcNNdrbGlIHEMSm
         iT/BBp8995nTs48DszxC7diELMR1+KiVJ7HVOwmv6/zNPi/Nid/C3eOxAwyHS9kRxhn2
         2tZKpK0q5TBOF/Op21RumrnG9Oqr0iVeIRH/K5pNlkqQ5mD8gwLmWANa+OFqrlmGFO10
         ozqyUOpjqt6zgoVCMktaK1jOBuVZQsVRGbjoTGNuDFkEyb4skbP6OHqr7IvlXx0tSguZ
         apCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I8Ik0YH4DDrW+a6thIGf2C23HRpkqbBiYZr2uZywPpY=;
        b=Hd3dXcilaj1r8FZqLlqQaODTVS3B0eM4Gy/7QVU/6dXNVhC5KOjWNBSNv1ITKvw4km
         NNFN51+FIxoO+XX+/9vQe8tuj8BrMFhB906/7jV/JJOHHZqhKsAg9A/IVu194MBEN6pS
         8gIWE7Ec9jHsN6K6lpon7kM4BDX1OJqkixyrfe7q7CmpiPV/3txKQLQl1ZLeFGCpUvqB
         cBRAzYE8q3lIF/Tfp4hkh1N3Pdlp8GRaBv8sHGxp0///AQBIBQEHFqHWgu27POE+aL9L
         P3togMG2kvR79jZ0/YowN56hy6M8x7UXn43/yje0t2q6bpUH6gfuk77a6qnolZnAZDRA
         Buyw==
X-Gm-Message-State: AHQUAuZ5FnkHJQv6AMUfvUDzxujE0CZZrpPOwlKB3Q6CaEuB1tVKwIt+
        yqZTStQ9rXV9aAFT6Mj7eZD0ns+X
X-Google-Smtp-Source: AHgI3IaqEHkOh/inM9tGVYcR4/uvDKSgpswPQ8S0MekutQ7ow7Rkt+0wK6ZOPw17pOzdytZLaTlYsw==
X-Received: by 2002:a63:2bc6:: with SMTP id r189mr177603pgr.201.1550154680939;
        Thu, 14 Feb 2019 06:31:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e24sm3618055pfi.153.2019.02.14.06.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:31:19 -0800 (PST)
Subject: Re: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190131035411.53576-1-kyletso@google.com>
 <20190131070238.GA4500@kroah.com>
 <CAGZ6i=07EOHqd3r9y1MpYn_e1nFeYGt_wp9arhMZWWeTBm-udA@mail.gmail.com>
 <20190212105421.GA23271@kroah.com>
 <c838e214-4888-c708-6a7c-a8de6ecb5282@roeck-us.net>
 <AM5PR1001MB0994B54049DDCF2CE376263A80670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <85ea1e87-eaaa-1540-f693-5601bcafddf6@roeck-us.net>
Date:   Thu, 14 Feb 2019 06:31:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <AM5PR1001MB0994B54049DDCF2CE376263A80670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 6:17 AM, Adam Thomson wrote:
> On 12 February 2019 16:20, Guenter Roeck wrote:
> 
>> On 2/12/19 2:54 AM, Greg KH wrote:
>>> On Tue, Feb 12, 2019 at 06:29:39PM +0800, Kyle Tso wrote:
>>>> On Thu, Jan 31, 2019 at 3:02 PM Greg KH <gregkh@linuxfoundation.org>
>> wrote:
>>>>
>>>>> On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
>>>>>> Provide a function to get the partner Source Capabilities.
>>>>>>
>>>>>> Signed-off-by: Kyle Tso <kyletso@google.com>
>>>>>> ---
>>>>>>    drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
>>>>>>    include/linux/usb/tcpm.h      |  1 +
>>>>>>    2 files changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c
>>>>> b/drivers/usb/typec/tcpm/tcpm.c
>>>>>> index f1d3e54210df..29cd84ba9960 100644
>>>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>>>>> @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct
>>>>> tcpm_port *port, const u32 *pdo,
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
>>>>>>
>>>>>> +/*
>>>>>> + * Don't call this function in interrupt context. Caller needs to
>>>>>> +free
>>>>> the
>>>>>> + * memory itself.
>>>>>> + */
>>>>>> +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32
>>>>>> +**src_pdo) {
>>>>>> +     unsigned int nr_pdo;
>>>>>> +
>>>>>> +     if (port->nr_source_caps == 0)
>>>>>> +             return -ENODATA;
>>>>>> +
>>>>>> +     *src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
>>>>>> +     if (!src_pdo)
>>>>>> +             return -ENOMEM;
>>>>>> +
>>>>>> +     mutex_lock(&port->lock);
>>>>>> +     nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
>>>>>> +                             port->nr_source_caps);
>>>>>> +     mutex_unlock(&port->lock);
>>>>>> +     return nr_pdo;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
>>>>>
>>>>> We don't add new functions that no one uses :(
>>>>>
>>>>>
>>>> This function is useful if the PD Device Policy Manager is
>>>> implemented outside of TCPM.
>>>> In this situation, Device Policy Manager needs to know the partner
>>>> capabilities to optimize the charging process.
>>>
>>> And where is that code?
>>>
>>
>> Agreed - that code should be sent upstream as well to let us see the entire
>> context.
>>
>>>> Take existing functions in TCPM for example:
>>>> Function "tcpm_update_sink_capabilities" and
>>>> "tcpm_update_source_capabilities" are exposed as well. And no one
>>>> uses them now.
>>>
>>> Great, let's go delete them now, we should not have apis that no one
>>> uses.  This isn't a new thing...
>>>
>>
>> I sent a patch to do just that. Quite frankly I don't recal why I thought those
>> functions might be needed.
> 
> As a mind jog - https://lkml.org/lkml/2017/11/27/1256 :)
> 

Nice find. However, since the code using it was never implemented, I think it
is prudent at this point to remove the code. It can be reintroduced if/when needed,
and at that point be tested properly.

Thanks,
Guenter
