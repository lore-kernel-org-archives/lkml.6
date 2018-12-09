Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CDDC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF34920837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF34920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLIVqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:46:24 -0500
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:51107 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:46:23 -0500
Received: from [78.134.66.95] (port=60912 helo=[192.168.77.57])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1gW6u1-005XM0-4s; Sun, 09 Dec 2018 22:46:17 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
To:     Peter Rosin <peda@axentia.se>,
        Luca Ceresoli <lucaceresoli77@gmail.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
References: <20181003151928.17713-1-lucaceresoli77@gmail.com>
 <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
 <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
 <205e1d73-2318-ecd4-c531-3ff18a0e0005@lucaceresoli.net>
 <55ea59c5-ac9b-ab78-e3a1-edaed099ca15@axentia.se>
Message-ID: <b35ced90-a905-7bd9-e9d4-4b5e6a0207c4@lucaceresoli.net>
Date:   Sun, 9 Dec 2018 22:46:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <55ea59c5-ac9b-ab78-e3a1-edaed099ca15@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

after some pondering, find below my reply.

On 27/11/18 19:51, Peter Rosin wrote:
> On 2018-11-18 12:13, Luca Ceresoli wrote:
>> Hi Peter,
>>
>> On 10/10/18 17:48, Luca Ceresoli wrote:
>>> Hi Peter,
>>>
>>> On 08/10/2018 23:43, Peter Rosin wrote:
>>>> On 2018-10-03 17:19, Luca Ceresoli wrote:
>>>>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>>>>
>>>>> i2c-mux instantiates one i2c_algorithm for each downstream adapter.
>>>>> However these algorithms are all identical, depending only on the
>>>>> parent adapter.
>>>>>
>>>>> Avoid duplication by hoisting the i2c_algorithm from the adapters to
>>>>> the i2c_mux_core object, and reuse it in all the adapters.
>>>>
>>>> Ouch, while I like the concept of having one i2c_algorithm per mux,
>>>> this patch is not working. Various i2c-mux drivers set the
>>>> muxc->mux_locked variable *after* the i2c_mux_alloc call, and this
>>>> patch breaks such use.
>>
>> I finally had a look into this issue. Three drivers are setting
>> mux_locked after i2c_mux_alloc: i2c-mux-gpmux, i2c-mux-gpio and
>> i2c-mux-pinctrl.
>>
>> i2c-mux-gpmux is trivial to fix.
>>
>> The other two are not trivial because:
>>
>>  1. they compute mux_locked from other variables
>>  2. those variables are stored in the drivers "private" data
>>  3. their private data is stored inside struct i2c_mux_core
>>     (muxc->priv) which exists only after i2c_mux_alloc()
>>
>> In those cases computing mux_locked before i2c_mux_alloc() involves
>> quite invasive changes. It took 3 non-trivial commits just for
>> i2c-mux-gpio, and I still have to look into i2c-mux-pinctrl.
>>
>> So the question is: do we really want to do this?
>>
>> Using the private storage provided by i2c_mux_alloc() is a handy
>> feature, at least for simpler drivers which know in advance the flags
>> they need to set. OTOH I don't like individual drivers to manipulate
>> mux_core flags that look very much like internal data. It makes any
>> change to the i2c mux core harder, since every changed line could have
>> side effects in some drivers, which is what's happening here.
>>
>> What's your opinion about this issue?
> 
> I obviously don't like that drivers are poking around in struct
> i2c_mux_core.
> 
> But, your description sounds precisely how I remembered it. The
> underlying problem is of course that i2c-mux-gpio and
> i2c-mux-pinctrl do really nasty digs into internal parts of the
> gpio and the pinctrl subsystems as they *try* to figure out if
> they should be mux-locked or parent-locked. The result of that
> digging is not completely reliable, but it solves the issue
> without help from device-tree properties in at least one case
> that I know about. However, for that case I also know that there
> is no risk of regression since I control the distribution of
> both kernel and .dtb for any upgrade. Anyway, it was done like
> it was since I at the time did not dare to question the feedback
> from the device-tree camp, and actually thought it was a good
> thing, and thus did not push for a device-tree property when
> Rob complained about the property not describing HW and instead
> was just working around kernel issues [1]. The mux-locked vs.
> parent-locked property has been added since. In retrospect, the
> whole attempt to auto-detect mux-locked or parent-locked was a
> mistake, and everything would have been so much easier if the
> device-tree could always just state what the requirement is. At
> least that's my current thoughts on the matter. Maybe we should
> attempt to remove the ugly auto-detect code and see if anyone
> complains?

I'd love to remove that code, but this would change existing behavior,
and the change would go unnoticed until something breaks. Scary.

What about requiring that either "mux-locked" or "parent-locked" is
specified in DT? If none is specified, the driver would fail loudly at
probe time and users would stop and fix their DT. Then of course they
need to _upgrade_ their DT in existing products.

> But of course, another aspect is that not everything is DT, so
> perhaps there is no clean solution?

Well, platform code would have to be changed like DT, adding 2 flags:
mux-locked and parent-locked, and exactly one must be set.

This seems to me the safest path. Do you think it is a good idea,
especially with respect to the device tree camp?

Thanks,
-- 
Luca
