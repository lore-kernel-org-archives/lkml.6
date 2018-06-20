Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89FD208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89FD208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933136AbeFTIqn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:46:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51902 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932547AbeFTIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:46:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so4622727wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bibe9FKIjJoV7YWwhOdDFDdz/KIMW/Q6mbiJAU8uHr4=;
        b=Uz1eMS6j+uEDnmaX/mbro1cT2+QDif4twEvE61h9rhhtGLqcpRn7UXChwgrfINDhMx
         BwrCWoQ9z669yZs7ey8fLw8T/I7HTSMMlYeqgQv23LSkEYM++dASWvXN07iZvTvurQ++
         i0tp/nVJhRvN0EYuE6g17Bswhknv29eQo2VG3f4gF7l5OTFZOi3M3wEzTQXZbT9yVMK5
         biM17RgpNWSFwoo8FolGdFzA41n3DTt/1RUmr2NIDdaApT1w40t6975+oUJabyQybQ99
         rgde/xgi+NkKokuj9z/NwCcOKDF5bfXQMwLEC6RTeQmqSiVZvfcEFkFF/+rRjTgP/+dj
         +UvQ==
X-Gm-Message-State: APt69E1PAp3tiO2oO0AQOXQgd1umbpowdn6vJMczdk3j99+wC70sIGII
        YHuN8E4QCgHpFyAEr3soHxUZubP5nPg=
X-Google-Smtp-Source: ADUXVKK7cDhILSLAm+nFUe0LQbvYcg+KXSjOg0GAXsAK4TtqZ0z554zVb1nolYDZN41hig9eL+SAhg==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr927786wme.22.1529484397032;
        Wed, 20 Jun 2018 01:46:37 -0700 (PDT)
Received: from [10.201.33.7] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id h77-v6sm3399295wmd.9.2018.06.20.01.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:46:36 -0700 (PDT)
Subject: Re: [PATCH] driver core: add a debugfs entry to show deferred devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <ea628ded-3cb3-c426-da6d-bf7cb51f4ca8@redhat.com>
Date:   Wed, 20 Jun 2018 10:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619225145.GA23389@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 12:51 AM, Greg Kroah-Hartman wrote:

[snip]

>> @@ -233,6 +252,9 @@ void device_unblock_probing(void)
>>   */
>>  static int deferred_probe_initcall(void)
>>  {
>> +	debugfs_create_file("deferred_devices", 0444, NULL, NULL,
>> +			    &deferred_devs_fops);
> 
> In the root of debugfs?
>

I added in the root for lack of a better place. Any suggestion is welcomed.
 
> Anyway, what about "devices_deferred", to help keep things semi-sane if
> we have other driver core debugfs entries?
>

I don't have a strong opinion on the name really, so I'll change it.
 
> And you don't remove the file ever?
>

Yeah, I saw that it wasn't removed in other places for debugfs entries
created by the core since unlike drivers they can't be built as a module
or re-loaded. But you are right, I'll add an __exitcall to remove there.
 
> And what is the use of this file?  What can you do with this
> information?  Who is going to use it?  Don't we have other deferred

This patch is the result of a discussion with Tomeu and Mark (cc'ed) to
allow https://kernelci.org to test if there was a regression that makes
drivers to defer their probe.

The problem with the probe deferral mechanism is that you don't have a
way to distinguish between a valid deferral due a dependency not being
available yet and a bug (i.e: wrong DTB, config symbol not enabled, etc)
that prevents the device to eventually being probed.

> probe debugging somewhere else?
>

There is some debug yes, but it isn't suitable for the use case I explained.

For start, it only tells you if a given driver for a device was deferred or
probed correctly while this patch attempts to tell what was left (if any)
in the queue after the last driver was registered.

Second, is only enabled until late_initcall so it will only print the probe
deferral for built-in drivers and not for modules. This patch registers the
debugfs entry after the probe debugging has been disabled.

> thanks,
> 
> greg k-h
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
