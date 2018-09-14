Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549DBFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2322083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2322083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeINWJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:09:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:61672 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbeINWJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:09:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 09:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="80495170"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.151]) ([10.7.153.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Sep 2018 09:52:35 -0700
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org
References: <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
 <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
 <20180913155703.GA22605@roeck-us.net>
 <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
 <b4da2b68-e6e3-e068-cd6e-9e638aa67889@roeck-us.net>
 <ccbf7059-77fd-44e8-daee-516582814cb3@kaod.org>
 <94a2aa4e-69ac-7042-92d9-1ada46d5fc33@roeck-us.net>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <3e319dd0-17e6-679d-18fd-43ed59f7075d@linux.intel.com>
Date:   Fri, 14 Sep 2018 09:52:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <94a2aa4e-69ac-7042-92d9-1ada46d5fc33@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2018 6:23 AM, Guenter Roeck wrote:
> On 09/13/2018 10:38 PM, Cédric Le Goater wrote:
>>>>> That seems to suggest that none of the status bits auto-clears, and 
>>>>> that
>>>>> the above code clearing intr_status should be removed entirely.
>>>>> Am I missing something ?
>>>>
>>>> You are right. I just pushed another version of the previous patch 
>>>> with this
>>>> new hunk :
>>>>
>>>> @@ -188,7 +200,6 @@ static void aspeed_i2c_bus_handle_cmd(As
>>>>    {
>>>>        bus->cmd &= ~0xFFFF;
>>>>        bus->cmd |= value & 0xFFFF;
>>>> -    bus->intr_status = 0;
>>>>          if (bus->cmd & I2CD_M_START_CMD) {
>>>>            uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
>>>>
>>>>
>>>> The QEMU palmetto and witherspoon machines seem to behave fine. Can 
>>>> you give
>>>> it a try ?
>>>>
>>>
>>> Works fine for me for all affected qemu platforms.
>>>
>>> How do you want to proceed with the qemu patches ? I attached my patches
>>> for reference. Maybe you can add them to your tree if they are ok and 
>>> submit
>>> the entire series together to the qemu mailing list ?
>>
>> yes. They are pushed in my aspeed-3.1 branch. I will send the series
>> on the list.
>>
> 
> Excellent. Thanks a lot!
> 
> Guenter
> 

Awesome! Many thanks to Guenter, Cédric and Joel. I really appreciate
it.

Jae
