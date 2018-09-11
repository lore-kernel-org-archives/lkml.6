Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E1320881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E1320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeILDUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:20:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:35543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeILDUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:20:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 15:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="82705870"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2018 15:18:27 -0700
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-aspeed@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
Date:   Tue, 11 Sep 2018 15:18:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911204107.GA26017@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 1:41 PM, Guenter Roeck wrote:
> On Tue, Sep 11, 2018 at 01:30:41PM -0700, Jae Hyun Yoo wrote:
>> On 9/11/2018 11:37 AM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Thu, Aug 23, 2018 at 03:57:31PM -0700, Jae Hyun Yoo wrote:
>>>> In most of cases, interrupt bits are set one by one but there are
>>>> also a lot of other cases that Aspeed I2C IP sends multiple
>>>> interrupt bits with combining master and slave events using a
>>>> single interrupt call. It happens much more in multi-master
>>>> environment than single-master. For an example, when master is
>>>> waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
>>>> SLAVE_MATCH and RX_DONE interrupts could come along with the
>>>> NORMAL_STOP in case of an another master immediately sends data
>>>> just after acquiring the bus. In this case, the NORMAL_STOP
>>>> interrupt should be handled by master_irq and the SLAVE_MATCH and
>>>> RX_DONE interrupts should be handled by slave_irq. This commit
>>>> modifies irq hadling logic to handle the master/slave combined
>>>> events properly.
>>>>
>>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>
>>> This patch causes a boot stall when booting witherspoon-bmc with
>>> qemu v3.0, and all i2c device probes fail with error -110 (timeout).
>>> Bisect log is attached for reference.
>>>
>>> With the same kernel configuration (aspeed_g5_defconfig),
>>> ast2500-evb and romulus-bmc are still able to boot.
>>> palmetto-bmc with aspeed_g4_defconfig also appears to work.
>>>
>>> Is this a problem with qemu ? Should I drop the qemu test
>>> for witherspoon-bmc starting with the next kernel release ?
>>>
>>> Thanks,
>>> Guenter
>>>
>>
>> Hi Guenter,
>>
>> Thanks for your report.
>>
>> I checked this patch again but it doesn't have any change that could
>> affect to the probing flow. I'll debug the issue on qemu 3.0 environment
>> and will share if I find something.
>>
> The problem may be that qemu and the new code disagree how interrupts
> should be generated and handled, and the new code does not handle the
> interrupts it receives from the simulated hardware. This will result
> in i2c device probe failure, which in turn can cause all kinds of
> problems.
> 

Yes, that makes sense. Looks like it should be reverted until the issue
is fixed. Will submit a patch to revert it.

Thanks,
Jae
