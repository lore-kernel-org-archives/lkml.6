Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC147EB8153
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B296E2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B296E2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbeGLSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:42:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:54707 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeGLSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:42:50 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1fdgNk-0001mi-UQ; Thu, 12 Jul 2018 20:32:01 +0200
Received: from [188.174.121.149] (helo=[192.168.178.33])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fdgNk-000Dud-NU; Thu, 12 Jul 2018 20:32:00 +0200
Subject: Re: [PATCH 4/5] iio:adxl372: Add sampling frequency support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stefan Popa <stefan.popa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1531409786-20180-1-git-send-email-stefan.popa@analog.com>
 <CAHp75Ve+S7UDyLva_PY4s=cjKoSY+aMfWDUEHb6tp4AxGtGsDg@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4bfc67b7-b062-a8cb-8a30-ccd117d67db9@metafoo.de>
Date:   Thu, 12 Jul 2018 20:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve+S7UDyLva_PY4s=cjKoSY+aMfWDUEHb6tp4AxGtGsDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24746/Thu Jul 12 14:54:54 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 08:25 PM, Andy Shevchenko wrote:
> On Thu, Jul 12, 2018 at 6:36 PM, Stefan Popa <stefan.popa@analog.com> wrote:
>> This patch adds the option for the user to select the sampling frequency.
>> Also, the user can read the available frequencies and read the currently
>> set frequency via the read_raw function. The frequency can be set via the
>> write_raw function.
>>
>> When the frequency is set, the bandwidth is also checked and ensured
>> that it is constrained to at most half of the sampling frequency.
> 
>> +static int adxl372_find_closest_match(const int *array,
>> +                                     unsigned int size, int val)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < size; i++) {
>> +               if (val <= array[i])
>> +                       return i;
>> +       }
>> +
>> +       return size - 1;
>> +}
> 
> Perhaps it's time to extend bsearch with something called
> bsearch_closest().
> 

While it makes sense to have a helper function for this the generic bsearch
is not a good solution for small arrays. The generated code is probably
larger and the function call overhead of calling the cmp function completely
outweighs the savings from doing a binary search. bsearch() is good if your
array has 100s or 1000s of entries. If it only has 5, not so much.
