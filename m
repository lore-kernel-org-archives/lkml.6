Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C6C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C92C20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu4qdNEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C92C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeG2UXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:23:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37396 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeG2UXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:23:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so11192696wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uAfx1SNii1vB7GtVrBep3OuufAgeBtsjdOhOJ4GN/zk=;
        b=Iu4qdNEaOFrmE3x74c6tiIoGTXw0XuwX9zi26jy0pnHGJjXaFB4bpjRO1UVaWJ6nY7
         6jlQW3nkGB+khqa81gZoet8wz7Zec15AwFnmnh6lXLogOg8sVIBxjd0yZtIeOIfU3QTQ
         F544XFD726SFUr2n2gsZLuYiyDYHRX8mJv6PenoU2ckIng/Ds7cWccrnfGL8WVf/QA1n
         b9Sn/94PFdGUPv1orxHaC0YCtAFQQxmWe8tEF7s5IIJ/+N3s76ho1zkAHpsJIxajXRtg
         m9dQbA3uXoN4EgZx9K+ydQpGttFiWV6kuwx3y7s4EOjkYBkZ1AmHbMt25D/EJalSadm8
         mB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAfx1SNii1vB7GtVrBep3OuufAgeBtsjdOhOJ4GN/zk=;
        b=aAhuuHa+YGJtMAFkBMmLCSsIrFF+RRLcqBVCZLI56mJ0x/BPuO2kO9DKQxSXN+UtK0
         +gPOcEpL6ViLHO68ZNMVftMncBd9HxYf29ePkHTyOTA+yvs+0wDdT9xvkcmUkrmNt83G
         ZHfIqQL9ZgVRRHh6hW7VRHMOLHH2TU8jBxNf2BdG6WFUfUbfb6py31Ip6kghPLxOvIrp
         kLMDvxKve576F20G9kmHG9VkFbC9W/OZrS9PJZFR30IH1oAnTrio/B6bQ8VVb64YyIb3
         fap9oSWbihwOsP9VpQY2qJQJWs4bm3PewD6J0wMGxvJl87/RRdcsQxYmz5jT0DzPoONs
         dbRQ==
X-Gm-Message-State: AOUpUlHv+e1f40QMM4eVScI5CkiF/aaj+KN9HtE6JqkFXxhZqHTOCvuU
        sZl0OJsQFvq6UlUVtWff6wYcRNFE
X-Google-Smtp-Source: AAOMgpdrUp4T8//EuPoXD70EksBAmOjLFJ9yVG8YLT7Z5IEeERPSTUmpXR7H4MiAbjOuinM3dFlI/A==
X-Received: by 2002:a1c:9f86:: with SMTP id i128-v6mr11726411wme.156.1532890318518;
        Sun, 29 Jul 2018 11:51:58 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id y102-v6sm15716883wmh.9.2018.07.29.11.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:51:58 -0700 (PDT)
Subject: Re: [PATCH 8/8] staging: rtl8188eu: use is_broadcast_ether_addr
From:   Michael Straube <straube.linux@gmail.com>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180729170851.2581-1-straube.linux@gmail.com>
 <20180729170851.2581-8-straube.linux@gmail.com>
 <07a456ef0b1163115ef9aeb717120c191263fe28.camel@perches.com>
 <90fb5087-22df-0480-548a-7658881181c8@gmail.com>
 <12e1804800e490aa57b51a0e64c6da573d32a3a4.camel@perches.com>
 <85e40925-21aa-1030-24ed-9dce498b98f6@gmail.com>
Message-ID: <d4c695a5-39fe-4f96-49fb-58e574ec8cb2@gmail.com>
Date:   Sun, 29 Jul 2018 20:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <85e40925-21aa-1030-24ed-9dce498b98f6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/18 20:21, Michael Straube wrote:
> On 07/29/18 19:59, Joe Perches wrote:
>> On Sun, 2018-07-29 at 19:42 +0200, Michael Straube wrote:
>>> On 07/29/18 19:21, Joe Perches wrote:
>>>> On Sun, 2018-07-29 at 19:08 +0200, Michael Straube wrote:
>>>>> Use is_broadcast_ether_addr instead of checking each byte of the
>>>>> address array for 0xff. Shortens the code and improves readability.
>>>>
>>>> You should show in the commit log that sta_addr is __aligned(2)
>>>> as required by is_broadcast_ether_addr, otherwise you could be
>>>> introducing runtime alignment defects.
>>>>
>>>
>>> Ok, sta_addr is used from following structs.
>>>
>>> struct ieee_param {
>>>           u32 cmd;
>>>           u8 sta_addr[ETH_ALEN];
>>>           union {
>>>           ...
>>>           ...
>>>           }; u
>>> };
>>>
>>> struct ieee_param_ex {
>>>     u32 cmd;
>>>     u8 sta_addr[ETH_ALEN];
>>>     u8 data[0];
>>> };
>>>
>>> Well, looking at it now, I'm not sure about the alignment anymore
>>> in the struct that contains the union. Is sta_addr in the first
>>> struct __aligned(2)?
>>>
>>> Should I include the snippets in the commit message, or is just
>>> writing that sta_addr is __aligned(2) enough? (if it is in the
>>> first case...)
>>
>> It's enough to just state that the uses are properly aligned
>> as long as you looked and understand that it's required.
>>
> 
> Ok, thank you.
> 
> I looked at it and understand that it's required.
> But, as mentioned, at second look I'm not sure about the union.
> 
> I guess I need to read a little more about the alignment of unions.

For now I will resend the series without this patch.
I don't feel comfortable with sending something I don't fully understand, yet.

Michael
