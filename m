Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11873EB2984
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E48213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E48213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeGLScA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:32:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:38539 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbeGLScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:32:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 11:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,344,1526367600"; 
   d="scan'208";a="244790143"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2018 11:21:11 -0700
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
        Patrick Venture <venture@google.com>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
 <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
 <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <921b1ab7-9c9f-0aeb-da89-5a1a27d009f0@linux.intel.com>
Date:   Thu, 12 Jul 2018 11:21:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2018 2:33 AM, Brendan Higgins wrote:
> On Wed, Jun 27, 2018 at 10:55 AM Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>>
> <snip>
>>>> +/* Timeout for bus busy checking */
>>>> +#define BUS_BUSY_CHECK_TIMEOUT                         250000 /* 250ms */
>>>> +#define BUS_BUSY_CHECK_INTERVAL                                10000  /* 10ms */
>>>
>>> Could you add a comment on where you got these values from?
>>>
>>
>> These are coming from ASPEED SDK code. Actually, they use 100ms for
>> timeout and 10ms for interval but I increased the timeout value to
>> 250ms so that it covers a various range of bus speed. I think, it
>> should be computed at run time based on the current bus speed, or
>> we could add these as device tree settings. How do you think about it?
>>
> 
> This should definitely be a device tree setting. If one of the busses is being
> used as a regular I2C bus, it could hold the bus for an unlimited amount of
> time before sending a STOP. As for a default, 100ms is probably fine given
> that, a) the limit will only apply to multi-master mode, and b) multi-master
> mode will probably almost always be used with IPMB, or MCTP (MCTP actually
> recommends a 100ms timeout for this purpose, see
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.1.0.pdf,
> symbol PT2a). That being said, if you actually want to implement IPMB, or MCTP
> arbitration logic, it is much more complicated.
> 

Okay then, I think, we can fix the timeout value to 100ms and enable the
bus busy checking logic only when 'multi-master' is set in device tree.
My thought is, no additional arbitration logic is needed because
arbitration is performed in H/W level and H/W reports
ASPEED_I2CD_INTR_ARBIT_LOSS when it fails acquiring a bus. The
ARBIT_LOSS event is already being handled well by this driver code you
implemented.

>>   >
> <snip>
>>>>    #if IS_ENABLED(CONFIG_I2C_SLAVE)
>>>> -       if (aspeed_i2c_slave_irq(bus)) {
>>>> -               dev_dbg(bus->dev, "irq handled by slave.\n");
>>>> -               return IRQ_HANDLED;
>>>> +       if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
>>>> +               if (!aspeed_i2c_master_irq(bus))
>>>
>>> Why do you check the slave if master fails (or vice versa)? I
>>> understand that there are some status bits that have not been handled,
>>> but it doesn't seem reasonable to assume that there is state that the
>>> other should do something with; the only way this would happen is if
>>> the state that you think you are in does not match the status bits you
>>> have been given, but if this is the case, you are already hosed; I
>>> don't think trying the other handler is likely to make things better,
>>> unless there is something that I am missing.
>>>
>>
>> In most of cases, interrupt bits are set one by one but there are also a
>> lot of other cases that ASPEED I2C H/W sends multiple interrupt bits
>> with combining master and slave events using a single interrupt call. It
>> happens much in multi-master environment than single-master. For
>> example, when master is waiting for a NORMAL_STOP interrupt in its
>> MASTER_STOP state, SLAVE_MATCH and RX_DONE interrupts could come along
>> with the NORMAL_STOP in case of an another master immediately sends data
>> just after acquiring the bus - it happens a lot in BMC-ME connection
>> practically. In this case, the NORMAL_STOP interrupt should be handled
>> by master_irq and the SLAVE_MATCH and RX_DONE interrupts should be
>> handled by slave_irq so it's the reason why this code is added.
> 
> That sucks. Well, it sounds like there are only a handful of cases in which
> this can happen. Maybe enumerate these cases and error out or at least warn if
> it is not one of them?
> 

Yes, that sucks but that is Aspeed's I2C IP behavior and that's the
reason why they implemented some combination bits handling code in
their SDK. Actually, the cases are happening somewhat frequently
but that would not be a problem if we handle the cases properly instead
of making error out or warn.

>>
> <snip>
>>>> +       for (;;) {
>>>> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
>>>> +                     (ASPEED_I2CD_BUS_BUSY_STS |
>>>> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))
>>>
>>> Is using the Transfer Mode State Machine bits necessary? The
>>> documentation marks it as "for debugging purpose only," so relying on
>>> it makes me nervous.
>>>
>>
>> As you said, the documentation marks it as "for debugging purpose only."
>> but ASPEED also uses this way in their SDK code because it's the best
>> way for checking bus busy status which can cover both single and
>> multi-master use cases.
>>
> 
> Well, it would also be really nice to have access to this bit if someone wants
> to implement MCTP. Could we maybe check with Aspeed what them meant by "for
> debugging purposes only" and document it here? It makes me nervous to rely on
> debugging functionality for normal usage.
> 

Okay, I'll check it with Aspeed. Will let you know their response.

>>>> +                       return 0;
>>>> +               if (ktime_compare(ktime_get(), timeout) > 0)
>>>> +                       break;
>>>> +               usleep_range((BUS_BUSY_CHECK_INTERVAL >> 2) + 1,
>>>
>>> Where did you get this minimum value?
>>>
>>
>> No source for the minimum value. ASPEED uses mdelay(10) in their SDK
>> but I changed that code using usleep_range and the range value was set
>> with considering time stretching of usleep_range.
>> regmap_read_poll_timeout was a reference for this code.
> 
> What protocol are you trying to implement on top of this? You mentioned BMC-ME
> above; that's IPMB, right? For most use cases, this should work, but if you
> need arbitration, you will need to do quite a bit more work.
> 

Yes, I'm implementing IPMB for a BMC-ME channel. As I said above,
arbitration will be performed in H/W level and it's already been handled
well by your code. This bus busy checking logic is for checking whether
any slave operation is currently ongoing or not at the timing of
master_xfer is called. It's not for arbitration but for preventing state
conflicts between master and slave operations.

FYI, I broke down this patch into smaller patches you reviewed
Today. Thanks for sharing your time for reviewing the patches.
I'll send remaining patches after completing review on those
patches because the remaining patches have dependency on them.

Thanks!

>>
>> Thanks,
>>
>> Jae
> <snip>
> 
> Cheers
> 
