Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3168AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5A72085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfAaPbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:31:19 -0500
Received: from relay.sw.ru ([185.231.240.75]:50176 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfAaPbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:31:19 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gpEIu-00038D-PR; Thu, 31 Jan 2019 18:31:00 +0300
Subject: Re: [PATCH] net: check negative value for signed refcnt
To:     Alexandre BESNARD <alexandre.besnard@softathome.com>
Cc:     davem@davemloft.net, amritha nambiar <amritha.nambiar@intel.com>,
        lirongqing@baidu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        alexander h duyck <alexander.h.duyck@intel.com>,
        jiri@mellanox.com, petrm@mellanox.com, ecree@solarflare.com
References: <20190131132008.23161-1-alexandre.besnard@softathome.com>
 <8b654b17-f8b4-0c89-26b5-311aeb703f6d@virtuozzo.com>
 <561703429.2347936.1548947660762.JavaMail.zimbra@softathome.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <323a3fc6-7aed-8ead-89aa-ee6af07f5c26@virtuozzo.com>
Date:   Thu, 31 Jan 2019 18:31:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <561703429.2347936.1548947660762.JavaMail.zimbra@softathome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.2019 18:14, Alexandre BESNARD wrote:
> Hi Kirill, and thanks for your time,
> 
> On 31 Jan 19 14:49, Kirill Tkhai ktkhai@virtuozzo.com wrote :
> 
>> Hi, Alexandre,
> 
>> On 31.01.2019 16:20, alexandre.besnard@softathome.com wrote:
>>> From: Alexandre Besnard <alexandre.besnard@softathome.com>
> 
>>> Device remaining references counter is get as a signed integer.
> 
>>> When unregistering network devices, the loop waiting for this counter
>>> to decrement tests the 0 strict equality. Thus if an error occurs and
>>> two references are given back by a protocol, we are stuck in the loop
>>> forever, with a -1 value.
> 
>>> Robustness is added by checking a negative value: the device is then
>>> considered free of references, and a warning is issued (it should not
>>> happen, one should check that behavior)
> 
>>> Signed-off-by: Alexandre Besnard <alexandre.besnard@softathome.com>
>>> ---
>>> net/core/dev.c | 5 +++++
>>> 1 file changed, 5 insertions(+)
> 
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index ddc551f..e4190ae 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -8687,6 +8687,11 @@ static void netdev_wait_allrefs(struct net_device *dev)
>>> refcnt = netdev_refcnt_read(dev);
> 
>>> while (refcnt != 0) {
>>> + if (refcnt < 0) {
>>> + pr_warn("Device %s refcnt negative: device considered free, but it should not
>>> happen\n",
>>> + dev->name);
>>> + break;
>>> + }
> 
>> 1)I don't think this is a good approach. Negative value does not guarantee
>> there is just a double put of device reference. Negative value is an indicator
>> something goes wrong, and we definitely should not free device memory in
>> this case.
> 
>> 2)Not related to your patch -- it looks like we have problem in existing
>> code with this netdev_refcnt_read(). It does not imply a memory ordering
>> or some guarantees about reading percpu values. For example, in generic
>> code struct percpu_ref switches a counter into atomic mode before it checks
>> for the last reference. But there is nothing in netdev_refcnt_read().
> 
> I agree with you, as it is not a full fix for a bad behavior of the refcnt: many
> wrong things could happen here, and that's why I added a warning (short of a
> more critical flag I could think of).
> 
> However, I think this is a good approach as a global workaround for any critical
> situation caused by a negative refcnt, acting as a failsafe. What I try to avoid
> here is not the bug, but a situation such as a deadlock keeping a system from
> powering off, or way worse in the system life.
> On the other hand, I can't think of a critical situation caused by freeing
> the device memory. Processes or even systems may crash in some cases, but it
> should be an expected behavior in such a case IMHO.
>
> Actually, I think that with the current implementation, most of the systems
> locked in the problem are powered off.
> 
> Do you think of any issue beyond this behavior ? 

The problem is that network devices are destroyed not only during reboot
of the system. For example, this happens every time network namespace dies.
And nobody wants to have network device memory is released in some undefined
condition, while system is continuing to run.

I see two approaches there. First one is to crash the system in case of
refcounter is not released for a long time (which is user-defined parameter).
The second one is to set the counter to INT_MAX/2 or something like this,
and never release this memory (we do especially this in our virtuozzo 7 kernel).

Maybe there are more solutions and another people will say about them.

Kirill



