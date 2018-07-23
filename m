Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B1DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062F620856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JeRGBDCW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JeRGBDCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062F620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbeGWVZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:25:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeGWVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:25:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA6D760B11; Mon, 23 Jul 2018 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532377371;
        bh=bU+CKgAwEsEWCzrRu3uCoYtA5OT91d0Vh9r+FNoGh/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JeRGBDCWdwfVnkpSOoIjjSBUv8izcR6Y+wSJ7fN/AsBsnjLm2CHOobTLnoSjwBU0t
         iYk6VRlHE6GcEQkwLkiMxW4otZmmwzFE7LrZRjbWhKD6m2ymlJ0SE4WfaiDljhpg8s
         R3FXySe7wQhoNy73qXpBcYws4I7UEW9+Q9G7rMHE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 05A046021A;
        Mon, 23 Jul 2018 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532377371;
        bh=bU+CKgAwEsEWCzrRu3uCoYtA5OT91d0Vh9r+FNoGh/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JeRGBDCWdwfVnkpSOoIjjSBUv8izcR6Y+wSJ7fN/AsBsnjLm2CHOobTLnoSjwBU0t
         iYk6VRlHE6GcEQkwLkiMxW4otZmmwzFE7LrZRjbWhKD6m2ymlJ0SE4WfaiDljhpg8s
         R3FXySe7wQhoNy73qXpBcYws4I7UEW9+Q9G7rMHE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 13:22:50 -0700
From:   rishabhb@codeaurora.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        Vikram Mulukutla <markivx@codeaurora.org>, rjwysocki@gmail.com
Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every initcall
 level
In-Reply-To: <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com>
References: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
 <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com>
Message-ID: <e4ca8572ed913ab65f63be8a351d4439@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-23 04:17, Rafael J. Wysocki wrote:
> On Thu, Jul 19, 2018 at 11:24 PM, Rishabh Bhatnagar
> <rishabhb@codeaurora.org> wrote:
>> Drivers that are registered at an initcall level may have to
>> wait until late_init before the probe deferral mechanism can
>> retry their probe functions. It is possible that their
>> dependencies were resolved much earlier, in some cases even
>> before the next initcall level. Invoke one probe retry cycle
>> at every _sync initcall level, allowing these drivers to be
>> probed earlier.
> 
> Can you please say something about the actual use case this is
> expected to address?
We have a display driver that depends 3 other devices to be
probed so that it can bring-up the display. Because of dependencies
not being met the deferral mechanism defers the probes for a later time,
even though the dependencies might be met earlier. With this change
display can be brought up much earlier.
> 
>> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  drivers/base/dd.c | 33 +++++++++++++++++++++++++++------
>>  1 file changed, 27 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 1435d72..e6a6821 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -224,23 +224,44 @@ void device_unblock_probing(void)
>>         driver_deferred_probe_trigger();
>>  }
>> 
>> +static void enable_trigger_defer_cycle(void)
>> +{
>> +       driver_deferred_probe_enable = true;
>> +       driver_deferred_probe_trigger();
>> +       /*
>> +        * Sort as many dependencies as possible before the next 
>> initcall
>> +        * level
>> +        */
>> +       flush_work(&deferred_probe_work);
>> +}
>> +
>>  /**
>>   * deferred_probe_initcall() - Enable probing of deferred devices
>>   *
>>   * We don't want to get in the way when the bulk of drivers are 
>> getting probed.
>>   * Instead, this initcall makes sure that deferred probing is delayed 
>> until
>> - * late_initcall time.
>> + * all the registered initcall functions at a particular level are 
>> completed.
>> + * This function is invoked at every *_initcall_sync level.
>>   */
>>  static int deferred_probe_initcall(void)
>>  {
>> -       driver_deferred_probe_enable = true;
>> -       driver_deferred_probe_trigger();
>> -       /* Sort as many dependencies as possible before exiting 
>> initcalls */
>> -       flush_work(&deferred_probe_work);
>> +       enable_trigger_defer_cycle();
>> +       driver_deferred_probe_enable = false;
>> +       return 0;
>> +}
>> +arch_initcall_sync(deferred_probe_initcall);
>> +subsys_initcall_sync(deferred_probe_initcall);
>> +fs_initcall_sync(deferred_probe_initcall);
>> +device_initcall_sync(deferred_probe_initcall);
>> +
>> +static int deferred_probe_enable_fn(void)
>> +{
>> +       /* Enable deferred probing for all time */
>> +       enable_trigger_defer_cycle();
>>         initcalls_done = true;
>>         return 0;
>>  }
>> -late_initcall(deferred_probe_initcall);
>> +late_initcall(deferred_probe_enable_fn);
>> 
>>  /**
>>   * device_is_bound() - Check if device is bound to a driver
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
