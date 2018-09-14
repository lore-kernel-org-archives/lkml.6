Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2448BFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66820866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB66820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeINL2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:28:55 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:50379 "EHLO
        4.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeINL2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:28:55 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2018 07:28:54 EDT
Received: from player761.ha.ovh.net (unknown [10.109.160.253])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6776D2D262
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:38:52 +0200 (CEST)
Received: from zorba.kaod.org (LFbn-1-10605-110.w90-89.abo.wanadoo.fr [90.89.196.110])
        (Authenticated sender: postmaster@kaod.org)
        by player761.ha.ovh.net (Postfix) with ESMTPSA id A842F4800A4;
        Fri, 14 Sep 2018 07:38:37 +0200 (CEST)
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
 <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
 <b4da2b68-e6e3-e068-cd6e-9e638aa67889@roeck-us.net>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ccbf7059-77fd-44e8-daee-516582814cb3@kaod.org>
Date:   Fri, 14 Sep 2018 07:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b4da2b68-e6e3-e068-cd6e-9e638aa67889@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5290603662555188096
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrjeejgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> That seems to suggest that none of the status bits auto-clears, and that
>>> the above code clearing intr_status should be removed entirely.
>>> Am I missing something ?
>>
>> You are right. I just pushed another version of the previous patch with this
>> new hunk :
>>
>> @@ -188,7 +200,6 @@ static void aspeed_i2c_bus_handle_cmd(As
>>   {
>>       bus->cmd &= ~0xFFFF;
>>       bus->cmd |= value & 0xFFFF;
>> -    bus->intr_status = 0;
>>         if (bus->cmd & I2CD_M_START_CMD) {
>>           uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
>>
>>
>> The QEMU palmetto and witherspoon machines seem to behave fine. Can you give
>> it a try ?
>>
> 
> Works fine for me for all affected qemu platforms.
> 
> How do you want to proceed with the qemu patches ? I attached my patches
> for reference. Maybe you can add them to your tree if they are ok and submit
> the entire series together to the qemu mailing list ?

yes. They are pushed in my aspeed-3.1 branch. I will send the series 
on the list.

Thanks,

C. 


