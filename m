Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35ECC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F598216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F598216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHHKYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:24:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45557 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:24:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so793844edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 01:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QofuaJ8L8VeMsPFOVUQ7ZlpCgsRw+2WbqN0ZYQuimcQ=;
        b=PXc2IP3Cf5bcIQmtvd4JP/ibnnWTpqZ21vvR6AoQ14ywjGWwQsg54SeFWLtYAYym5d
         M7PrbQ4UMvh1mkMBIOXYQstwE7xYyjaN+s51uyFhsxCkNc2PTrZYVxxAJv6kvK/1zkMT
         nu7GzM6jyp9ISpBBhAYexDyCVPgGeWQHJxj6KSFY4rj+rhflcL4haMq0kJYiOfN2m3JR
         Bv8WvQWJgu8xPgje7CGEa/CvOfrSTiIrrvUBRgWdOlQh7Eg93csXcLU4lZjxpxkamTMe
         rjkmufWptj3dPFU4Q2QVqr7Wb9BBlWTpqmLF7elhsZuQPqJAa3W+vrcCrQJAWzf7uIen
         UflA==
X-Gm-Message-State: AOUpUlHgEau3nScceOBDsEsqbXtBoISqw1N0uhNamGfWz+CWBb279Mnw
        kH6ZnJHZjYXS4UfDLQxgBFkQ5w==
X-Google-Smtp-Source: AA+uWPzflM/W+CKCs2zjSdLWB4fRPo+4TdBbjukSBraRGV0vYjieICP2CLk38sS2f/u5hxX4O/aITw==
X-Received: by 2002:a50:8b65:: with SMTP id l92-v6mr2051732edl.44.1533715558676;
        Wed, 08 Aug 2018 01:05:58 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k17-v6sm2391102edb.0.2018.08.08.01.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:05:57 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-5-hdegoede@redhat.com>
 <20180807112701.5iukqa6m5atf22fw@ninjato>
 <9e17dfca-901b-79c9-b562-4f893d7ae44b@redhat.com>
 <af71656fda0f94e77a136bd50381713020660638.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c85dd145-2837-6a4d-c848-9604a5d3662f@redhat.com>
Date:   Wed, 8 Aug 2018 10:05:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <af71656fda0f94e77a136bd50381713020660638.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-08-18 13:45, Andy Shevchenko wrote:
> On Tue, 2018-08-07 at 13:33 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 07-08-18 13:27, Wolfram Sang wrote:
>>> Hi Hans,
>>>
>>>> +I2C MULTI INSTANTIATE DRIVER
> 
> In the case below, I think it would be slightly better to mention ACPI
> here, something like
> 
> ACPI I2C ...
> 
> Otherwise it sounds a bit confusing why it's in PDx86.

Ok, fixed for the upcoming v4 of this patchset.

Regards,

Hans


> 
>>>> +M:	Hans de Goede <hdegoede@redhat.com>
>>>> +L:	linux-i2c@vger.kernel.org
>>>
>>> Since this driver is about FW bugs, I wonder if
>>> platform-driver-x86@vger.kernel.org isn't the better list here?
>>
>> Ok, fixed for v4.
>>
>>>> +S:	Maintained
>>>> +F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c
>>>
>>> I2C parts of the rest looks good from a glimpse...
>>
>> Thanks.
>>
>> Regards,
>>
>> Hans
> 
