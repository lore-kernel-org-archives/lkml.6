Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD2621582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jvjAhCX0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ICBJu285"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD2621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeHCAN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:13:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeHCAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:13:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AA8F36014B; Thu,  2 Aug 2018 22:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533248448;
        bh=/KFk1HoJaWlJ/uugnWjlRGJsE35J0i+AI9f7fA00zyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jvjAhCX0spHOj2lDZFuH2Rif0Yhw8yxiMjcRa+AU80VYByOzIvjmvDY66dH9K0G5i
         ah+yC0TzEG77QvmSHSSTdtP3wrO8ivNj/tc+d7OpBzPODI465+Qj0BxWFslUWkdhRl
         e7ri84pElXxqQPBWV6lkFgEY+ZqUglkIlVOS7wfs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DEC826014B;
        Thu,  2 Aug 2018 22:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533248447;
        bh=/KFk1HoJaWlJ/uugnWjlRGJsE35J0i+AI9f7fA00zyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ICBJu285zLZCZYLdIgzOYSbeIySkBpicceyAa/ayCAFoBBT/Oj3OKYhARPFg672Ii
         Vi3SPKRBLNuCO6i6N3g1R+t5AsdbTtd91PgfmsilEGbzKr98YH5mNf4QIn9iaJ2au/
         Dby01fX/KiIPI6UASGLd7ZQN8cn3WkXpqUsSewqU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 15:20:47 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rishabhb@codeaurora.org
Cc:     tsoni@codeaurora.org, Vikram Mulukutla <markivx@codeaurora.org>,
        linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every initcall
 level
In-Reply-To: <CA+tyz+6ZwtpKM=G5F2Do_sXWyo8r83ma19fWpn4HELiy0XT7=w@mail.gmail.com>
References: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
 <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com>
 <e4ca8572ed913ab65f63be8a351d4439@codeaurora.org>
 <CAJZ5v0ixuWo9RC21Z8zVhuHfkr1uV4vdqMh4s+qGMR7R8Wycag@mail.gmail.com>
 <68b90830d5024ce75a20b017aaf21c05@codeaurora.org>
 <CAJZ5v0jpm8tVjyWjA36Sp-bTEWUE+6cExjH7=CM=LUB-6xvePA@mail.gmail.com>
 <CA+tyz+6ZwtpKM=G5F2Do_sXWyo8r83ma19fWpn4HELiy0XT7=w@mail.gmail.com>
Message-ID: <de9fc0924f73bc26e067cce6c18d2714@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: RAFAEL J. WYSOCKI <rafael@kernel.org>
> Date: Wed, Aug 1, 2018 at 2:21 PM
> Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every
> initcall level
> To: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>, ckadabi@codeaurora.org,
> tsoni@codeaurora.org, Vikram Mulukutla <markivx@codeaurora.org>
> 
> On Wed, Aug 1, 2018 at 11:18 PM,  <rishabhb@codeaurora.org> wrote:
>> On 2018-07-24 01:24, Rafael J. Wysocki wrote:
>>> 
>>> On Mon, Jul 23, 2018 at 10:22 PM,  <rishabhb@codeaurora.org> wrote:
>>>> 
>>>> On 2018-07-23 04:17, Rafael J. Wysocki wrote:
>>>>> 
>>>>> 
>>>>> On Thu, Jul 19, 2018 at 11:24 PM, Rishabh Bhatnagar
>>>>> <rishabhb@codeaurora.org> wrote:
>>>>>> 
>>>>>> 
>>>>>> Drivers that are registered at an initcall level may have to
>>>>>> wait until late_init before the probe deferral mechanism can
>>>>>> retry their probe functions. It is possible that their
>>>>>> dependencies were resolved much earlier, in some cases even
>>>>>> before the next initcall level. Invoke one probe retry cycle
>>>>>> at every _sync initcall level, allowing these drivers to be
>>>>>> probed earlier.
>>>>> 
>>>>> 
>>>>> 
>>>>> Can you please say something about the actual use case this is
>>>>> expected to address?
>>>> 
>>>> 
>>>> We have a display driver that depends 3 other devices to be
>>>> probed so that it can bring-up the display. Because of
> dependencies
>>>> not being met the deferral mechanism defers the probes for a later
> time,
>>>> even though the dependencies might be met earlier. With this
> change
>>>> display can be brought up much earlier.
>>> 
>>> 
>>> OK
>>> 
>>> What runlevel brings up the display after the change?
>>> 
>>> Thanks,
>>> Rafael
>> After the change the display can come up after device_initcall level
>> itself.
>> The above mentioned 3 devices are probed at 0.503253, 0.505210 and
> 0.523264
>> secs.
>> Only the first device is probed successfully. With the current
>> deferral mechanism the devices get probed again after late_initcall
>> at 9.19 and 9.35 secs. So display can only come up after 9.35 secs.
>> With this change the devices are re-probed successfully at 0.60 and
>> 0.613 secs. Therefore display can come just after 0.613 secs.
> 
> OK, so why do you touch the initcall levels earlier than device_?
1)	re-probe probing devices in the active list on every level help to 
avoid circular dependency pending list.
2)	There are so many devices which gets deferred in earlier init call 
levels, so we wanted to reprobe them at every successive init call 
level.

> 
>> This change helps in overall android bootup as well.
> 
> How exactly?
We have seen less no of re-probes at late_init and most of the driver's 
dependency met earlier than late_init call level. It helped display and 
couple of other drivers by executing the re probe work at every init 
level.

-thanks, Prasad
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
