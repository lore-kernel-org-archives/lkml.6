Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5AFA3752
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C6921756
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C6921756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIMWBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:01:55 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:59204 "EHLO
        10.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeIMWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:01:55 -0400
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 18:01:54 EDT
Received: from player714.ha.ovh.net (unknown [10.109.160.153])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9064DFA166
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 18:35:55 +0200 (CEST)
Received: from zorba.kaod.org (LFbn-1-10605-110.w90-89.abo.wanadoo.fr [90.89.196.110])
        (Authenticated sender: postmaster@kaod.org)
        by player714.ha.ovh.net (Postfix) with ESMTPSA id E79843C00AA;
        Thu, 13 Sep 2018 18:35:38 +0200 (CEST)
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
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
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
Date:   Thu, 13 Sep 2018 18:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913155703.GA22605@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10514497755225951104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrjeeigddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 05:57 PM, Guenter Roeck wrote:
> On Thu, Sep 13, 2018 at 05:48:59PM +0200, Cédric Le Goater wrote:
>> On 09/13/2018 03:33 PM, Guenter Roeck wrote:
> [ ... ]
>>>>>   /*
>>>>>    * The state machine needs some refinement. It is only used to track
>>>>>    * invalid STOP commands for the moment.
>>>>> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>>>>   {
>>>>>       bus->cmd &= ~0xFFFF;
>>>>>       bus->cmd |= value & 0xFFFF;
>>>>> -    bus->intr_status = 0;> +    bus->intr_status &= I2CD_INTR_RX_DONE;
>>>>
>>>> it deserves a comment to understand which scenario we are trying to handle.
>>>>    
>>>
>>> Ok. FWIW, I wonder if intr_status should be touched here in the first place,
>>> but I neither have the hardware nor a datasheet, so I don't know if any bits
>>> are auto-cleared.
>>
>> I just pushed a patch on my branch with some more explanation : 
>>
>> 	https://github.com/legoater/qemu/commits/aspeed-3.1
>>
> That seems to suggest that none of the status bits auto-clears, and that
> the above code clearing intr_status should be removed entirely.
> Am I missing something ?

You are right. I just pushed another version of the previous patch with this 
new hunk :

@@ -188,7 +200,6 @@ static void aspeed_i2c_bus_handle_cmd(As
 {
     bus->cmd &= ~0xFFFF;
     bus->cmd |= value & 0xFFFF;
-    bus->intr_status = 0;
 
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?


The QEMU palmetto and witherspoon machines seem to behave fine. Can you give 
it a try ?

Thanks,

C.
