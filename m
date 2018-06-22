Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277AAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D27248FB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jyxPek+v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jyxPek+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D27248FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeFVVWb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:22:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeFVVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:22:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C080F60791; Fri, 22 Jun 2018 21:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529702549;
        bh=47at7Z0OwYB2ExnmsJY6L1enuO6Xiai5/Qv+1iuN5rU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jyxPek+vu/Vce95CS/ser45LkuzMHFJO93Ne7GMDXCQqb6KV2qle7jxGCgdAB2nUO
         dFj1byP7RP61hxShD7lHBbbJtWuiZOewD1Ty/Lk8wxyTwTpKAnr1vtutK1wSDrRADk
         WGh5dwLZXJq6rAjtVeVbtK1YmVFSnvMs7HiNf7vI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5E67F604A6;
        Fri, 22 Jun 2018 21:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529702549;
        bh=47at7Z0OwYB2ExnmsJY6L1enuO6Xiai5/Qv+1iuN5rU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jyxPek+vu/Vce95CS/ser45LkuzMHFJO93Ne7GMDXCQqb6KV2qle7jxGCgdAB2nUO
         dFj1byP7RP61hxShD7lHBbbJtWuiZOewD1Ty/Lk8wxyTwTpKAnr1vtutK1wSDrRADk
         WGh5dwLZXJq6rAjtVeVbtK1YmVFSnvMs7HiNf7vI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Jun 2018 02:52:29 +0530
From:   akhilpo@codeaurora.org
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
In-Reply-To: <1e792d3c972998f92109c127886243e32c4cde71.camel@collabora.com>
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
 <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
 <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org>
 <1e792d3c972998f92109c127886243e32c4cde71.camel@collabora.com>
Message-ID: <7c67974e40afd15abfca5907b27de097@codeaurora.org>
X-Sender: akhilpo@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-22 22:43, Ezequiel Garcia wrote:
> Hey Akhil,
> 
> On Fri, 2018-06-22 at 12:33 +0530, Akhil P Oommen wrote:
>> On 6/22/2018 6:41 AM, Ezequiel Garcia wrote:
>> > Hey Enric,
>> >
>> > On Fri, 2018-06-22 at 00:04 +0200, Enric Balletbo i Serra wrote:
>> > > When the devfreq driver and the governor driver are built as
>> > > modules,
>> > > the call to devfreq_add_device() or governor_store() fails
>> > > because
>> > > the
>> > > governor driver is not loaded at the time the devfreq driver
>> > > loads.
>> > > The
>> > > devfreq driver has a build dependency on the governor but also
>> > > should
>> > > have a runtime dependency. We need to make sure that the governor
>> > > driver
>> > > is loaded before the devfreq driver.
>> > >
>> > > This patch fixes this bug by adding a try_then_request_governor()
>> > > function. First tries to find the governor, and then, if it is
>> > > not
>> > > found,
>> > > it requests the module and tries again.
>> > >
>> > > Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to
>> > > governor
>> > > using name)
>> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.c
>> > > om>
>> > > ---
>> > >
>> > > Changes in v3:
>> > > - Remove unneded change in dev_err message.
>> > > - Fix err returned value in case to not find the governor.
>> > >
>> > > Changes in v2:
>> > > - Add a new function to request the module and call that function
>> > > from
>> > >    devfreq_add_device and governor_store.
>> > >
>> > >   drivers/devfreq/devfreq.c | 65
>> > > ++++++++++++++++++++++++++++++++-----
>> > > --
>> >
>> > [snip snip]
>> > > -	governor = find_devfreq_governor(devfreq-
>> > > >governor_name);
>> > > +	governor = try_then_request_governor(devfreq-
>> > > > governor_name);
>> > >
>> > >   	if (IS_ERR(governor)) {
>> > >   		dev_err(dev, "%s: Unable to find governor for
>> > > the
>> > > device\n",
>> > >   			__func__);
>> > >   		err = PTR_ERR(governor);
>> > > -		goto err_init;
>> > > +		goto err_unregister;
>> > >   	}
>> > >
>> > > +	mutex_lock(&devfreq_list_lock);
>> > > +
>> >
>> > I know it's not something we are introducing in this patch,
>> > but still... calling a hook with a mutex held looks
>> > fishy to me.
>> >
>> > This lock should only protect the list, unless I am missing
>> > something.
>> >
>> > >   	devfreq->governor = governor;
>> > >   	err = devfreq->governor->event_handler(devfreq,
>> > > DEVFREQ_GOV_START,
>> > >   						NULL);
>> > > @@ -663,14 +703,16 @@ struct devfreq *devfreq_add_device(struct
>> > > device *dev,
>> > >   			__func__);
>> > >   		goto err_init;
>> > >   	}
>> > > +
>> > > +	list_add(&devfreq->node, &devfreq_list);
>> > > +
>> > >   	mutex_unlock(&devfreq_list_lock);
>> > >
>> > >   	return devfreq;
>> > >
>> > >   err_init:
>> > > -	list_del(&devfreq->node);
>> > >   	mutex_unlock(&devfreq_list_lock);
>> > > -
>> > > +err_unregister:
>> > >   	device_unregister(&devfreq->dev);
>> > >   err_dev:
>> > >   	if (devfreq)
>> > > @@ -988,12 +1030,13 @@ static ssize_t governor_store(struct
>> > > device
>> > > *dev, struct device_attribute *attr,
>> > >   	if (ret != 1)
>> > >   		return -EINVAL;
>> > >
>> > > -	mutex_lock(&devfreq_list_lock);
>> > > -	governor = find_devfreq_governor(str_governor);
>> > > +	governor = try_then_request_governor(str_governor);
>> > >   	if (IS_ERR(governor)) {
>> > > -		ret = PTR_ERR(governor);
>> > > -		goto out;
>> > > +		return PTR_ERR(governor);
>> > >   	}
>> > > +
>> > > +	mutex_lock(&devfreq_list_lock);
>> > > +
>> > >   	if (df->governor == governor) {
>> > >   		ret = 0;
>> > >   		goto out;
>> > > --
>> > > 2.17.1
>> > >
>> > >
>> >
>> > Regards,
>> > Eze
>> 
>> Adding to Ezequiel's point, shouldn't we take more granular lock
>> (devfreq->lock) first and then call devfreq_list_lock at the time of
>> adding to the list?
>> 
> 
> Not sure why we should do that. devfreq->lock should be used to
> protect the struct devfreq state, while the devfreq_list_lock
> is apparently protecting the two lists (which seem unrelated
> lists).
> 
> So, the two locks are not correlated.
> 
> Regards,
> Eze
In governor_store(), we do 'df->governor = governor;' without taking 
df->lock. So it is possible to switch governor while update_devfreq() is 
in progress. I smell trouble there. Don't you think so?
I am assuming df->lock protects 'struct devfreq' and devfreq_list_lock 
protects both device and governor lists.

-Akhil.
