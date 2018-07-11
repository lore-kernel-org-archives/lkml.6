Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE8EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C2720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C2720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbeGKRAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:00:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:2439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388080AbeGKRAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:00:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 09:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="54274734"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2018 09:54:44 -0700
Subject: Re: [PATCH] i2c: aspeed: Fix initial values of master and slave state
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
References: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45=SkyLWRy=DnYOZCXcmHkrbTdOSBi=n=kUgyvRPoU8Mg@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <37586a32-852c-9b18-cb01-a7448072527c@linux.intel.com>
Date:   Wed, 11 Jul 2018 09:54:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g45=SkyLWRy=DnYOZCXcmHkrbTdOSBi=n=kUgyvRPoU8Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2018 10:47 PM, Brendan Higgins wrote:
> On Mon, Jul 2, 2018 at 2:20 PM Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This patch changes the order of enum aspeed_i2c_master_state and
>> enum aspeed_i2c_slave_state defines to make their initial value to
>> ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
>> In case of multi-master use, if a slave data comes ahead of the
>> first master xfer, master_state starts from an invalid state so
>> this change fixes the issue.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   drivers/i2c/busses/i2c-aspeed.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index 60e4d0e939a3..2714c7fbe7c9 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -111,22 +111,22 @@
>>   #define ASPEED_I2CD_DEV_ADDR_MASK                      GENMASK(6, 0)
>>
>>   enum aspeed_i2c_master_state {
>> +       ASPEED_I2C_MASTER_INACTIVE,
>>          ASPEED_I2C_MASTER_START,
>>          ASPEED_I2C_MASTER_TX_FIRST,
>>          ASPEED_I2C_MASTER_TX,
>>          ASPEED_I2C_MASTER_RX_FIRST,
>>          ASPEED_I2C_MASTER_RX,
>>          ASPEED_I2C_MASTER_STOP,
>> -       ASPEED_I2C_MASTER_INACTIVE,
>>   };
>>
>>   enum aspeed_i2c_slave_state {
>> +       ASPEED_I2C_SLAVE_STOP,
>>          ASPEED_I2C_SLAVE_START,
>>          ASPEED_I2C_SLAVE_READ_REQUESTED,
>>          ASPEED_I2C_SLAVE_READ_PROCESSED,
>>          ASPEED_I2C_SLAVE_WRITE_REQUESTED,
>>          ASPEED_I2C_SLAVE_WRITE_RECEIVED,
>> -       ASPEED_I2C_SLAVE_STOP,
>>   };
>>
>>   struct aspeed_i2c_bus {
>> --
>> 2.17.1
>>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Thanks!
> 
> BTW, sorry for the delay, just got back from vacation. I will review
> the rest tomorrow.
> 

Thanks a lot for the review!

Jae
