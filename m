Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB82ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138382087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138382087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbeGMTKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:10:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:6781 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbeGMTKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:10:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 11:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,348,1526367600"; 
   d="scan'208";a="245522067"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2018 11:54:24 -0700
Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        james.feist@linux.intel.com, vernon.mauery@linux.intel.com,
        Benjamin Fair <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>, gary_hsu@aspeedtech.com,
        Ryan Chen <ryan_chen@aspeedtech.com>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
 <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
 <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
 <921b1ab7-9c9f-0aeb-da89-5a1a27d009f0@linux.intel.com>
 <d3f10fc1-635b-3a5d-a967-2816eac005fc@linux.intel.com>
 <CAFd5g47zdPdqqjVJtNHtFk+jKgciKbMcEH9M-W9rL4DgLM5hkg@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <b8232faa-58f5-f3a5-d12a-3f326cf1d03d@linux.intel.com>
Date:   Fri, 13 Jul 2018 11:54:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47zdPdqqjVJtNHtFk+jKgciKbMcEH9M-W9rL4DgLM5hkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/2018 11:12 AM, Brendan Higgins wrote:
> On Fri, Jul 13, 2018 at 10:22 AM Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> On 7/12/2018 11:21 AM, Jae Hyun Yoo wrote:
>>> On 7/12/2018 2:33 AM, Brendan Higgins wrote:
>>>> On Wed, Jun 27, 2018 at 10:55 AM Jae Hyun Yoo
>>>> <jae.hyun.yoo@linux.intel.com> wrote:
> <snip>
>>>> <snip>
>>>>>>> +       for (;;) {
>>>>>>> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
>>>>>>> +                     (ASPEED_I2CD_BUS_BUSY_STS |
>>>>>>> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))
>>>>>>
>>>>>> Is using the Transfer Mode State Machine bits necessary? The
>>>>>> documentation marks it as "for debugging purpose only," so relying on
>>>>>> it makes me nervous.
>>>>>>
>>>>>
>>>>> As you said, the documentation marks it as "for debugging purpose only."
>>>>> but ASPEED also uses this way in their SDK code because it's the best
>>>>> way for checking bus busy status which can cover both single and
>>>>> multi-master use cases.
>>>>>
>>>>
>>>> Well, it would also be really nice to have access to this bit if
>>>> someone wants
>>>> to implement MCTP. Could we maybe check with Aspeed what them meant by
>>>> "for
>>>> debugging purposes only" and document it here? It makes me nervous to
>>>> rely on
>>>> debugging functionality for normal usage.
>>>>
>>>
>>> Okay, I'll check it with Aspeed. Will let you know their response.
>>>
>>
>> I've checked it with Gary Hsu <gary_hsu@aspeedtech.com> and he confirmed
>> that the bits reflect real information and good to be used in practical
>> code.
> 
> Huh. For my own edification, could you ask them why they said "for debugging
> purpose only" in the documentation? I am just really curious what they meant by
> that. I would be satisfied if you just CC'ed me on your email thread with Gary,
> and I can ask him myself.
> 

I've already CC'ed Gary and Ryan in this thread.

Hi Gary,

Can you explain why the documentation says that the bit field is 'for
debugging purpose only'? Any plan to change the description?

Thanks,

Jae

>>
>> I'll add a comment like below:
>>
>> /*
>>    * This is marked as 'for debugging purpose only' in datasheet but
>>    * ASPEED confirmed that this reflects real information and good
>>    * to be used in practical code.
>>    */
>>
>> Is it acceptable then?
> 
> Yeah, that's fine.
> 
> <snip>
> 
> Cheers
> 
