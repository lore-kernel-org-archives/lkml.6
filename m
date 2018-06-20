Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31461C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E920020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E920020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeFTJsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:48:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34246 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFTJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:48:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so2608220wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YgBIEGdAMbo9e4vk3yVRteuoXK5uNuntRMjDXlupZRY=;
        b=khqfz6DYfwIVsYIV8Lz+VuFzjFt/jz/sWaEKD4EG7sCMaLYvnM0SKbmLQVn/L3whxO
         LeGxUTxRR01KWYzhVIMgGJ4IlkHvtU61KigT/ywjx+vQ2EwnYPAThwMRL7iJ7vlzkWbd
         Fxve3JFrthiy/nKxCUNl+NLatk4oUTcpMDVa9KvZerqRpUAxL8hGbqN6E3KGUe7aPpJ+
         ZW1PnrNWVEPu7k8B07onqYSRRf2a7HDY8bMjhzdqHOCjTxohWOw0uh1KQ5BVWL1vaIjy
         2u7XK4wXIm+Fk2qxJdWJib5rLPwoe9U5JTb5sCFauLa6OkLroY5IEps469lU/ogGHLZz
         ODTg==
X-Gm-Message-State: APt69E2GdlFnN3riFHkBkTRAg31J9Pvue8PNuuThYGvBe5Z2X+1RWyfQ
        8DVKdF3TMI4Te4WRnkPFaNIJ6A==
X-Google-Smtp-Source: ADUXVKI2WsGx4GwhvUtu0XD+p/b1RunBaPljjqQRl6x7ys7MDzA6La8B/dTGGmX1ynBJ07jQ3LHflA==
X-Received: by 2002:a5d:44ca:: with SMTP id z10-v6mr17998985wrr.210.1529488085493;
        Wed, 20 Jun 2018 02:48:05 -0700 (PDT)
Received: from [10.201.33.7] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id n18-v6sm2035580wrj.58.2018.06.20.02.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 02:48:04 -0700 (PDT)
Subject: Re: [PATCH] driver core: add a debugfs entry to show deferred devices
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
 <ea628ded-3cb3-c426-da6d-bf7cb51f4ca8@redhat.com>
Message-ID: <91484651-b5ab-c971-e66e-92d268fd65c0@redhat.com>
Date:   Wed, 20 Jun 2018 11:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ea628ded-3cb3-c426-da6d-bf7cb51f4ca8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Peter Robinson - Fedora IoT Architect to cc list]

On 06/20/2018 10:46 AM, Javier Martinez Canillas wrote:
> On 06/20/2018 12:51 AM, Greg Kroah-Hartman wrote:
> 
> [snip]
> 
>>> @@ -233,6 +252,9 @@ void device_unblock_probing(void)
>>>   */
>>>  static int deferred_probe_initcall(void)
>>>  {
>>> +	debugfs_create_file("deferred_devices", 0444, NULL, NULL,
>>> +			    &deferred_devs_fops);
>>
>> In the root of debugfs?
>>
> 
> I added in the root for lack of a better place. Any suggestion is welcomed.
>  
>> Anyway, what about "devices_deferred", to help keep things semi-sane if
>> we have other driver core debugfs entries?
>>
> 
> I don't have a strong opinion on the name really, so I'll change it.
>  
>> And you don't remove the file ever?
>>
> 
> Yeah, I saw that it wasn't removed in other places for debugfs entries
> created by the core since unlike drivers they can't be built as a module
> or re-loaded. But you are right, I'll add an __exitcall to remove there.
>  
>> And what is the use of this file?  What can you do with this
>> information?  Who is going to use it?  Don't we have other deferred
> 
> This patch is the result of a discussion with Tomeu and Mark (cc'ed) to
> allow https://kernelci.org to test if there was a regression that makes
> drivers to defer their probe.
> 
> The problem with the probe deferral mechanism is that you don't have a
> way to distinguish between a valid deferral due a dependency not being
> available yet and a bug (i.e: wrong DTB, config symbol not enabled, etc)
> that prevents the device to eventually being probed.
>

This is not only useful for catching regressions though, Peter also told me
that having this information would save him a lot of time when doing hardware
bringup for ARM devices / IoT platforms.

As mentioned, debugging probe deferral issues caused by drivers not available
or wrong Device Trees is really a PITA. Not all architectures have the luxury
of ACPI / PnP / auto enumerable buses / etc, that hide all this complexity.

So the most information to troubleshoot we have, the better in my opinion.

>> probe debugging somewhere else?
>>
> 
> There is some debug yes, but it isn't suitable for the use case I explained.
> 
> For start, it only tells you if a given driver for a device was deferred or
> probed correctly while this patch attempts to tell what was left (if any)
> in the queue after the last driver was registered.
> 
> Second, is only enabled until late_initcall so it will only print the probe
> deferral for built-in drivers and not for modules. This patch registers the
> debugfs entry after the probe debugging has been disabled.
> 
>> thanks,
>>
>> greg k-h
>>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
